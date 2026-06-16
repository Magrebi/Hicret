// lib/shared/widgets/continue_reading_card.dart

import 'package:flutter/material.dart';

class ContinueReadingCard extends StatelessWidget {
  final String surahName;
  final int ayahsRead;
  final int totalAyahs;
  final String arabicSnippet;
  final String arabicFont;
  final VoidCallback onTap;

  const ContinueReadingCard({
    Key? key,
    required this.surahName,
    required this.ayahsRead,
    required this.totalAyahs,
    required this.arabicSnippet,
    required this.arabicFont,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Theme colors from tokens
    final tealColor = const Color(0xFF1D9E75); // teal-400
    final labelColor = const Color(0xFF8C8880); // neutral-400
    final titleColor = isDark ? const Color(0xFFE8E5DF) : const Color(0xFF2C2A25); // neutral-100 dark / neutral-800 light
    final snippetColor = isDark ? const Color(0xFFC9C6BE) : const Color(0xFF5A574F); // neutral-200 dark / neutral-600 light
    final trackColor = isDark ? const Color(0xFF2C2A25) : const Color(0xFFE8E5DF); // neutral-100 equivalent
    final cardBgColor = isDark ? const Color(0xFF1A1815) : const Color(0xFFFDFCFA); // neutral-0 equivalent

    final double progress = totalAyahs > 0 ? (ayahsRead / totalAyahs).clamp(0.0, 1.0) : 0.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(12), // radius-lg
          border: Border.all(
            color: tealColor,
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "Continue reading" Label
            Text(
              'CONTINUE READING',
              style: TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: labelColor,
              ),
            ),
            const SizedBox(height: 8),
            
            // Surah Name + Progress fraction
            Text(
              '$surahName $ayahsRead/$totalAyahs',
              style: TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 12),
            
            // Arabic Snippet (Max 2 lines, RTL)
            if (arabicSnippet.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  arabicSnippet,
                  style: TextStyle(
                    fontFamily: arabicFont,
                    fontSize: 18,
                    height: 2.0,
                    color: snippetColor,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Progress Bar
            Container(
              width: double.infinity,
              height: 3,
              decoration: BoxDecoration(
                color: trackColor,
                borderRadius: BorderRadius.circular(999), // radius-full
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: tealColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
