// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';

/// Custom theme extension to house QKA-specific tokens not covered by standard Material 3.
/// This makes custom values accessible anywhere in the widget tree via:
/// `Theme.of(context).extension<QkaThemeExtension>()`
class QkaThemeExtension extends ThemeExtension<QkaThemeExtension> {
  final Color constellationBg;
  final Color prophetColor;
  final Color locationColor;
  final Color natureColor;
  final Color themeColor;
  final Color matriarchColor;
  final Color undiscoveredColor;
  final Color washBg;
  final Color washText;

  final String fontArabicPrimary;
  final String fontArabicSecondary;
  final double leadingArabic;

  const QkaThemeExtension({
    required this.constellationBg,
    required this.prophetColor,
    required this.locationColor,
    required this.natureColor,
    required this.themeColor,
    required this.matriarchColor,
    required this.undiscoveredColor,
    required this.washBg,
    required this.washText,
    required this.fontArabicPrimary,
    required this.fontArabicSecondary,
    required this.leadingArabic,
  });

  @override
  QkaThemeExtension copyWith({
    Color? constellationBg,
    Color? prophetColor,
    Color? locationColor,
    Color? natureColor,
    Color? themeColor,
    Color? matriarchColor,
    Color? undiscoveredColor,
    Color? washBg,
    Color? washText,
    String? fontArabicPrimary,
    String? fontArabicSecondary,
    double? leadingArabic,
  }) {
    return QkaThemeExtension(
      constellationBg: constellationBg ?? this.constellationBg,
      prophetColor: prophetColor ?? this.prophetColor,
      locationColor: locationColor ?? this.locationColor,
      natureColor: natureColor ?? this.natureColor,
      themeColor: themeColor ?? this.themeColor,
      matriarchColor: matriarchColor ?? this.matriarchColor,
      undiscoveredColor: undiscoveredColor ?? this.undiscoveredColor,
      washBg: washBg ?? this.washBg,
      washText: washText ?? this.washText,
      fontArabicPrimary: fontArabicPrimary ?? this.fontArabicPrimary,
      fontArabicSecondary: fontArabicSecondary ?? this.fontArabicSecondary,
      leadingArabic: leadingArabic ?? this.leadingArabic,
    );
  }

  @override
  QkaThemeExtension lerp(ThemeExtension<QkaThemeExtension>? other, double t) {
    if (other is! QkaThemeExtension) {
      return this;
    }
    return QkaThemeExtension(
      constellationBg: Color.lerp(constellationBg, other.constellationBg, t)!,
      prophetColor: Color.lerp(prophetColor, other.prophetColor, t)!,
      locationColor: Color.lerp(locationColor, other.locationColor, t)!,
      natureColor: Color.lerp(natureColor, other.natureColor, t)!,
      themeColor: Color.lerp(themeColor, other.themeColor, t)!,
      matriarchColor: Color.lerp(matriarchColor, other.matriarchColor, t)!,
      undiscoveredColor: Color.lerp(undiscoveredColor, other.undiscoveredColor, t)!,
      washBg: Color.lerp(washBg, other.washBg, t)!,
      washText: Color.lerp(washText, other.washText, t)!,
      fontArabicPrimary: other.fontArabicPrimary,
      fontArabicSecondary: other.fontArabicSecondary,
      leadingArabic: other.leadingArabic,
    );
  }
}

/// Static theme configurations matching the QKA design specification.
class QkaTheme {
  QkaTheme._();

  // Core color definitions
  static const Color lightSurface = Color(0xFFFDFCFA);
  static const Color darkSurface = Color(0xFF1A1815);
  static const Color constellationBg = Color(0xFF0D1B2A);

  static const Color teal50 = Color(0xFFE1F5EE);
  static const Color teal200 = Color(0xFF5DCAA5);
  static const Color teal400 = Color(0xFF1D9E75);
  static const Color teal600 = Color(0xFF0F6E56);
  static const Color teal800 = Color(0xFF085041);

  static const Color neutral50 = Color(0xFFF4F2EE);
  static const Color neutral100 = Color(0xFFE8E5DF);
  static const Color neutral200 = Color(0xFFC9C6BE);
  static const Color neutral400 = Color(0xFF8C8880);
  static const Color neutral600 = Color(0xFF5A574F);
  static const Color neutral800 = Color(0xFF2C2A25);
  static const Color neutral900 = Color(0xFF1A1815);

