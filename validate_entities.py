#!/usr/bin/env python3
"""
QKA entities.json referential integrity validator.

Checks the merged entity dataset for:
  1. Dangling references (relations / required_discoveries pointing
     to an ID that does not exist anywhere in the file)
  2. Duplicate IDs across any section
  3. Malformed verse references (wrong surah:ayah / surah:start-end syntax)
  4. Remaining review tags ([VERIFY], [TRADITIONAL], [CONFIRM ID EXISTS...])
     so they can be triaged before this ships
  5. Basic structural sanity (required fields present per entity type)

Usage:
    python3 validate_entities.py path/to/entities.json

Exit code 0 = no blocking errors (warnings may still exist).
Exit code 1 = at least one blocking error (dangling ref, duplicate ID,
              malformed verse ref, or missing required field).
"""

import json
import re
import sys
from collections import defaultdict


REVIEW_TAG_PATTERN = re.compile(r"\[(VERIFY|TRADITIONAL[^\]]*|CONFIRM ID EXISTS[^\]]*)\]")
VERSE_SINGLE_PATTERN = re.compile(r"^\d{1,3}:\d{1,3}$")
VERSE_RANGE_PATTERN = re.compile(r"^\d{1,3}:\d{1,3}-\d{1,3}$")
SURAH_MIN, SURAH_MAX = 1, 114


def load_dataset(path):
    with open(path, "r", encoding="utf-8") as f:
        try:
            return json.load(f)
        except json.JSONDecodeError as e:
            print(f"FATAL: could not parse JSON — {e}")
            sys.exit(1)


def collect_all_ids(data):
    """
    Walk every section and return:
      - a dict of id -> (section_name, raw_entry) for every entity-like
        object that has an "id" field
      - a list of (section_name, id) tuples for duplicates
    """
    id_map = {}
    duplicates = []

    def register(section_name, entry):
        entity_id = entry.get("id")
        if entity_id is None:
            return
        if entity_id in id_map:
            duplicates.append((section_name, entity_id))
        else:
            id_map[entity_id] = (section_name, entry)

    entities = data.get("entities", {})

    for char in entities.get("characters", []):
        register("entities.characters", char)

    for loc in entities.get("locations", []):
        register("entities.locations", loc)

    collections = entities.get("collections", {})
    for sub_key in ("animals", "plants", "foods"):
        for item in collections.get(sub_key, []):
            register(f"entities.collections.{sub_key}", item)

    for story in data.get("stories", []):
        register("stories", story)

    for theme in data.get("themes", []):
        register("themes", theme)

    for s in data.get("sets_and_combos", []):
        register("sets_and_combos", s)

    return id_map, duplicates


def strip_tag(ref):
    """Remove a trailing [VERIFY]/[TRADITIONAL]/etc tag from a reference
    string before checking if the underlying ID/verse is valid."""
    return REVIEW_TAG_PATTERN.sub("", ref).strip()


def find_review_tags(data):
    """Recursively walk the whole structure and return every string
    value that contains a review tag, with a breadcrumb path."""
    hits = []

    def walk(node, path):
        if isinstance(node, dict):
            for k, v in node.items():
                walk(v, f"{path}.{k}")
        elif isinstance(node, list):
            for i, v in enumerate(node):
                walk(v, f"{path}[{i}]")
        elif isinstance(node, str):
            if REVIEW_TAG_PATTERN.search(node):
                hits.append((path, node))

    walk(data, "root")
    return hits


