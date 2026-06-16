# Quran Knowledge Atlas (QKA) UI Specification

This document details the screen-by-screen user interface, layout, typography, components, interaction mechanics, and edge cases for the QKA mobile application (iOS & Android). All specifications are grounded in the Stitch reference screens.

---

## Screen 1 — Home (Continue Reading State)
**Reference Frame**: `home_continue_reading.png`  
**Viewport**: $390 \times 844$ (iPhone 14) / $360 \times 800$ (Android mid-range)

### Layout & Spacing
- **Top Bar**: `space-md` (16px) top padding, `screen-h-padding` (20px) horizontal padding.
  - "QKA" serif wordmark (display font, bold, 24px) aligned left.
  - Profile avatar button (radius-full, 36px diameter) aligned right.
  - Subtle teal radial glow/light accent centered directly underneath the "QKA" wordmark.
- **Continue Reading Card**:
  - `space-lg` (24px) top margin below Top Bar, `screen-h-padding` (20px) horizontal padding.
  - Card Dimensions: Variable height (~160px), padding `card-padding` (16px).
  - Background: Warm off-white (`#FDFCFA` / `# neutral-0`), outline: `teal-400` (1px border).
- **"Surahs" Section**:
  - Heading: "Surahs" (size-title: 24px, neutral-800, weight-medium). Spacing: `space-lg` (24px) top margin.
- **Surah Scroll List**:
  - Scrollable rows separated by a thin `neutral-100` divider. No progress bars per row.

### Key Components
- **TopNavBar** (Home Variant)
- **ContinueReadingCard**:
  - Label: "Continue reading" (size-caption: 12px, `neutral-400`, uppercase).
  - Title: Surah name + current progress (e.g., "Al-Baqarah · 12/286", size-body: 16px, `neutral-800`, weight-bold).
  - Snippet: Arabic snippet of next verse (size-arabic-sm: 18px, RTL alignment, `leading-arabic: 2.2`, `neutral-800`).
  - Progress: Linear `ProgressBar` at the card bottom (value: 0.042, active: `teal-400`, height: 4px).
- **SurahListRow**: List of Surahs with index numbers, Arabic names, English names, and meanings.

### Interaction Notes
- Tapping the **Continue Reading Card** immediately opens the Reader screen at the saved active verse.
- Tapping any row in the **Surah List** opens that Surah at Ayah 1.
- Scrolling the Surah list employs a gentle scroll-bounce (iOS native) with a persistent bottom navigation bar.

### Light & Dark Mode
- **Light Mode**: Reading surface background `#FDFCFA`. Card background `#FDFCFA` with `teal-400` border.
- **Dark Mode**: Reading surface background `#1A1815`. Card background `#1A1815` with `teal-600` border, text shifted to neutral dark-scale colors.

### Edge Cases
- **Complete Reading Progress**: If the user finishes reading all Ayahs, the Continue Reading Card is replaced by a completion badge: "Surahs Completed · Re-read or explore the Constellation".
- **Empty State / First Launch**: If no reading history is found, automatically redirect/render Screen 2.

---

## Screen 2 — Home (First Launch / Welcome State)
**Reference Frame**: `home_first_launch.png`  
**Viewport**: $390 \times 844$ / $360 \times 800$

### Layout & Spacing
- **Top Center Header**:
  - "QKA" serif wordmark (size-title: 24px, bold) centered.
  - `space-xl` (40px) top margin.
- **Welcome Block**:
  - Title: "Welcome" (size-display: 40px, serif, `neutral-800`).
  - Subtitle: "Explore the Quranic Knowledge Graph" (size-secondary: 14px, `neutral-400`).
- **Search Component**:
  - Spacing: `space-md` (16px) top margin below Welcome block.
  - Dimensions: Height 48px, horizontal margin `screen-h-padding` (20px).
  - Background: `neutral-50` (`#F4F2EE`), border radius `radius-md` (8px).
  - Input field placeholder: "Search surahs..." with search icon left and filter icon right.
- **Basmala Header**:
  - Correct Arabic label centered above the list: "سورة الفاتحة" or standard "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ" in Arabic script (size-arabic-lg: 22px, `neutral-800`).
- **Surah Scroll List**: Full vertical list of all 114 Surahs starting immediately below.

### Key Components
- **SearchField**
- **SurahListRow** (114 items)
- **BottomNavBar** (5-tab navigation bar)