  // Custom extension setups
  static const _themeExtensionLight = QkaThemeExtension(
    constellationBg: constellationBg,
    prophetColor: Color(0xFF1D9E75),
    locationColor: Color(0xFFEF9F27),
    natureColor: Color(0xFF639922),
    themeColor: Color(0xFF7F77DD),
    matriarchColor: Color(0xFFD85A30),
    undiscoveredColor: Color(0xFF2A2E35),
    washBg: Color(0xFFB8E8D8),
    washText: Colors.white,
    fontArabicPrimary: 'Amiri Quran',
    fontArabicSecondary: 'KFGQPC Uthmanic',
    leadingArabic: 2.2,
  );

  static const _themeExtensionDark = QkaThemeExtension(
    constellationBg: constellationBg,
    prophetColor: Color(0xFF1D9E75),
    locationColor: Color(0xFFEF9F27),
    natureColor: Color(0xFF639922),
    themeColor: Color(0xFF7F77DD),
    matriarchColor: Color(0xFFD85A30),
    undiscoveredColor: Color(0xFF2A2E35),
    washBg: Color(0xFF085041), // Adjusted for dark contrast on wash sheet
    washText: Colors.white,
    fontArabicPrimary: 'Amiri Quran',
    fontArabicSecondary: 'KFGQPC Uthmanic',
    leadingArabic: 2.2,
  );

  /// Light theme definition matching QKA visual specs
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: teal400,
        brightness: Brightness.light,
        primary: teal400,
        onPrimary: Colors.white,
        primaryContainer: teal50,
        onPrimaryContainer: teal800,
        surface: lightSurface,
        onSurface: neutral800,
        onSurfaceVariant: neutral600,
        outline: neutral200,
        outlineVariant: neutral100,
      ),
      scaffoldBackgroundColor: lightSurface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: neutral800),
        titleTextStyle: TextStyle(
          color: neutral800,
          fontFamily: 'Serif',
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightSurface,
        elevation: 0,
        selectedItemColor: teal400,
        unselectedItemColor: neutral400,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
      ),
      cardTheme: CardThemeData(
        color: neutral50,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: neutral200, width: 0.5),
          borderRadius: BorderRadius.circular(8), // radius-md
        ),
        margin: EdgeInsets.zero,
      ),
      textTheme: const TextTheme(
        // size-display (40px, serif, bold)
        displayLarge: TextStyle(
          fontFamily: 'Serif',
          fontSize: 40,
          fontWeight: FontWeight.w700,
          height: 1.4,
          color: neutral800,
        ),
        // size-title (24px, UI font, regular/bold)
        titleLarge: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 1.4,
          color: neutral800,
        ),
        // size-body (16px, UI font, leading-body 1.7)
        bodyLarge: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.7,
          color: neutral600,
        ),
        // size-secondary (14px, UI font)
        bodyMedium: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.7,
          color: neutral400,
        ),
        // size-caption (12px, UI font)
        bodySmall: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.4,
          color: neutral400,
        ),
        // size-label (11px, UI font, medium weight)
        labelSmall: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.4,
          color: neutral600,
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        _themeExtensionLight,
      ],
    );
  }

  /// Dark theme definition matching QKA visual specs
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: teal400,
        brightness: Brightness.dark,
        primary: teal400,
        onPrimary: Colors.white,
        primaryContainer: teal600,
        onPrimaryContainer: teal50,
        surface: darkSurface,
        onSurface: Colors.white,
        onSurfaceVariant: neutral200,
        outline: neutral400,
        outlineVariant: neutral600,
      ),
      scaffoldBackgroundColor: darkSurface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Serif',
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        elevation: 0,
        selectedItemColor: teal400,
        unselectedItemColor: neutral400,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
      ),
      cardTheme: CardThemeData(
        color: neutral900,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: neutral600, width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.zero,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Serif',
          fontSize: 40,
          fontWeight: FontWeight.w700,
          height: 1.4,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 1.4,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.7,
          color: neutral200,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.7,
          color: neutral400,
        ),
        bodySmall: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.4,
          color: neutral400,
        ),
        labelSmall: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.4,
          color: neutral200,
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        _themeExtensionDark,
      ],
    );
  }
}
