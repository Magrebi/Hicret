# Quran Knowledge Atlas (QKA)

A Flutter-based companion reader app for iOS and Android that integrates scripture with a force-directed Quranic knowledge graph. As users read the Quran verse by verse, they quietly discover and unlock entities—such as Prophets, geographical locations, natural objects, and theological themes—visualizing their relationships in an interactive star constellation map. The application balances typography-focused reading surfaces with gamified streak tracking and progression metrics restricted to the user profile.

---

## Getting Started

Follow these steps to initialize and build the project environment:

1. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
2. **Generate Database and State Providers**:
   Run the build runner compiler to generate the code mapping for Drift databases and Riverpod annotations:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
3. **Configure Database Assets**:
   Ensure the local entity trigger map is placed in the designated assets folder:
   ```bash
   # Place the entity JSON configuration under:
   assets/data/entities.json
   ```
4. **Initialize Firebase SDK**:
   Connect the app to your Firebase console project for cloud storage backups:
   ```bash
   flutterfire configure
   ```

---

## Directory Structure

```text
quran_knowledge_atlas/
├── assets/
│   ├── data/
│   │   └── entities.json
│   ├── fonts/
│   └── images/
├── lib/
│   ├── core/
│   │   ├── local_db/
│   │   │   ├── daos/
│   │   │   │   ├── entity_dao.dart
│   │   │   │   ├── reader_dao.dart
│   │   │   │   ├── set_collection_dao.dart
│   │   │   │   └── story_theme_dao.dart
│   │   │   ├── tables/
│   │   │   │   ├── bookmarks_table.dart
│   │   │   │   ├── collection_entities_table.dart
│   │   │   │   ├── collections_table.dart
│   │   │   │   ├── constellation_edges_table.dart
│   │   │   │   ├── entities_table.dart
│   │   │   │   ├── entity_triggers_table.dart
│   │   │   │   ├── expeditions_table.dart
│   │   │   │   ├── relation_edges_table.dart
│   │   │   │   ├── set_requirements_table.dart
│   │   │   │   ├── sets_table.dart
│   │   │   │   ├── stories_table.dart
│   │   │   │   ├── story_verse_ranges_table.dart
│   │   │   │   ├── theme_levels_table.dart
│   │   │   │   ├── theme_triggers_table.dart
│   │   │   │   ├── themes_table.dart
│   │   │   │   ├── user_progress_table.dart
│   │   │   │   └── verses_table.dart
│   │   │   ├── app_database.dart
│   │   │   └── database_provider.dart
│   │   ├── network/
│   │   │   └── quran_api_service.dart
│   │   ├── repositories/
│   │   │   ├── entity_repository.dart
│   │   │   ├── gamification_repository.dart
│   │   │   ├── quran_repository.dart
│   │   │   └── user_progress_repository.dart
│   │   └── theme/
│   │       └── app_theme.dart
│   ├── features/
│   │   ├── constellation/
│   │   │   ├── constellation_graph_controller.dart
│   │   │   ├── constellation_notifier.dart
│   │   │   └── constellation_screen.dart
│   │   ├── discovery/
│   │   │   ├── discovery_mapper.dart
│   │   │   ├── discovery_result.dart
│   │   │   ├── discovery_service.dart
│   │   │   ├── discovery_transaction.dart
│   │   │   └── json_map_parser.dart
│   │   ├── encyclopedia/
│   │   ├── gamification/
│   │   │   └── gamification_service.dart
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── library/
│   │   │   └── library_screen.dart
│   │   ├── premium/
│   │   │   └── sync_service.dart
│   │   ├── reader/
│   │   │   └── user_progress_service.dart
│   │   └── search/
│   │       └── search_screen.dart
│   ├── shared/
│   │   └── widgets/
│   │       ├── bottom_nav_bar.dart
│   │       └── discovery_sheet.dart
│   └── main.dart
├── design-tokens.json
├── figma_components.md
├── ui_spec.md
└── pubspec.yaml
```

---

## Project Milestones

- [x] **Phase 1: UI & Styling Specification**
  - [x] Color, typography, and animation tokens registered.
  - [x] AppTheme mapped to material design.
  - [x] Screen specifications and UI states completed.
- [x] **Phase 2: Database Layer**
  - [x] Drift and SQLite schema tables created.
  - [x] DB connection setups and migration stubs added.
  - [x] Specialized DAOs for readers and entities written.
- [x] **Phase 3: State & Repositories**
  - [x] Dependency injection via Riverpod generated providers.
  - [x] Abstract repository and concrete implementation mapping.
  - [x] Core service definitions written.
- [x] **Phase 4: Logic Triggers & Optimizations**
  - [x] Atomic transactional triggers implemented on verse reads.
  - [x] GraphView performance layer optimizations (centroid seeding and debounce) resolved.
