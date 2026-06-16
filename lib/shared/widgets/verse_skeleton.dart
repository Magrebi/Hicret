// lib/shared/widgets/verse_skeleton.dart

import 'package:flutter/material.dart';

/// Shimmer-style loading skeleton for a single Verse block,
/// avoiding layout shift when fetching data from the API.
class VerseSkeleton extends StatelessWidget {
  const VerseSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Warm neutral colors mapped from design-tokens
    final baseColor = isDark ? const Color(0xFF252220) : const Color(0xFFF4F2EE); // neutral-50 equivalent
    final highlightColor = isDark ? const Color(0xFF2C2A25) : const Color(0xFFE8E5DF); // neutral-100 equivalent

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xFF2C2A25) : const Color(0xFFE8E5DF), // neutral-100 divider
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Ayah badge placeholder
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 32,
              height: 18,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 2. Arabic text placeholder block (large height, RTL simulation)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 26,
              decoration: BoxDecoration(
                color: highlightColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 26,
              decoration: BoxDecoration(
                color: highlightColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 3. Translation text placeholder block (smaller height, LTR)
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 14,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 14,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
