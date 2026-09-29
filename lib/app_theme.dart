import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_indicators/app_config.dart';

class AppTheme {
  AppTheme._();
  static final ThemeData lightTheme = _build(_Palette.light);
  static final ThemeData darkTheme = _build(_Palette.dark);

  static ThemeData _build(_Palette p) {
    final isDark = p.brightness == Brightness.dark;

    final colorScheme = ColorScheme(
      brightness: p.brightness,
      primary: p.primary,
      onPrimary: Colors.white,
      primaryContainer: p.primary.withValues(alpha: isDark ? 0.24 : 0.12),
      onPrimaryContainer: p.textPrimary,
      secondary: p.secondary,
      onSecondary: isDark ? AppColors.darkBackground : Colors.white,
      tertiary: p.accent,
      onTertiary: isDark ? AppColors.darkBackground : Colors.white,
      error: AppColors.dangerColor,
      onError: AppColors.onStatusColor,
      surface: p.surface,
      onSurface: p.textPrimary,
      onSurfaceVariant: p.textSecondary,
      surfaceContainerLowest: p.background,
      surfaceContainerLow: p.background,
      surfaceContainer: p.surface,
      surfaceContainerHigh: p.card,
      surfaceContainerHighest: p.chip,
      outline: p.divider,
      outlineVariant: p.divider,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: p.textPrimary,
      onInverseSurface: p.background,
      inversePrimary: p.secondary,
      surfaceTint: Colors.transparent,
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: p.brightness,
      colorScheme: colorScheme,
      fontFamily: AppTypography.fontFamily,
    );
    final textTheme = _textTheme(base.textTheme, p);

    OutlineInputBorder inputBorder(Color color, [double? width]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(
            color: color,
            width: width ?? AppSizes.borderWidth,
          ),
        );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
    );
    const buttonSize = Size(64, AppSizes.buttonHeight);