### Interaction Notes
- Tapping inside the search bar focuses the input field, slides the Welcome header out of view, and opens a real-time filtered search list.
- Tapping the filter icon right-aligned in the search bar toggles a category filter overlay (Mekkan vs. Medinan surahs).

### Light & Dark Mode
- **Light Mode**: Warm off-white surface, search field in light warm gray `#F4F2EE`.
- **Dark Mode**: Deep warm dark surface `#1A1815`, search field in dark warm gray `#2A2A2A` or card background container `#1E1B18`.

### Edge Cases
- **No Search Results**: Show a quiet, centered typography-only placeholder: "No surahs found matching 'XYZ'. Try looking for a prophet or location."
- **First Internet Connection**: If completely offline, load local cached assets of the English meanings and indexes.

---

## Screen 3 — Reader (Light Mode)
**Reference Frame**: `reader_al_baqarah.png`  
**Viewport**: $390 \times 844$ (Text-focused scrolling view)

### Layout & Spacing
- **Top Chrome Bar**:
  - Spacing: Height 56px, `screen-h-padding` (20px) horizontal padding.
  - Back arrow left, Surah Name centered (e.g., "Al-Baqarah", weight-bold, size-title: 24px) with Ayah fraction below ("12/286", size-caption: 12px, `neutral-400`).
  - Settings icon right.
- **Verse Blocks Scrolling Container**:
  - Vertical list of verses. Padding: `screen-h-padding` (20px) left/right.
  - Gap between verses: `verse-gap` (24px) defined by margin-bottom on each `VerseBlock`.
  - Hairline divider (`neutral-100` color, 0.5px height) separating each `VerseBlock`.
- **Bottom Navigation Indicator**:
  - Dynamic bottom bar displaying "Previous Surah" / "Next Surah" pagination buttons (hidden during active scrolling, reappears on pause).

### Key Components
- **VerseBlock**:
  - Arabic Text: RTL aligned, `size-arabic-xl` (26px), line-height `2.2` (essential for vowel marks/tashkeel legibility).
  - Translation Text: LTR aligned, `size-body` (16px), line-height `1.7`, color `neutral-600`.
  - Ayah Number Badge: Centered or left-aligned small neutral circle containing the Arabic numeral.

### Interaction Notes
- **Mark as Read**: Tapping anywhere inside a `VerseBlock` marks it as read, triggering a progress update.
- **Discovery Trigger**: If the tapped verse contains a recognized entity (prophet, location, etc.), it triggers the immediate entry animation of Screen 5 (Discovery Sheet).
- **Chrome Fade**: Once the user scrolls down by more than 80px, the Top Bar and Bottom bar fade out (`dur-fast`: 150ms) to ensure absolute reading focus. They reappear immediately if scrolling stops or reverses.

### Light & Dark Mode
- Light mode only: Scaffold background is strictly warm cream `#FDFCFA` (never pure white, minimizing eye strain). Font colors are charcoal `#5A574F` for body text and `#2C2A25` for headers.

### Edge Cases
- **Very Long Surahs**: Dynamic virtualization (rendering only visible and adjacent 3 verses) is required to prevent rendering lag on low-end devices.
- **Bismillah Header**: Render the standard Arabic Basmala vector graphic at the top of the Surah (except Surah At-Tawbah).

---

## Screen 4 — Reader (Dark Mode)
**Reference Frame**: `reader_dark_mode.png`  
**Viewport**: $390 \times 844$

### Layout & Spacing
- Same structural layout as Screen 3, modified for low-light legibility and focus.
- **Surah Header Banner**: At the top, a calligraphic Arabic title is displayed inside a large container, with the English Surah name, meaning, and verse count stacked beneath.
- **Active Verse Highlight**:
  - The currently active/tapped verse has a solid `teal-400` vertical indicator border (3px width) on the left edge.
  - The background of the active block transitions to a slightly lighter dark surface `#252320` with a subtle teal inner glow.

### Key Components
- **VerseBlock** (Dark Active Variant):
  - Arabic Text: `size-arabic-lg` (22px) in dark mode to fit the highlight layout.
  - Translation: Hidden by default for unselected verses. Displays *only* for the active/tapped verse to maximize focus.
  - More Action Menu (`...` button): Appears on the right edge of the active verse, opening text copying, bookmarking, and audio controls.

### Light & Dark Mode
- Scaffold background: Deep warm dark `#1A1815` (not pure black).
- Inactive verses: Muted gray text (`neutral-400`). Active verse: white text.
- Active states: Active bottom nav icon highlighted in `teal-200` / `teal-400`.

