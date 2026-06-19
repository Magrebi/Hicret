// lib/core/local_db/expedition_routes.dart

/// Canonical verse-range map for all reading expeditions.
///
/// Each entry maps an expedition ID to a list of verse ranges.
/// Each range is [surahNum, ayahStart, ayahEnd].
///
/// IMPORTANT: Keep this map in sync with the expedition IDs seeded in
/// SetCollectionDao._seedExpeditions(). An expedition ID present in one
/// but not the other will either never show progress or never appear in the UI.
const Map<String, List<List<int>>> kExpeditionRoutes = {
  'exp_exodus':            [[28, 3, 46], [20, 9, 98]],
  'exp_wisdom_luqman':     [[31, 12, 19]],
  'exp_covenant_abraham':  [[6, 74, 83], [2, 124, 128], [37, 99, 113]],
  'exp_patience_triumph':  [[12, 4, 101]],
  'exp_sleepers_signs':    [[18, 9, 26], [18, 60, 82], [18, 83, 98]],
  'exp_creation_garden':   [[2, 30, 39], [7, 11, 25]],
  'exp_ark_salvation':     [[11, 25, 49], [71, 1, 28]],
  'exp_kingdom_grace':     [[27, 15, 44], [38, 17, 40]],
  'exp_pure_birth':        [[19, 1, 36], [3, 33, 47]],
  'exp_call_monotheism':   [[96, 1, 5], [73, 1, 10], [68, 1, 4]],
};