    return base.copyWith(
      primaryColor: p.primary,
      scaffoldBackgroundColor: p.background,
      canvasColor: p.background,
      cardColor: p.card,
      dividerColor: p.divider,
      disabledColor: p.hint,
      splashFactory: InkRipple.splashFactory,
      highlightColor: p.primary.withValues(alpha: 0.08),
      splashColor: p.primary.withValues(alpha: 0.12),
      hoverColor: p.primary.withValues(alpha: 0.06),
      focusColor: p.primary.withValues(alpha: 0.12),
      textTheme: textTheme,
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      extensions: [isDark ? ChatColors.dark : ChatColors.light],

      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        backgroundColor: p.appBar,
        surfaceTintColor: Colors.transparent,
        foregroundColor: p.textPrimary,
        shadowColor: p.divider,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(color: p.textPrimary, size: AppSizes.iconMd),
        actionsIconTheme: IconThemeData(
          color: p.textPrimary,
          size: AppSizes.iconMd,
        ),
        systemOverlayStyle: _systemOverlay(p),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: p.card,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(color: p.divider, width: AppSizes.borderWidth),
        ),
      ),

      listTileTheme: ListTileThemeData(
        iconColor: p.textSecondary,
        textColor: p.textPrimary,
        titleTextStyle: textTheme.titleMedium,
        subtitleTextStyle: textTheme.bodySmall,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        minVerticalPadding: AppSpacing.md,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? p.surface : p.background,
        hintStyle: textTheme.bodyMedium?.copyWith(color: p.hint),
        labelStyle: textTheme.bodyMedium?.copyWith(color: p.textSecondary),
        floatingLabelStyle: textTheme.bodyMedium?.copyWith(color: p.primary),
        prefixIconColor: p.textSecondary,
        suffixIconColor: p.textSecondary,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md + AppSpacing.xxs,
        ),
        border: inputBorder(Colors.transparent),
        enabledBorder: inputBorder(p.divider),
        disabledBorder: inputBorder(p.divider.withValues(alpha: 0.5)),
        focusedBorder: inputBorder(p.primary, AppSizes.focusBorderWidth),
        errorBorder: inputBorder(AppColors.dangerColor),
        focusedErrorBorder: inputBorder(
          AppColors.dangerColor,
          AppSizes.focusBorderWidth,
        ),
        errorStyle: textTheme.bodySmall?.copyWith(color: AppColors.dangerColor),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: p.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: p.chip,
          disabledForegroundColor: p.hint,
          minimumSize: buttonSize,
          elevation: 0,
          shape: buttonShape,
          textStyle: textTheme.labelLarge,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: p.primary,
          foregroundColor: Colors.white,
          minimumSize: buttonSize,
          shape: buttonShape,
          textStyle: textTheme.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? p.secondary : p.primary,
          side: BorderSide(color: p.divider, width: AppSizes.borderWidth),
          minimumSize: buttonSize,
          shape: buttonShape,
          textStyle: textTheme.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark ? p.secondary : p.primary,
          textStyle: textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: p.textPrimary),
      ),

      iconTheme: IconThemeData(color: p.textSecondary, size: AppSizes.iconMd),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: p.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        highlightElevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: p.appBar,
        surfaceTintColor: Colors.transparent,
        indicatorColor: p.primary.withValues(alpha: isDark ? 0.24 : 0.12),
        elevation: 0,
        height: 68,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelSmall?.copyWith(
            color: states.contains(WidgetState.selected)
                ? p.textPrimary
                : p.textSecondary,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: AppSizes.iconMd,
            color: states.contains(WidgetState.selected)
                ? (isDark ? p.secondary : p.primary)
                : p.textSecondary,
          ),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: p.appBar,
        selectedItemColor: isDark ? p.secondary : p.primary,
        unselectedItemColor: p.textSecondary,
        selectedLabelStyle: textTheme.labelSmall,
        unselectedLabelStyle: textTheme.labelSmall,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: isDark ? p.secondary : p.primary,
        unselectedLabelColor: p.textSecondary,
        labelStyle: textTheme.titleSmall,
        unselectedLabelStyle: textTheme.titleSmall,
        indicatorColor: isDark ? p.secondary : p.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: p.divider,
      ),

      dividerTheme: DividerThemeData(color: p.divider, thickness: 1, space: 1),

      chipTheme: ChipThemeData(
        backgroundColor: p.chip,
        selectedColor: p.primary.withValues(alpha: isDark ? 0.3 : 0.14),
        disabledColor: p.chip.withValues(alpha: 0.5),
        labelStyle: textTheme.labelMedium,
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
      ),

      badgeTheme: BadgeThemeData(
        backgroundColor: p.primary,
        textColor: Colors.white,
        textStyle: textTheme.labelSmall,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: p.hint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
      ),

      popupMenuTheme: PopupMenuThemeData(
        color: p.card,
        surfaceTintColor: Colors.transparent,
        textStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? p.card : p.textPrimary,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: isDark ? p.textPrimary : p.background,
        ),
        actionTextColor: p.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? Colors.white : p.hint,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? p.primary : p.chip,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? Colors.transparent
              : p.divider,
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? p.primary : null,
        ),
        checkColor: const WidgetStatePropertyAll(Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.xs),
        ),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? p.primary : p.hint,
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: p.primary,
        circularTrackColor: p.primary.withValues(alpha: isDark ? 0.2 : 0.15),
        linearTrackColor: p.primary.withValues(alpha: isDark ? 0.2 : 0.15),
        refreshBackgroundColor: p.surface,
      ),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: p.primary,
        selectionColor: p.primary.withValues(alpha: 0.25),
        selectionHandleColor: p.primary,
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: p.textPrimary,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        textStyle: textTheme.labelSmall?.copyWith(color: p.background),
      ),
    );
  }

  static TextTheme _textTheme(TextTheme base, _Palette p) {
    TextStyle? style(
      TextStyle? s,
      double size,
      FontWeight weight,
      Color color, {
      double? height,
      double? spacing,
    }) => s?.copyWith(
      fontFamily: AppTypography.fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: spacing,
    );

    return base.copyWith(
      displayLarge: style(
        base.displayLarge,
        AppTypography.displayLarge,
        FontWeight.w700,
        p.textPrimary,
        height: 1.2,
        spacing: -0.5,
      ),
      displayMedium: style(
        base.displayMedium,
        AppTypography.displayMedium,
        FontWeight.w700,
        p.textPrimary,
        height: 1.2,
        spacing: -0.4,
      ),
      displaySmall: style(
        base.displaySmall,
        AppTypography.displaySmall,
        FontWeight.w700,
        p.textPrimary,
        height: 1.25,
        spacing: -0.3,
      ),
      headlineMedium: style(
        base.headlineMedium,
        AppTypography.headlineMedium,
        FontWeight.w700,
        p.textPrimary,
        height: 1.3,
        spacing: -0.2,
      ),
      titleLarge: style(
        base.titleLarge,
        AppTypography.titleLarge,
        FontWeight.w700,
        p.textPrimary,
        height: 1.3,
        spacing: -0.2,
      ),
      titleMedium: style(
        base.titleMedium,
        AppTypography.titleMedium,
        FontWeight.w600,
        p.textPrimary,
        height: 1.35,
        spacing: 0,
      ),
      titleSmall: style(
        base.titleSmall,
        AppTypography.titleSmall,
        FontWeight.w600,
        p.textPrimary,
        height: 1.4,
        spacing: 0,
      ),
      bodyLarge: style(
        base.bodyLarge,
        AppTypography.bodyLarge,
        FontWeight.w400,
        p.textPrimary,
        height: 1.45,
        spacing: 0,
      ),
      bodyMedium: style(
        base.bodyMedium,
        AppTypography.bodyMedium,
        FontWeight.w400,
        p.textPrimary,
        height: 1.45,
        spacing: 0,
      ),
      bodySmall: style(
        base.bodySmall,
        AppTypography.bodySmall,
        FontWeight.w400,
        p.textSecondary,
        height: 1.4,
        spacing: 0,
      ),
      labelLarge: style(
        base.labelLarge,
        AppTypography.labelLarge,
        FontWeight.w600,
        p.textPrimary,
        height: 1.3,
        spacing: 0.1,
      ),
      labelMedium: style(
        base.labelMedium,
        AppTypography.labelMedium,
        FontWeight.w500,
        p.textSecondary,
        height: 1.3,
        spacing: 0.1,
      ),
      labelSmall: style(
        base.labelSmall,
        AppTypography.labelSmall,
        FontWeight.w500,
        p.textSecondary,
        height: 1.3,
        spacing: 0.2,
      ),
    );
  }

  static SystemUiOverlayStyle _systemOverlay(_Palette p) {
    final isDark = p.brightness == Brightness.dark;
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: p.brightness, // iOS
      systemNavigationBarColor: p.appBar,
      systemNavigationBarIconBrightness: isDark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    );
  }
}

