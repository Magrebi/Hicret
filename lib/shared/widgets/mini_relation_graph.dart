// lib/shared/widgets/mini_relation_graph.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import '../../core/local_db/app_database.dart' hide Theme;
import '../../core/theme/app_theme.dart';

class MiniRelationGraph extends StatelessWidget {
  final Entity centerEntity;
  final List<Entity> connectedEntities;

  const MiniRelationGraph({
    Key? key,
    required this.centerEntity,
    required this.connectedEntities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Determine entities to show and overflow count
    final int maxConnections = 5;
    final int totalConnections = connectedEntities.length;
    final bool hasOverflow = totalConnections > maxConnections;
    
    final List<Entity> visibleConnections = hasOverflow
        ? connectedEntities.take(maxConnections - 1).toList()
        : connectedEntities;
    
    final int overflowCount = totalConnections - visibleConnections.length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double height = 180.0;
        final double centerX = width / 2;
        final double centerY = height / 2;
        final double radius = 60.0; // Distance of outer chips from center

        // Build list of outer items
        final List<_GraphItem> outerItems = [];
        final int outerCount = visibleConnections.length + (hasOverflow ? 1 : 0);
        
        final double startAngle = -pi / 2;
        final double angleStep = outerCount > 0 ? (2 * pi / outerCount) : 0.0;

        for (int i = 0; i < visibleConnections.length; i++) {
          final angle = startAngle + i * angleStep;
          final x = centerX + radius * cos(angle);
          final y = centerY + radius * sin(angle);
          outerItems.add(_GraphItem(
            x: x,
            y: y,
            widget: _buildChip(
              context,
              visibleConnections[i].name,
              visibleConnections[i].type,
              isDark,
              onTap: () => context.push('/encyclopedia/${visibleConnections[i].id}'),
            ),
          ));
        }

        if (hasOverflow) {
          final angle = startAngle + visibleConnections.length * angleStep;
          final x = centerX + radius * cos(angle);
          final y = centerY + radius * sin(angle);
          outerItems.add(_GraphItem(
            x: x,
            y: y,
            widget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isDark ? QkaTheme.neutral800 : QkaTheme.neutral50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? QkaTheme.neutral600 : QkaTheme.neutral200,
                  width: 0.5,
                ),
              ),
              child: Text(
                '+$overflowCount more',
                style: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: QkaTheme.neutral400,
                ),
              ),
            ),
          ));
        }

        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 1. Draw connecting lines
              Positioned.fill(
                child: CustomPaint(
                  painter: _GraphLinesPainter(
                    centerX: centerX,
                    centerY: centerY,
                    outerItems: outerItems,
                    lineColor: isDark ? QkaTheme.neutral600 : QkaTheme.neutral200,
                  ),
                ),
              ),

              // 2. Render center chip
              Positioned(
                left: centerX - 60,
                top: centerY - 20,
                width: 120,
                height: 40,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: QkaTheme.teal50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: QkaTheme.teal200, width: 0.5),
                    ),
                    child: Text(
                      centerEntity.name,
                      style: const TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: QkaTheme.teal800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),

              // 3. Render outer chips
              ...outerItems.map((item) {
                return Positioned(
                  left: item.x - 70,
                  top: item.y - 20,
                  width: 140,
                  height: 40,
                  child: Center(child: item.widget),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChip(
    BuildContext context,
    String name,
    String type,
    bool isDark, {
    required VoidCallback onTap,
  }) {
    IconData icon;
    switch (type.toLowerCase()) {
      case 'prophet':
      case 'matriarch':
      case 'historical_figure':
        icon = Icons.person_outline;
        break;
      case 'location':
        icon = Icons.place_outlined;
        break;
      case 'nature':
      case 'animal':
      case 'plant':
        icon = Icons.eco_outlined;
        break;
      default:
        icon = Icons.help_outline;
    }

    final bg = isDark ? QkaTheme.neutral900 : Colors.white;
    final borderCol = isDark ? QkaTheme.neutral600 : QkaTheme.neutral200;
    final textCol = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderCol, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: QkaTheme.neutral400),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: textCol,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GraphItem {
  final double x;
  final double y;
  final Widget widget;

  _GraphItem({required this.x, required this.y, required this.widget});
}

class _GraphLinesPainter extends CustomPainter {
  final double centerX;
  final double centerY;
  final List<_GraphItem> outerItems;
  final Color lineColor;

  _GraphLinesPainter({
    required this.centerX,
    required this.centerY,
    required this.outerItems,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (final item in outerItems) {
      canvas.drawLine(Offset(centerX, centerY), Offset(item.x, item.y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
