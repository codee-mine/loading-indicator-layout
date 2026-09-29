import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_indicators/app_theme.dart';
import 'package:loading_indicators/loading_indicators.dart';

class GlobalLoading {
  GlobalLoading._();

  static final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  static Timer? _timer;

  static void show() {
    _timer?.cancel();
    isLoading.value = true;
  }

  static void hide() {
    _timer?.cancel();
    isLoading.value = false;
  }

  static void showFor([
    Duration duration = const Duration(milliseconds: 2000),
  ]) {
    show();

    _timer = Timer(duration, hide);
  }

  static void dispose() {
    _timer?.cancel();
    isLoading.dispose();
  }

  static Future<T?> push<T extends Object?>(
    BuildContext context,
    Widget page,
  ) async {
    show();

    final future = Navigator.of(
      context,
    ).push<T>(MaterialPageRoute(builder: (_) => page));
    await WidgetsBinding.instance.endOfFrame;

    await Future.delayed(const Duration(milliseconds: 2000));

    hide();

    return future;
  }
}

class GlobalLoadingOverlay extends StatelessWidget {
  const GlobalLoadingOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GlobalLoading.isLoading,
      builder: (context, isLoading, _) {
        return Stack(
          children: [
            child,

            Positioned.fill(
              child: IgnorePointer(
                ignoring: !isLoading,
                child: AnimatedOpacity(
                  opacity: isLoading ? 1 : 0,
                  duration: const Duration(milliseconds: 180),
                  child: isLoading
                      ? ColoredBox(
                          color: Colors.black.withValues(
                            alpha: context.isDarkMode ? 0.45 : 0.18,
                          ),
                          child: const Center(
                            child: CustomLoadingIndicator(
                              type: LoadingType.spinningCircle,
                              size: LoadingSize.medium,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class GlobalLoadingNavigatorObserver extends NavigatorObserver {
  bool _isInitialRoute = true;

  void _startNavigationLoading() {
    if (_isInitialRoute) {
      _isInitialRoute = false;
      return;
    }

    GlobalLoading.show();

    Future.delayed(const Duration(milliseconds: 400), GlobalLoading.hide);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    if (previousRoute != null) {
      _startNavigationLoading();
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    _startNavigationLoading();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    _startNavigationLoading();
  }
}
