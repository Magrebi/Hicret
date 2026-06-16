// lib/shared/widgets/entity_card.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/local_db/app_database.dart' hide Theme;
import '../../core/theme/app_theme.dart';
import 'entity_badge.dart';

class EntityCard extends StatelessWidget {
  final Entity entity;

  const EntityCard({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (entity.isDiscovered) {
      final cardBg = isDark ? QkaTheme.neutral900 : Colors.white;
      final borderColor = isDark ? QkaTheme.neutral600 : QkaTheme.neutral200;
      final nameColor = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;

      return GestureDetector(
        onTap: () {
          context.push('/encyclopedia/${entity.id}');
        },
        child: Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(12), // radius-lg
            border: Border.all(color: borderColor, width: 0.5),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EntityBadge(
                entityType: entity.type,
                size: BadgeSize.md,
                isDiscovered: true,
              ),
              const Spacer(),
              Text(
                entity.name,
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: nameColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                _formatType(entity.type),
                style: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 12,
                  color: QkaTheme.neutral400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    } else {
      final cardBg = isDark ? QkaTheme.neutral800 : QkaTheme.neutral50;
      final borderColor = isDark ? QkaTheme.neutral600 : QkaTheme.neutral200;

      return GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Keep reading to discover this figure',
                style: TextStyle(fontFamily: 'SF Pro'),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(12), // radius-lg
            border: Border.all(color: borderColor, width: 0.5),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EntityBadge(
                entityType: entity.type,
                size: BadgeSize.md,
                isDiscovered: false,
              ),
              const Spacer(),
              const Text(
                '?? — keep reading',
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: QkaTheme.neutral400,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14), // Keeps layout height matching discovered state
            ],
          ),
        ),
      );
    }
  }

  String _formatType(String rawType) {
    switch (rawType.toLowerCase()) {
      case 'prophet':
        return 'Prophet';
      case 'historical_figure':
        return 'Figure';
      case 'matriarch':
        return 'Matriarch';
      case 'location':
        return 'Location';
      case 'nature':
        return 'Nature';
      case 'theme':
        return 'Theme';
      default:
        return rawType;
    }
  }
}
