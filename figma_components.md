# Figma Component Dictionary — QKA Design System

This document specifies the complete set of reusable components in the Quran Knowledge Atlas (QKA) design system. Components are classified into Atoms, Molecules, and Organisms.

---

## Atoms

### EntityBadge
A geometric polygon shape that represents a specific class of Quranic entity.
- **Visuals**: strictly geometric multi-pointed stars or polygons (octagonal, hexagonal, etc.). *Never uses human figures or faces.*
- **Variants**: `prophet` | `location` | `nature` | `theme` | `matriarch`
- **Props**:
  - `entity_type` (Enum mapping to category colors)
  - `is_rare` (Boolean; if true, adds a gold double-outline and intricate internal patterns)
  - `size` (Enum: `sm` [24px] | `md` [48px] | `lg` [80px])
- **States**:
  - `discovered`: Fully colored and detailed.
  - `undiscovered`: Outlined with `neutral_200` / `undiscovered` color, content blurred with a lock icon.

### TypeLabel
A small text tag showing the category of the entity.
- **Props**:
  - `text` (String, e.g., "PROPHET", "LOCATION")
  - `entity_type` (Enum: controls text and background fill color)
- **Size**: Font size 11px, bold, 1px character tracking. Rounded corners: `radius_sm` (4px).

### ProgressBar
A minimal bar indicating progress.
- **Variants**: `linear` (used in Continue Reading cards and XP rows) | `circular` (used in stats rings)
- **Props**:
  - `value` (Double: 0.0 to 1.0)
  - `color_override` (Color; defaults to `teal_400`)
- **States**: `active` | `complete` (triggers transition to solid green/teal fill)

### StreakIndicator
A visual block showing the consecutive reading days.
- **Visuals**: A hand-drawn vector illustration of a small growing green plant on top of an open book. *Never uses fire/flame icons.*
- **Props**:
  - `day_count` (Integer)
  - `label_text` (String; defaults to "Days of Reading")
- **States**:
  - `active` (Plant is green and growing, text is highlighted)
  - `inactive` (Plant is slightly wilted/grayed, streak is at 0)

### XpBar
A stylized theme progress bar.
- **Props**:
  - `theme_name` (String, e.g., "Patience")
  - `current_xp` (Integer)
  - `max_xp` (Integer)
  - `percent_label` (String, e.g., "75%")

### AyahNumber
A small, circular visual badge holding the verse number.
- **Props**:
  - `surah_num` (Integer)
  - `ayah_num` (Integer)
- **Style**: Centered circular badge, background `neutral_100`, text `neutral_600` (size-caption: 12px).

### FilterChip
An interactive button chip for filtering lists or graphs.
- **Props**:
  - `label` (String)
  - `is_active` (Boolean)
- **States**:
  - `active`: Solid `teal_400` background, white text.
  - `inactive`: Outlined with `neutral_200` border, `neutral_600` text. (On the dark Constellation screen, the outline is dark gray `#2A2E35`).
- **Touch Target**: Height $\ge 44\text{pt}$ for touch accessibility.

---

## Molecules

### VerseBlock
The fundamental reading block containing one Ayah.
- **Props**:
  - `arabic_text` (String in Amiri or Uthmanic script)
  - `translation_text` (String)
  - `ayah_num` (Integer)
  - `is_active` (Boolean)
  - `show_translation` (Boolean)
- **States**:
  - `unread`: Standard appearance, thin divider below.
  - `read`: Text opacity slightly dimmed to indicate completed reading.
  - `active`: Highlighted with `teal_400` left border accent and a subtle light cream/gray background fill. Action menu `...` appears on the right edge.
- **Gesture**: Tapping the block marks it as read and toggles the active/highlighted state.

### SurahListRow
A list tile showing Surah information.
- **Props**:
  - `number` (Integer)
  - `arabic_name` (String)
  - `english_name` (String)
  - `english_meaning` (String)
  - `ayah_count` (Integer)
  - `progress` (Double: 0.0 to 1.0)
- **States**:
  - `not_started`: Standard text colors, no progress indicator.
  - `in_progress`: Subtitle shows current verse fraction, progress bar active.
  - `complete`: Small green checkmark or completed badge visible.

### ContinueReadingCard
The dashboard header card for quick resumption.
- **Props**:
  - `surah_name` (String)
  - `ayah_ref` (String, e.g., "12/286")
  - `arabic_snippet` (String)
  - `progress_value` (Double)
- **States**:
  - `has_progress`: Normal display with a solid `teal_400` border and progress bar at the bottom.
  - `empty`: Hidden if the user has no active reading history.

