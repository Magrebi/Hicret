// lib/shared/widgets/verse_block.dart

import 'package:flutter/material.dart';

/// Interactive container for a single Ayah, supporting Arabic text,
/// translation display, active highlighting, and discovery marks.
class VerseBlock extends StatelessWidget {
  final int surahNum;
  final int ayahNum;
  final String arabicText;
  final String translationText;
  final bool isRead;
  final bool isActive;
  final bool isDark;
  final bool isPremium;
  final String arabicFont;
  final double arabicFontSize;
  final VoidCallback onTap;
  final VoidCallback? onPlayAudio;
  final VoidCallback? onBookmark;

  const VerseBlock({
    Key? key,
    required this.surahNum,
    required this.ayahNum,
    required this.arabicText,
    required this.translationText,
    required this.isRead,
    required this.isActive,
    required this.isDark,
    required this.isPremium,
    required this.arabicFont,
    required this.arabicFontSize,
    required this.onTap,
    this.onPlayAudio,
    this.onBookmark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine translation visibility based on specs
    // - Light mode: Always show translation
    // - Dark mode: Show translation ONLY for the active verse
    final shouldShowTranslation = !isDark || isActive;

    // Active state container settings
    final activeBgColor = isDark 
        ? const Color(0xFF252220) // Slightly lighter than warm dark surface #1A1815
        : const Color(0xFFF4F2EE); // Slightly darker than warm light surface #FDFCFA

    final normalBgColor = Colors.transparent;

    // Muted reading text opacity for read verses (subtle visual indicator)
    final textOpacity = isRead ? 0.65 : 1.0;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: isActive ? activeBgColor : normalBgColor,
          border: Border(
            // Active verse left border (3px solid #1D9E75, borderRadius = 0)
            left: isActive
                ? const BorderSide(color: Color(0xFF1D9E75), width: 3.0)
                : BorderSide.none,
            // Hairline divider bottom
            bottom: BorderSide(
              color: isDark ? const Color(0xFF2C2A25) : const Color(0xFFE8E5DF),
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Ayah badge left / action controls right
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Ayah badge (surah:ayah, pill shape)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2C2A25) : const Color(0xFFE8E5DF),
                    borderRadius: BorderRadius.circular(999), // radius-full
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$surahNum:$ayahNum',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isDark ? const Color(0xFFC9C6BE) : const Color(0xFF5A574F),
                        ),
                      ),
                      if (isRead) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.check,
                          size: 10,
                          color: isDark ? const Color(0xFF5DCAA5) : const Color(0xFF1D9E75),
                        ),
                      ],
                    ],
                  ),
                ),
                
                // Active Actions Menu
                if (isActive)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isPremium) ...[
                        IconButton(
                          icon: const Icon(Icons.play_arrow_outlined, size: 20),
                          color: const Color(0xFF1D9E75),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: onPlayAudio,
                        ),
                        const SizedBox(width: 12),
                      ],
                      IconButton(
                        icon: const Icon(Icons.bookmark_border, size: 20),
                        color: isDark ? Colors.white70 : Colors.black87,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: onBookmark,
                      ),
                      const SizedBox(width: 8),
                      // '...' Action icon
                      Icon(
                        Icons.more_horiz,
                        size: 20,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Arabic text (RTL, large size, Amiri / Uthmanic font)
            Align(
              alignment: Alignment.centerRight,
              child: Opacity(
                opacity: textOpacity,
                child: Text(
                  arabicText,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: arabicFont,
                    fontSize: arabicFontSize,
                    height: 2.2, // Generous line height for Tashkeel legibility
                    color: isDark ? Colors.white : const Color(0xFF2C2A25), // neutral-800
                  ),
                ),
              ),
            ),

            if (shouldShowTranslation) ...[
              const SizedBox(height: 20),
              // Translation text (LTR, system UI font)
              Opacity(
                opacity: textOpacity,
                child: Text(
                  translationText,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 15,
                    height: 1.7,
                    color: isDark ? const Color(0xFFC9C6BE) : const Color(0xFF5A574F), // neutral-400 equivalent
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
