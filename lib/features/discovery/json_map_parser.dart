// lib/features/discovery/json_map_parser.dart

/// Helper parser to decode verse and range trigger strings from JSON assets.
class JsonMapParser {
  JsonMapParser._();

  /// Parses a single verse string (e.g., "2:51") into surah and ayah indexes.
  ///
  /// Returns a map containing keys 'surahNum' and 'ayahNum'.
  static Map<String, int> parseSingleVerse(String verseStr) {
    final parts = verseStr.split(':');
    if (parts.length != 2) {
      throw FormatException('Invalid verse trigger format: $verseStr');
    }
    final surahNum = int.tryParse(parts[0]);
    final ayahNum = int.tryParse(parts[1]);
    if (surahNum == null || ayahNum == null) {
      throw FormatException('Invalid integer values in verse trigger: $verseStr');
    }
    return {
      'surahNum': surahNum,
      'ayahNum': ayahNum,
    };
  }

  /// Parses a verse range string (e.g., "12:1-111") into surah and boundary indexes.
  ///
  /// Returns a map containing keys 'surahNum', 'ayahStart', and 'ayahEnd'.
  static Map<String, int> parseVerseRange(String rangeStr) {
    final parts = rangeStr.split(':');
    if (parts.length != 2) {
      throw FormatException('Invalid range trigger format: $rangeStr');
    }
    final surahNum = int.tryParse(parts[0]);
    if (surahNum == null) {
      throw FormatException('Invalid Surah number in range trigger: $rangeStr');
    }

    final rangeParts = parts[1].split('-');
    if (rangeParts.length != 2) {
      throw FormatException('Invalid Ayah bounds in range trigger: $rangeStr');
    }

    final ayahStart = int.tryParse(rangeParts[0]);
    final ayahEnd = int.tryParse(rangeParts[1]);
    if (ayahStart == null || ayahEnd == null) {
      throw FormatException('Invalid integer bounds in range trigger: $rangeStr');
    }

    return {
      'surahNum': surahNum,
      'ayahStart': ayahStart,
      'ayahEnd': ayahEnd,
    };
  }
}