### DiscoveryRow
An entity discovery line item inside the bottom sheet.
- **Props**:
  - `entity_name` (String)
  - `entity_type` (Enum)
  - `is_rare` (Boolean)
- **Layout**: `EntityBadge` (left) | Name & TypeLabel stacked (center-left) | Arrow indicator (right).

### EntityCard
A grid item showing encyclopedia status.
- **Props**:
  - `name` (String)
  - `entity_type` (Enum)
  - `is_discovered` (Boolean)
- **States**:
  - `discovered`: Renders color-coded `EntityBadge`, name, and type label.
  - `undiscovered`: Badge is locked/blurred, card has a subtle overlay stating "?? — keep reading".

### AppearanceInRow
A table row mapping occurrences in the encyclopedia detail view.
- **Props**:
  - `surah_name` (String)
  - `ayah_range` (String, e.g., "2:124-128")
  - `context_snippet` (String)
- **Gesture**: Tappable (Touch target height: 48px). Tapping opens the Reader at the corresponding verse.

### MiniRelationBubble
A small node pill representing a connected entity in a static graph.
- **Props**:
  - `entity_name` (String)
  - `entity_type` (Enum)
- **Layout**: Horizontal pill containing a miniature badge, entity name text, and a rounded bounding box.

### MetricCard
A grid item in the profile dashboard displaying statistics.
- **Props**:
  - `icon` (Widget/IconData)
  - `label` (String)
  - `value` (String/Integer)
  - `sublabel` (String)
- **Style**: Light background `neutral_50`, large bold value display, 8px corner radius.

### ThemeXpRow
A row showing XP progression for a Quranic theme in the profile.
- **Props**:
  - `theme_name` (String)
  - `icon` (Widget)
  - `percent` (Integer)
  - `progress_value` (Double)

---

## Organisms

### DiscoverySheet
The overlay bottom sheet shown upon discovering new entities.
- **Variant A (Standard)**:
  - Height: ~28% of screen.
  - Background: Cream `#FDFCFA`.
  - Content: Small teal "Discovered" header, up to 4 staggered `DiscoveryRow` items, and a teal text link "View in encyclopedia →" at the bottom.
- **Variant B (Rare)**:
  - Height: ~45% of screen.
  - Background: Teal wash gradient (`wash-bg`).
  - Content: Large centered gold-trimmed Islamic geometric badge, white entity name text (display size), description placeholder, and a white underlined link button.

### ConstellationNode
An interactive node within the full force-directed constellation graph.
- **Props**:
  - `entity_type` (Enum)
  - `label` (String)
  - `is_discovered` (Boolean)
  - `icon` (Widget/Asset)
- **States**:
  - `discovered`: Solid colored circular bubble containing the category icon, with a text label visible underneath.
  - `undiscovered`: Faintly outlined dotted circular node, no icon, label is replaced by a question mark.

### ConstellationEdge
The connecting links in the interactive knowledge graph.
- **Props**:
  - `edge_type` (Enum: `relation` | `co_occurrence`)
  - `weight` (Double: 0.0 to 10.0)
- **Rendering rules**:
  - `relation`: Solid thin line (thickness: 1px, color: `neutral_200` at 30% opacity).
  - `co_occurrence`: Dashed line, opacity dynamically linked to edge weight (clamped between 0.3 and 1.0).

### ConstellationSidePanel
A detail panel that slides in from the right edge when a node in the graph is selected.
- **Props**:
  - `entity_name` (String)
  - `entity_type` (Enum)
  - `unlock_verse_ref` (String)
  - `connected_count` (Integer)
- **Animation**: Slides in from right (250ms ease-out). Tap outside to dismiss.

### UpdateBadge
A Floating Action Pill showing graph updates.
- **Props**:
  - `is_visible` (Boolean)
- **Style**: Rounded pill shape, background `teal_400`, text "Tap to update" in white. Appears centered at the top of the Constellation screen.

### MiniRelationGraph
A static mini-graph displayed inline on the Encyclopedia Entity Detail screen.
- **Props**:
  - `centre_entity` (String)
  - `connected_entities` (List of connected entity data)
- **Layout**: Static layout centering the main entity node, with radial lines connecting it to 3 or 4 `MiniRelationBubble` elements. Non-interactive (tapping the container opens the full interactive Constellation screen).

### BottomNavBar
The global navigation bar at the bottom of the viewport.
- **Props**:
  - `active_tab` (Enum: Home | Search | Explore | Library | Profile)
  - `is_dark_theme` (Boolean; true when rendering on the Constellation screen)
- **Height**: Strictly 60px.
- **Aesthetics**: Active tab shows a highlighted teal icon and label. Touch targets for each tab occupy a minimum area of $78 \times 60$ pixels to ensure easy clicking.
