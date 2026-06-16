// lib/shared/widgets/surah_list_row.dart

import 'package:flutter/material.dart';

class SurahListRow extends StatelessWidget {
  final int number;
  final String transliteration;
  final String englishMeaning;
  final String arabicName;
  final int totalAyahs;
  final int ayahsRead;
  final VoidCallback onTap;

  const SurahListRow({
    Key? key,
    required this.number,
    required this.transliteration,
    required this.englishMeaning,
    required this.arabicName,
    required this.totalAyahs,
    required this.ayahsRead,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Theme colors
    final numberColor = const Color(0xFF8C8880); // neutral-400
    final titleColor = isDark ? const Color(0xFFE8E5DF) : const Color(0xFF2C2A25); // neutral-100 dark / neutral-800 light
    final subtitleColor = const Color(0xFF8C8880); // neutral-400
    final dividerColor = isDark ? const Color(0xFF2A2E35) : const Color(0xFFE8E5DF); // neutral-100 equivalent

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 56,
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                // Number (neutral-400, min-width 28px)
                SizedBox(
                  width: 28,
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: numberColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                
                // Surah Name (English Transliteration + Arabic)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transliteration,
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: titleColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '$englishMeaning · $totalAyahs verses',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 13,
                              color: subtitleColor,
                            ),
                          ),
                        ],
                      ),
                      
                      // Arabic calligraphic text name on the right
                      Text(
                        arabicName,
                        style: TextStyle(
                          fontFamily: 'Amiri Quran',
                          fontSize: 20,
                          color: titleColor,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Divider below each row
          Container(
            height: 0.5,
            color: dividerColor,
          ),
        ],
      ),
    );
  }
}
