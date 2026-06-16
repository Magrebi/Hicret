// lib/shared/widgets/collection_set_card.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CollectionSetCard extends StatelessWidget {
  final String id;
  final String name;
  final int discoveredCount;
  final int totalCount;
  final bool isSet;
  final bool isComplete;
  final String? rewardTitle;
  final VoidCallback onTap;

  const CollectionSetCard({
    Key? key,
    required this.id,
    required this.name,
    required this.discoveredCount,
    required this.totalCount,
    required this.isSet,
    required this.isComplete,
    this.rewardTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? QkaTheme.neutral900 : Colors.white;
    final borderColor = isDark ? QkaTheme.neutral600 : QkaTheme.neutral200;
    final nameColor = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;

    final progressVal = totalCount > 0 ? (discoveredCount / totalCount).clamp(0.0, 1.0) : 0.0;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isComplete ? QkaTheme.teal600 : borderColor,
                width: isComplete ? 1.5 : 0.5,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Left: circular progress ring
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: progressVal,
                        strokeWidth: 3.0,
                        backgroundColor: isDark ? QkaTheme.neutral800 : QkaTheme.neutral100,
                        valueColor: const AlwaysStoppedAnimation<Color>(QkaTheme.teal400),
                      ),
                      Text(
                        '$discoveredCount/$totalCount',
                        style: const TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: QkaTheme.neutral400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Right of ring: Collection details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: nameColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      if (isComplete && rewardTitle != null) ...[
                        Text(
                          rewardTitle!,
                          style: const TextStyle(
                            fontFamily: 'SF Pro',
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: QkaTheme.teal600,
                          ),
                        ),
                      ] else ...[
                        Text(
                          '$discoveredCount of $totalCount discovered',
                          style: const TextStyle(
                            fontFamily: 'SF Pro',
                            fontSize: 12,
                            color: QkaTheme.neutral400,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Right edge: Chevron if not complete
                if (!isComplete)
                  const Icon(
                    Icons.chevron_right,
                    color: QkaTheme.neutral400,
                    size: 20,
                  ),
              ],
            ),
          ),
          
          // Complete Badge top-right
          if (isComplete)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: QkaTheme.teal50,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Complete',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: QkaTheme.teal800,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