def validate_verse_ref(ref):
    """
    Returns (is_valid, reason) for a single verse reference string,
    after stripping any review tag. Accepts "surah:ayah" or
    "surah:start-end" formats. Checks surah number is in 1..114.
    Does not validate ayah count per surah (would require an external
    surah metadata table) — flags this as a known limitation below.
    """
    clean = strip_tag(ref)

    if VERSE_SINGLE_PATTERN.match(clean):
        surah_str, ayah_str = clean.split(":")
        surah = int(surah_str)
        if not (SURAH_MIN <= surah <= SURAH_MAX):
            return False, f"surah {surah} out of range 1-114"
        return True, None

    if VERSE_RANGE_PATTERN.match(clean):
        surah_str, rest = clean.split(":")
        start_str, end_str = rest.split("-")
        surah = int(surah_str)
        start, end = int(start_str), int(end_str)
        if not (SURAH_MIN <= surah <= SURAH_MAX):
            return False, f"surah {surah} out of range 1-114"
        if start > end:
            return False, f"range start {start} is greater than end {end}"
        return True, None

    return False, f"does not match 'surah:ayah' or 'surah:start-end' syntax"


def validate_all_verse_refs(data):
    """Find every trigger_verses / completion_verses / xp_triggers.verse
    field anywhere in the file and validate syntax."""
    errors = []

    def check_list(refs, breadcrumb):
        if not isinstance(refs, list):
            errors.append((breadcrumb, f"expected a list, got {type(refs).__name__}"))
            return
        for i, ref in enumerate(refs):
            if not isinstance(ref, str):
                errors.append((f"{breadcrumb}[{i}]", f"expected a string, got {type(ref).__name__}"))
                continue
            ok, reason = validate_verse_ref(ref)
            if not ok:
                errors.append((f"{breadcrumb}[{i}] = '{ref}'", reason))

    entities = data.get("entities", {})

    for i, char in enumerate(entities.get("characters", [])):
        if "trigger_verses" in char:
            check_list(char["trigger_verses"], f"entities.characters[{i}] ({char.get('id', '?')}).trigger_verses")

    for i, loc in enumerate(entities.get("locations", [])):
        if "trigger_verses" in loc:
            check_list(loc["trigger_verses"], f"entities.locations[{i}] ({loc.get('id', '?')}).trigger_verses")

    collections = entities.get("collections", {})
    for sub_key in ("animals", "plants", "foods"):
        for i, item in enumerate(collections.get(sub_key, [])):
            if "trigger_verses" in item:
                check_list(item["trigger_verses"], f"entities.collections.{sub_key}[{i}] ({item.get('id', '?')}).trigger_verses")

    for i, story in enumerate(data.get("stories", [])):
        if "completion_verses" in story:
            check_list(story["completion_verses"], f"stories[{i}] ({story.get('id', '?')}).completion_verses")

    for i, theme in enumerate(data.get("themes", [])):
        for j, trig in enumerate(theme.get("xp_triggers", [])):
            verse = trig.get("verse")
            if verse is None:
                continue
            ok, reason = validate_verse_ref(verse)
            if not ok:
                errors.append((f"themes[{i}] ({theme.get('id', '?')}).xp_triggers[{j}].verse = '{verse}'", reason))

    return errors


def validate_references(data, id_map):
    """Check relations[] and required_discoveries[] point to real IDs."""
    dangling = []

    entities = data.get("entities", {})

    for i, char in enumerate(entities.get("characters", [])):
        for rel in char.get("relations", []):
            clean = strip_tag(rel)
            if clean not in id_map:
                dangling.append((
                    f"entities.characters[{i}] ({char.get('id', '?')}).relations",
                    rel,
                ))

    for i, s in enumerate(data.get("sets_and_combos", [])):
        for req in s.get("required_discoveries", []):
            clean = strip_tag(req)
            if clean not in id_map:
                dangling.append((
                    f"sets_and_combos[{i}] ({s.get('id', '?')}).required_discoveries",
                    req,
                ))

    return dangling


