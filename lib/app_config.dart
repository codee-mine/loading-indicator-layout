import 'package:flutter/material.dart';

class AppConfig {
  AppConfig._();

  static const String appName = 'Layout';
  static const String appVersion = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: '1.0.0',
  );
}

class AppColors {
  AppColors._();

  // Light
  static const Color lightPrimary = Color(0xFF4F46E5);
  static const Color lightSecondary = Color(0xFF0369A1);
  static const Color lightAccent = Color(0xFF16A34A);
  static const Color lightBackground = Color(0xFFF3F4F9);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightAppBar = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF5B6475);
  static const Color lightTextHint = Color(0xFF8A93A5);
  static const Color lightDivider = Color(0xFFE3E6EE);
  static const Color lightChipBackground = Color(0xFFECEEF6);

  // Dark
  static const Color darkPrimary = Color(0xFF5B5BF0);
  static const Color darkSecondary = Color(0xFF7DD3FC);
  static const Color darkAccent = Color(0xFF4ADE80);
  static const Color darkBackground = Color(0xFF0B0E14);
  static const Color darkSurface = Color(0xFF141925);
  static const Color darkCardBackground = Color(0xFF1A2030);
  static const Color darkAppBar = Color(0xFF10141D);
  static const Color darkTextPrimary = Color(0xFFF1F3F9);
  static const Color darkTextSecondary = Color(0xFF9AA3B5);
  static const Color darkTextHint = Color(0xFF7A8296);
  static const Color darkDivider = Color(0xFF262C3B);
  static const Color darkChipBackground = Color(0xFF1E2433);

  // Chat
  static const Color lightBubbleMe = lightPrimary;
  static const Color lightBubbleOther = Color(0xFFFFFFFF);
  static const Color darkBubbleMe = Color(0xFF4F46E5);
  static const Color darkBubbleOther = Color(0xFF1E2433);
  static const Color bubbleTextMe = Color(0xFFFFFFFF);
  static const Color onlineColor = Color(0xFF22C55E);

  /// Avatar without a photo
  static const List<Color> avatarPalette = [
    Color(0xFF4F46E5),
    Color(0xFF0891B2),
    Color(0xFF059669),
    Color(0xFFD97706),
    Color(0xFFDB2777),
    Color(0xFF7C3AED),
    Color(0xFF2563EB),
    Color(0xFFDC2626),
  ];

  // Status
  static const Color dangerColor = Color(0xFFDC2626);
  static const Color successColor = Color(0xFF059669);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color infoColor = Color(0xFF0284C7);
  static const Color onStatusColor = Color(0xFFFFFFFF);
}

class AppSpacing {
  AppSpacing._();

  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

class AppRadius {
  AppRadius._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double bubble = 18;
  static const double bubbleTail = 4;
  static const double pill = 999;
}

class AppSizes {
  AppSizes._();

  static const double buttonHeight = 52;
  static const double buttonHeightSmall = 36;
  static const double buttonHeightMedium = 44;
  static const double buttonHeightLarge = buttonHeight;
  static const double iconButton = 44;
  static const double fab = 56;
  static const double inputMinHeight = 48;
  static const double iconSm = 18;
  static const double iconMd = 22;
  static const double iconLg = 28;
  static const double avatarSm = 32;
  static const double avatarMd = 44;
  static const double avatarLg = 64;
  static const double onlineDot = 12;
  static const double borderWidth = 1;
  static const double focusBorderWidth = 1.5;
  static const double multilineMinHeight = 96;

  // Loading indicators
  static const double loaderTiny = 16;
  static const double loaderSmall = 24;
  static const double loaderMedium = 40;
  static const double loaderLarge = 56;
  static const double loaderExtraLarge = 72;
  static const double loaderStroke = 3;

  static const double bubbleMaxWidthFactor = 0.78;
}

class AppTypography {
  AppTypography._();
  static const String? fontFamily = null;

  static const double displayLarge = 32;
  static const double displayMedium = 28;
  static const double displaySmall = 24;
  static const double headlineMedium = 22;
  static const double titleLarge = 20;
  static const double titleMedium = 16;
  static const double titleSmall = 14;
  static const double bodyLarge = 16;
  static const double bodyMedium = 15;
  static const double bodySmall = 13;
  static const double labelLarge = 15;
  static const double labelMedium = 13;
  static const double labelSmall = 11;

  static const double message = 15.5;
  static const double messageTime = 11;
}

class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
  static const Duration typingIndicator = Duration(milliseconds: 1200);
  static const Duration shimmer = Duration(milliseconds: 1400);
  static const Duration snackbar = Duration(seconds: 3);

  static const Curve curve = Curves.easeOutCubic;
}