### Edge Cases
- **Overscroll Behavior**: Tapping the final verse in a Surah triggers a soft completion dialog containing the option to proceed to the next Surah or review unlocked entities.

---

## Screen 5 — Discovery Sheet (Standard Unlock)
**Reference Frame**: Minimal overlay state (Standard variant)  
**Viewport**: $390 \times 844$ (Overlaying Reader Screen)

### Layout & Spacing
- **Bottom Sheet Dimension**: Slides up to cover exactly 28% of the viewport height.
- **Padding**: Horizontal `screen-h-padding` (20px), vertical `space-md` (16px).
- **Surface**: Warm cream `#FDFCFA` background, thin `neutral-100` top border, sharp rounded corners `radius-lg` (12px) on top-left and top-right.

### Key Components
- **Header**: "Discovered" text (small, `size-caption`: 12px, bold, `teal-400` color).
- **Entity Row**:
  - `EntityBadge`: Color-coded geometric polygon (`prophet` = teal, `location` = amber, etc.), size small (24px).
  - Entity Name: size-body (16px), bold, `neutral-800`.
  - Type Label: size-caption (12px), color matching entity type.
- **Footer Link**: "View in encyclopedia →" text link in `teal-600`.

### Interaction Notes
- **Dismissal**: Swipe down to dismiss, or tap anywhere on the dimmed Reader background behind the sheet.
- **Entrance Animation**: Slides up from the bottom (200ms ease-out). The entity rows fade in with a 50ms stagger.
- **Reverent Feedback**: No game-like sound effects or confetti. A soft, single haptic tap (light vibration) is triggered upon unlock.

### Edge Cases
- **Multiple Discoveries**: If a single verse contains multiple entities, the sheet displays up to 4 rows in a scrollable list.

---

## Screen 6 — Discovery Sheet (Rare Unlock)
**Reference Frame**: `discovery_entity_unlocked.png`  
**Viewport**: $390 \times 844$ (Overlaying Reader Screen)

### Layout & Spacing
- **Bottom Sheet Dimension**: Cover 45% of the viewport height.
- **Surface**: Teal wash background (`wash-bg` gradient: semi-transparent `#B8E8D8` blending into solid `#0F6E56` at the bottom).
- **Medallion Placement**: Centered in the upper portion of the sheet.

### Key Components
- **Geometric Medallion**: Islamic geometric medallion badge (octagonal or multi-pointed star pattern with gold highlights; no human figures).
- **Header**: "Rare discovery" (size-secondary: 14px, tracking-wide, white text).
- **Entity Name**: Large display text ("Ibrahim", size-display: 40px, serif, white).
- **Description Paragraph**: Mini placeholder paragraph: `// TODO: content team to supply` (white, opacity 0.8).
- **Footer Button**: "View in encyclopedia →" full button with white underline.

### Interaction Notes
- **Animation**: 300ms slide-up with a soft fade-in of the teal wash backdrop.
- **Haptics**: Medium haptic feedback pulse upon sheet entry.

---

## Screen 7 — Encyclopedia (Figures Grid)
**Reference Frame**: `encyclopedia_figures_grid.png`  
**Viewport**: $390 \times 844$

### Layout & Spacing
- **Top Bar**: "Encyclopedia" title (size-title: 24px, weight-bold) with back arrow.
- **Tab Selection**:
  - Segmented control containing: Figures | Places | Collections.
  - Spacing: `space-md` (16px) vertical margin.
- **2-Column Grid**:
  - Spacing: Spaced by `space-sm` (8px) grid gutters, with `screen-h-padding` (20px) horizontal page padding.
  - Card Dimensions: Aspect ratio approximately 1:1.

### Key Components
- **SegmentedControl**
- **EntityCard** (Discovered Variant):
  - Card background: `neutral-50` (`#F4F2EE`), border `neutral-200`.
  - Icon: Centered geometric polygon badge colored by type.
  - Name: size-body (16px), bold.
  - Label: size-caption (12px), type color.
- **EntityCard** (Undiscovered Variant):
  - Card background: Same, but contents are blurred (blur radius: 8px).
  - Overlay Text: "?? — keep reading" centered in the middle of the card.

### Interaction Notes
- Tapping a discovered card navigates directly to Screen 8 (Entity Detail).
- Tapping an undiscovered card triggers a brief shake animation and a toast message: "Keep reading the Quran to discover this entity."

---

## Screen 8 — Encyclopedia (Entity Detail)
**Reference Frame**: `encyclopedia_entity_detail.png`  
**Viewport**: $390 \times 844$