def validate_required_fields(data):
    """Spot-check that each entity type has the fields DiscoveryService
    and the schema expect. Missing fields are blocking errors because
    they will throw at parse time, not silently misbehave."""
    errors = []

    required_fields = {
        "entities.characters": ["id", "name", "type", "trigger_verses", "is_rare"],
        "entities.locations": ["id", "name", "trigger_verses", "coordinates_hint"],
        "entities.collections.animals": ["id", "name", "trigger_verses"],
        "entities.collections.plants": ["id", "name", "trigger_verses"],
        "entities.collections.foods": ["id", "name", "trigger_verses"],
        "stories": ["id", "name", "total_milestones", "related_surah", "completion_verses"],
        "themes": ["id", "name", "levels", "xp_triggers"],
        "sets_and_combos": ["id", "name", "required_discoveries", "reward_title", "is_hidden"],
    }

    entities = data.get("entities", {})
    sections = {
        "entities.characters": entities.get("characters", []),
        "entities.locations": entities.get("locations", []),
        "entities.collections.animals": entities.get("collections", {}).get("animals", []),
        "entities.collections.plants": entities.get("collections", {}).get("plants", []),
        "entities.collections.foods": entities.get("collections", {}).get("foods", []),
        "stories": data.get("stories", []),
        "themes": data.get("themes", []),
        "sets_and_combos": data.get("sets_and_combos", []),
    }

    for section_name, items in sections.items():
        fields = required_fields[section_name]
        for i, item in enumerate(items):
            missing = [f for f in fields if f not in item]
            if missing:
                errors.append((f"{section_name}[{i}] (id={item.get('id', '?')})", missing))

    return errors


def print_section(title, items, formatter, empty_message):
    print(f"\n{'─' * 60}")
    print(title)
    print("─" * 60)
    if not items:
        print(f"  {empty_message}")
        return
    for item in items:
        print(formatter(item))


def main():
    if len(sys.argv) != 2:
        print("Usage: python3 validate_entities.py path/to/entities.json")
        sys.exit(1)

    path = sys.argv[1]
    data = load_dataset(path)

    id_map, duplicates = collect_all_ids(data)
    dangling = validate_references(data, id_map)
    verse_errors = validate_all_verse_refs(data)
    missing_fields = validate_required_fields(data)
    review_tags = find_review_tags(data)

    total_entities = len(id_map)
    blocking_error_count = len(duplicates) + len(dangling) + len(verse_errors) + len(missing_fields)

    print("=" * 60)
    print("QKA ENTITY DATASET — REFERENTIAL INTEGRITY REPORT")
    print("=" * 60)
    print(f"File: {path}")
    print(f"Total entities with an ID: {total_entities}")

    print_section(
        "BLOCKING: Duplicate IDs",
        duplicates,
        lambda d: f"  ✗ id '{d[1]}' is defined more than once (section: {d[0]})",
        "None found — all IDs are unique.",
    )

    print_section(
        "BLOCKING: Dangling references (relations / required_discoveries)",
        dangling,
        lambda d: f"  ✗ {d[0]} references '{d[1]}' — this ID does not exist anywhere in the file",
        "None found — every relation and required_discoveries entry resolves to a real ID.",
    )

    print_section(
        "BLOCKING: Malformed verse references",
        verse_errors,
        lambda e: f"  ✗ {e[0]} — {e[1]}",
        "None found — all verse references match 'surah:ayah' or 'surah:start-end' syntax.",
    )

    print_section(
        "BLOCKING: Missing required fields",
        missing_fields,
        lambda e: f"  ✗ {e[0]} is missing: {', '.join(e[1])}",
        "None found — every entity has its required fields.",
    )

    print_section(
        "REVIEW NEEDED (non-blocking): [VERIFY] / [TRADITIONAL] / [CONFIRM ID...] tags",
        review_tags,
        lambda t: f"  ⚠ {t[0]} → \"{t[1]}\"",
        "None found — no outstanding review tags in the file.",
    )

    print("\n" + "=" * 60)
    if blocking_error_count == 0:
        print(f"RESULT: PASS — no blocking errors.")
        if review_tags:
            print(f"         {len(review_tags)} review tag(s) still need human sign-off")
            print(f"         before this ships — see the section above.")
    else:
        print(f"RESULT: FAIL — {blocking_error_count} blocking error(s) found.")
        print(f"         Fix these before loading this file into the app —")
        print(f"         they will break DiscoveryService at runtime or load time.")
    print("=" * 60)

    sys.exit(0 if blocking_error_count == 0 else 1)


if __name__ == "__main__":
    main()
