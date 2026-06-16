// lib/shared/widgets/entity_badge.dart

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

enum BadgeSize { sm, md, lg }

class EntityBadge extends StatelessWidget {
  final String entityType;
  final BadgeSize size;
  final bool isDiscovered;

  const EntityBadge({
    Key? key,
    required this.entityType,
    required this.size,
    required this.isDiscovered,
  }) : super(key: key);

  double get _dimension {
    switch (size) {
      case BadgeSize.sm:
        return 32.0;
      case BadgeSize.md:
        return 48.0;
      case BadgeSize.lg:
        return 80.0;
    }
  }

  Color get _fillColor {
    switch (entityType.toLowerCase()) {
      case 'prophet':
        return const Color(0xFF5DCAA5); // teal-200
      case 'historical_figure':
        return const Color(0xFFFAC775); // amber-200
      case 'matriarch':
        return const Color(0xFFF0997B); // coral-200
      case 'location':
        return const Color(0xFFFFEFCF); // amber-100 lighter
      case 'animal':
        return const Color(0xFF97C459); // green-200
      case 'plant':
        return const Color(0xFFC0DD97); // green-100
      case 'nature':
        return const Color(0xFF97C459); // green-200
      case 'theme':
        return const Color(0xFBAFA9EC); // purple-200
      default:
        return QkaTheme.neutral200; // default neutral-200
    }
  }

  Color get _darkerRampColor {
    switch (entityType.toLowerCase()) {
      case 'prophet':
        return const Color(0xFF085041);
      case 'historical_figure':
        return const Color(0xFFEF9F27);
      case 'matriarch':
        return const Color(0xFFD85A30);
      case 'location':
        return const Color(0xFFEF9F27);
      case 'animal':
      case 'nature':
        return const Color(0xFF639922);
      case 'plant':
        return const Color(0xFF639922);
      case 'theme':
        return const Color(0xFF7F77DD);
      default:
        return QkaTheme.neutral600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final badgeWidget = ClipPath(
      clipper: PolygonClipper(sides: 6), // Hexagon shape
      child: Container(
        width: _dimension,
        height: _dimension,
        color: _fillColor,
        child: CustomPaint(
          painter: BadgeSubShapePainter(
            entityType: entityType,
            baseColor: _darkerRampColor,
          ),
        ),
      ),
    );

    if (!isDiscovered) {
      return ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        child: badgeWidget,
      );
    }

    return badgeWidget;
  }
}

class PolygonClipper extends CustomClipper<Path> {
  final int sides;

  PolygonClipper({this.sides = 6});

  @override
  Path getClip(Size size) {
    final path = Path();
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2;
    
    final double startAngle = -pi / 2;
    final double angleStep = 2 * pi / sides;
    
    for (int i = 0; i < sides; i++) {
      final double angle = startAngle + i * angleStep;
      final double x = centerX + radius * cos(angle);
      final double y = centerY + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class BadgeSubShapePainter extends CustomPainter {
  final String entityType;
  final Color baseColor;

  BadgeSubShapePainter({required this.entityType, required this.baseColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = baseColor.withOpacity(0.35)
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    switch (entityType.toLowerCase()) {
      case 'prophet':
        final path = Path()
          ..moveTo(centerX, centerY - radius * 0.5)
          ..lineTo(centerX - radius * 0.5, centerY + radius * 0.4)
          ..lineTo(centerX + radius * 0.5, centerY + radius * 0.4)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case 'historical_figure':
        final path = Path()
          ..moveTo(centerX, centerY - radius * 0.6)
          ..lineTo(centerX + radius * 0.6, centerY)
          ..lineTo(centerX, centerY + radius * 0.6)
          ..lineTo(centerX - radius * 0.6, centerY)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case 'matriarch':
        final strokePaint = Paint()
          ..color = baseColor.withOpacity(0.4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.1;
        canvas.drawCircle(Offset(centerX, centerY), radius * 0.4, strokePaint);
        break;
      case 'location':
        final strokePaint = Paint()
          ..color = baseColor.withOpacity(0.4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.08;
        canvas.drawLine(Offset(centerX, centerY - radius * 0.6), Offset(centerX, centerY + radius * 0.6), strokePaint);
        canvas.drawLine(Offset(centerX - radius * 0.6, centerY), Offset(centerX + radius * 0.6, centerY), strokePaint);
        break;
      case 'animal':
      case 'nature':
        final path = Path()
          ..moveTo(centerX, centerY - radius * 0.5)
          ..quadraticBezierTo(centerX + radius * 0.5, centerY, centerX, centerY + radius * 0.5)
          ..quadraticBezierTo(centerX - radius * 0.5, centerY, centerX, centerY - radius * 0.5)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case 'plant':
        final path = Path()
          ..moveTo(centerX, centerY - radius * 0.4)
          ..lineTo(centerX + radius * 0.3, centerY + radius * 0.4)
          ..lineTo(centerX - radius * 0.3, centerY + radius * 0.4)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case 'theme':
        final path = Path()
          ..moveTo(centerX, centerY - radius * 0.5)
          ..lineTo(centerX + radius * 0.5, centerY)
          ..lineTo(centerX, centerY + radius * 0.5)
          ..lineTo(centerX - radius * 0.5, centerY)
          ..close();
        canvas.drawPath(path, paint);
        break;
      default:
        canvas.drawRect(
          Rect.fromCenter(center: Offset(centerX, centerY), width: radius * 0.8, height: radius * 0.8),
          paint,
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
