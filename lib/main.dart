import 'package:flutter/material.dart';
import 'package:loading_indicators/global_loading.dart';
import 'package:loading_indicators/loading_indicator_preview.dart';
import 'package:loading_indicators/state_view_preview.dart';

void main() {
  GlobalLoading.show();

  runApp(const MyApp());

  Future.delayed(const Duration(milliseconds: 5000), GlobalLoading.hide);
}

enum AppThemeMode { system, light, dark }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // System is the default.
  AppThemeMode _themeMode = AppThemeMode.system;

  ThemeMode get _materialThemeMode {
    switch (_themeMode) {
      case AppThemeMode.system:
        return ThemeMode.system;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  void _changeTheme(AppThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Layout Preview',

      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      themeMode: _materialThemeMode,
      navigatorObservers: [GlobalLoadingNavigatorObserver()],
      builder: (context, child) {
        return GlobalLoadingOverlay(child: child ?? const SizedBox.shrink());
      },

      home: MyHomePage(themeMode: _themeMode, onThemeChanged: _changeTheme),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  final AppThemeMode themeMode;
  final ValueChanged<AppThemeMode> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout'),

        actions: [
          IconButton(
            tooltip: 'Change theme',
            icon: Icon(_getThemeIcon(themeMode)),
            onPressed: () {
              onThemeChanged(_getNextTheme(themeMode));
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getThemeIcon(themeMode), size: 64),

            const SizedBox(height: 20),

            Text(
              'Screen Preview',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 8),

            Text(
              'Current theme: ${_getThemeName(themeMode)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 32),

            ElevatedButton.icon(
              onPressed: () async {
                await GlobalLoading.push(
                  context,
                  const LoadingIndicatorPreview(),
                );
              },
              icon: const Icon(Icons.hourglass_bottom_rounded),
              label: const Text('Loading Indicators'),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () async {
                await GlobalLoading.push(context, const StateViewPreview());
              },
              icon: const Icon(Icons.layers_outlined),
              label: const Text('State View'),
            ),
          ],
        ),
      ),
    );
  }

  static AppThemeMode _getNextTheme(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return AppThemeMode.light;
      case AppThemeMode.light:
        return AppThemeMode.dark;
      case AppThemeMode.dark:
        return AppThemeMode.system;
    }
  }

  static String _getThemeName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return 'System';
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
    }
  }

  static IconData _getThemeIcon(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return Icons.brightness_auto_rounded;
      case AppThemeMode.light:
        return Icons.light_mode_rounded;
      case AppThemeMode.dark:
        return Icons.dark_mode_rounded;
    }
  }
}