class _Palette {
  const _Palette({
    required this.brightness,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.card,
    required this.appBar,
    required this.textPrimary,
    required this.textSecondary,
    required this.hint,
    required this.divider,
    required this.chip,
  });

  final Brightness brightness;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color card;
  final Color appBar;
  final Color textPrimary;
  final Color textSecondary;
  final Color hint;
  final Color divider;
  final Color chip;

  static const light = _Palette(
    brightness: Brightness.light,
    primary: AppColors.lightPrimary,
    secondary: AppColors.lightSecondary,
    accent: AppColors.lightAccent,
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    card: AppColors.lightCardBackground,
    appBar: AppColors.lightAppBar,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    hint: AppColors.lightTextHint,
    divider: AppColors.lightDivider,
    chip: AppColors.lightChipBackground,
  );

  static const dark = _Palette(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkSecondary,
    accent: AppColors.darkAccent,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    card: AppColors.darkCardBackground,
    appBar: AppColors.darkAppBar,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    hint: AppColors.darkTextHint,
    divider: AppColors.darkDivider,
    chip: AppColors.darkChipBackground,
  );
}

@immutable
class ChatColors extends ThemeExtension<ChatColors> {
  const ChatColors({
    required this.bubbleMe,
    required this.bubbleOther,
    required this.bubbleTextMe,
    required this.bubbleTextOther,
    required this.timeMe,
    required this.timeOther,
    required this.chatBackground,
    required this.composerBackground,
    required this.online,
    required this.typing,
    required this.readReceipt,
    required this.unreadBadge,
  });

  final Color bubbleMe;
  final Color bubbleOther;
  final Color bubbleTextMe;
  final Color bubbleTextOther;
  final Color timeMe;
  final Color timeOther;
  final Color chatBackground;
  final Color composerBackground;
  final Color online;
  final Color typing;
  final Color readReceipt;
  final Color unreadBadge;

  static const light = ChatColors(
    bubbleMe: AppColors.lightBubbleMe,
    bubbleOther: AppColors.lightBubbleOther,
    bubbleTextMe: AppColors.bubbleTextMe,
    bubbleTextOther: AppColors.lightTextPrimary,
    timeMe: Color(0xCCFFFFFF),
    timeOther: AppColors.lightTextSecondary,
    chatBackground: AppColors.lightBackground,
    composerBackground: AppColors.lightSurface,
    online: AppColors.onlineColor,
    typing: AppColors.lightSecondary,
    readReceipt: AppColors.darkSecondary,
    unreadBadge: AppColors.lightPrimary,
  );

  static const dark = ChatColors(
    bubbleMe: AppColors.darkBubbleMe,
    bubbleOther: AppColors.darkBubbleOther,
    bubbleTextMe: AppColors.bubbleTextMe,
    bubbleTextOther: AppColors.darkTextPrimary,
    timeMe: Color(0xCCFFFFFF),
    timeOther: AppColors.darkTextSecondary,
    chatBackground: AppColors.darkBackground,
    composerBackground: AppColors.darkSurface,
    online: AppColors.onlineColor,
    typing: AppColors.darkSecondary,
    readReceipt: AppColors.darkSecondary,
    unreadBadge: AppColors.darkPrimary,
  );

