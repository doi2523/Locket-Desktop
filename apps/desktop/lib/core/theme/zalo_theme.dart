import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZaloColors {
  // Brand colors
  static const Color primary = Color(0xFF0068FF);
  static const Color primaryDark = Color(0xFF0052CC);
  static const Color primaryLight = Color(0xFFE5EFFF);
  
  // Neutral colors - Light
  static const Color background = Color(0xFFF4F5F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color railBackground = Color(0xFFFFCC00); // Locket Yellow Bar
  static const Color railIconColor = Color(0xFF1E1E1E);
  static const Color railIconInactive = Color(0xFF555555);
  static const Color railDarkBackground = Color(0xFF1E2638);
  
  // Borders & Dividers
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFEEEEEE);
  
  // Text colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
  
  // Chat bubbles
  static const Color bubbleIncoming = Color(0xFFFFFFFF);
  static const Color bubbleOutgoing = Color(0xFFE5EFFF);
  static const Color bubbleOutgoingText = Color(0xFF003884);
  
  // Badges & Status
  static const Color online = Color(0xFF10B981);
  static const Color badgeRed = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  
  // Locket Accent
  static const Color locketYellow = Color(0xFFFFCC00);
  static const Color locketYellowLight = Color(0xFFFFF7D6);
  static const Color locketOrange = Color(0xFFFF9500);

  // Border Radius Constants
  static const double radiusSm = 10.0;
  static const double radiusMd = 16.0;
  static const double radiusLg = 22.0;
  static const double radiusXl = 28.0;
  static const double radiusPill = 999.0;
}

class ZaloTheme {
  static const List<String> emojiFontFallback = [
    'SF Pro Display',
    'SF Pro Text',
    '.AppleSystemUIFont',
    'Helvetica Neue',
    'Arial',
    'Apple Color Emoji',
    'Segoe UI Emoji',
    'Segoe UI Symbol',
    'Noto Color Emoji',
    'sans-serif',
  ];

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();
    final textTheme = baseTextTheme.apply(
      fontFamilyFallback: emojiFontFallback,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: ZaloColors.primary,
      fontFamily: GoogleFonts.inter().fontFamily,
      fontFamilyFallback: emojiFontFallback,
      scaffoldBackgroundColor: ZaloColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ZaloColors.primary,
        primary: ZaloColors.primary,
        surface: ZaloColors.surface,
      ),
      textTheme: textTheme,
      dividerTheme: const DividerThemeData(
        color: ZaloColors.divider,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ZaloColors.surface,
        foregroundColor: ZaloColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
    );
  }
}