### Layout & Spacing
- **Header**:
  - Large Entity Name ("Ibrahim", size-display: 40px, serif) centered.
  - Islamic geometric calligraphic medallion centered directly below the name.
- **Description Block**:
  - Spacing: `space-lg` (24px) vertical padding.
  - Text: Content placeholder `// TODO: content team to supply` (size-body: 16px, `neutral-600`, line-height 1.7).
- **"Appears in" Table**:
  - Table showing occurrences: Surah | Ayah Range | Context Snippet.
  - Alternating row backgrounds (neutral-0 and neutral-50) for clarity.
- **"Connected to" Section**:
  - Static inline mini relationship graph showing adjacent nodes.
- **Footer CTA**:
  - "See in Constellation" outline button (full-width, `teal-400` border, `radius-md`).

### Interaction Notes
- Tapping any row in the "Appears in" table opens the Reader screen, automatically navigating and highlighting that exact Ayah.
- Tapping the "See in Constellation" button opens the Explore tab and centers the interactive force-directed graph on this specific node.

---

## Screen 9 — Constellation (Knowledge Graph)
**Reference Frame**: `constellation_knowledge_graph.png`  
**Viewport**: $390 \times 844$ (Always-Dark View)

### Layout & Spacing
- **Surface**: Strictly deep navy background `#0D1B2A` regardless of global app light/dark mode settings.
- **Graph Canvas**: Full-screen interactive force-directed graph.
- **Top Overlay Controls**:
  - "Tap to update" pill badge centered at the top.
  - Filter chips row (All | Prophets | Locations | Nature) aligned below top edge, height 36px.

### Key Components
- **ConstellationNode**:
  - Discovered: Colored circle (matching type token) with integrated icon (scroll for prophet, pin for location, leaf for nature) and text label below.
  - Undiscovered: Faint outline only, no text label.
- **ConstellationEdge**:
  - Solid edges represent direct relations.
  - Dashed edges represent co-occurrence strength (opacity mapped to weight).
- **ConstellationSidePanel**: Slides in from the right edge upon node selection.

### Interaction Notes
- **Deferred Graph Refresh**: New nodes do not spawn instantly to avoid disorienting the user. They are queued. The "Tap to update" badge appears; clicking it runs the centroid seeding layout update.
- **Node Tap**: Tapping a node displays the `ConstellationSidePanel` containing the name, entity type, first unlock verse reference, and a CTA link: "View in encyclopedia →".

---

## Screen 10 — Profile (Progress & Stats)
**Reference Frame**: `profile_progress_stats.png`  
**Viewport**: $390 \times 844$

### Layout & Spacing
- **Header**: "Profile – Progress & Stats" (size-title: 24px, bold).
- **Streak Block**:
  - Left: Hand-drawn plant-on-book streak illustration (no flame icons).
  - Right: Large streak number ("14") and label "Days of reading".
  - Soft subtitle: "Read a little each day" (reverent tone).
- **Theme XP Section**:
  - Spacing: `space-lg` (24px) top margin.
  - Stacked rows of theme metrics (Patience, Gratitude, Justice).
- **Metric Grid**: 2-column card grid displaying total verses read, entities discovered, and concepts linked.
- **Story Progression Row**: Scrollable horizontal list of story arcs at the bottom.

### Key Components
- **StreakIndicator**
- **ThemeXpRow**: Icon, name, percentage, and a linear progress bar in `teal-400`.
- **MetricCard**: Large count number, label, and light neutral card backing.

---

## Screen 11 — Settings (Reading Prefs)
**Reference Frame**: `settings_reading_prefs.png`  
**Viewport**: $390 \times 844$

### Layout & Spacing
- **Header**: "Reading Preferences" with back button.
- **Preference List Options**:
  - Font Size Slider: Multi-step slider mapped to arabic size tokens (18px, 22px, 26px).
  - Arabic Font Radio Group: "Amiri Quran" vs. "KFGQPC Uthmanic".
  - Translation Dropdown: Select translation source (English, French, Urdu, etc.).
  - Appearance segmented control: Light | Dark | System.
- **Spacing**: Option rows have a height of 56px, padded with `card-padding` (16px).

### Key Components
- **Slider** (Custom teal track)
- **RadioGroup**
- **DropdownButton**
- **SegmentedControl**

### Light & Dark Mode
- Respects the selected preference. Selecting "Dark" immediately flips the theme using a 250ms fade transition.