  @override
  ChatColors copyWith({
    Color? bubbleMe,
    Color? bubbleOther,
    Color? bubbleTextMe,
    Color? bubbleTextOther,
    Color? timeMe,
    Color? timeOther,
    Color? chatBackground,
    Color? composerBackground,
    Color? online,
    Color? typing,
    Color? readReceipt,
    Color? unreadBadge,
  }) {
    return ChatColors(
      bubbleMe: bubbleMe ?? this.bubbleMe,
      bubbleOther: bubbleOther ?? this.bubbleOther,
      bubbleTextMe: bubbleTextMe ?? this.bubbleTextMe,
      bubbleTextOther: bubbleTextOther ?? this.bubbleTextOther,
      timeMe: timeMe ?? this.timeMe,
      timeOther: timeOther ?? this.timeOther,
      chatBackground: chatBackground ?? this.chatBackground,
      composerBackground: composerBackground ?? this.composerBackground,
      online: online ?? this.online,
      typing: typing ?? this.typing,
      readReceipt: readReceipt ?? this.readReceipt,
      unreadBadge: unreadBadge ?? this.unreadBadge,
    );
  }

  @override
  ChatColors lerp(ThemeExtension<ChatColors>? other, double t) {
    if (other is! ChatColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return ChatColors(
      bubbleMe: l(bubbleMe, other.bubbleMe),
      bubbleOther: l(bubbleOther, other.bubbleOther),
      bubbleTextMe: l(bubbleTextMe, other.bubbleTextMe),
      bubbleTextOther: l(bubbleTextOther, other.bubbleTextOther),
      timeMe: l(timeMe, other.timeMe),
      timeOther: l(timeOther, other.timeOther),
      chatBackground: l(chatBackground, other.chatBackground),
      composerBackground: l(composerBackground, other.composerBackground),
      online: l(online, other.online),
      typing: l(typing, other.typing),
      readReceipt: l(readReceipt, other.readReceipt),
      unreadBadge: l(unreadBadge, other.unreadBadge),
    );
  }
}

extension ThemeColors on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  ChatColors get chat => theme.extension<ChatColors>() ?? ChatColors.light;
  bool get isDarkMode => theme.brightness == Brightness.dark;

  _Palette get _p => isDarkMode ? _Palette.dark : _Palette.light;

  // Brand
  Color get primaryColor => _p.primary;
  Color get secondaryColor => _p.secondary;
  Color get accentColor => _p.accent;
  Color get floatingButtonColor => _p.primary;

  // Surfaces
  Color get backgroundColor => _p.background;
  Color get scaffoldBackgroundColor => _p.background;
  Color get surfaceColor => _p.surface;
  Color get cardColor => _p.card;
  Color get appBarColor => _p.appBar;
  Color get chipBackground => _p.chip;
  Color get alertBackground => isDarkMode ? _p.card : _p.chip;

  // Text
  Color get textPrimary => _p.textPrimary;
  Color get textSecondary => _p.textSecondary;
  Color get textHint => _p.hint;
  Color get backgroundTextColor => _p.textPrimary;

  // Lines
  Color get dividerColor => _p.divider;
  Color get borderColor => _p.divider;

  // Status
  Color get errorColor => AppColors.dangerColor;
  Color get warningColor => AppColors.warningColor;
  Color get successColor => AppColors.successColor;
  Color get infoColor => AppColors.infoColor;

  // Icons
  Color get iconColor => _p.textPrimary;
  Color get iconSecondaryColor => _p.textSecondary;
  Color get iconInactiveColor => _p.hint;

  // Presence
  Color get statusActiveColor => chat.online;
  Color get statusInactiveColor => _p.hint;

  // Chat
  Color get chatBubbleMe => chat.bubbleMe;
  Color get chatBubbleOther => chat.bubbleOther;
  Color get chatTextMe => chat.bubbleTextMe;
  Color get chatTextOther => chat.bubbleTextOther;

  // Switch
  Color get switchActiveThumb => Colors.white;
  Color get switchActiveTrack => _p.primary;
  Color get switchInactiveThumb => _p.hint;
  Color get switchInactiveTrack => _p.chip;

  // Loading
  Color get loadingIndicatorForeground => _p.primary;
  Color get loadingIndicatorBackground =>
      _p.primary.withValues(alpha: isDarkMode ? 0.2 : 0.15);

  Color adaptiveColor({required Color light, required Color dark}) =>
      isDarkMode ? dark : light;

  double get lowOpacity => isDarkMode ? 0.7 : 0.5;
  double get mediumOpacity => isDarkMode ? 0.85 : 0.7;
  double get highOpacity => isDarkMode ? 1.0 : 0.9;
}
