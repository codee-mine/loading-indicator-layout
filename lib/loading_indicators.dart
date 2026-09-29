import 'dart:math';
import 'package:flutter/material.dart';
import 'package:loading_indicators/app_config.dart';
import 'package:loading_indicators/app_theme.dart';
import 'package:loading_indicators/skeleton_shimmer.dart';

enum LoadingType {
  circular,
  linear,
  shimmer,
  bouncingDots,
  spinningCircle,
  wave,
}

enum LoadingSize { tiny, small, medium, large, extraLarge }

extension on LoadingSize {
  double get px => switch (this) {
    LoadingSize.tiny => AppSizes.loaderTiny,
    LoadingSize.small => AppSizes.loaderSmall,
    LoadingSize.medium => AppSizes.loaderMedium,
    LoadingSize.large => AppSizes.loaderLarge,
    LoadingSize.extraLarge => AppSizes.loaderExtraLarge,
  };
}

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.type = LoadingType.circular,
    this.size = LoadingSize.medium,
    this.color,
    this.text,
    this.value,
  });

  final LoadingType type;
  final LoadingSize size;
  final Color? color;
  final String? text;
  final double? value;

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.loadingIndicatorForeground;
    final track = context.loadingIndicatorBackground;
    final px = size.px;
    final stroke = px < AppSizes.loaderMedium ? 2.0 : AppSizes.loaderStroke;

    final indicator = switch (type) {
      LoadingType.circular => SizedBox.square(
        dimension: px,
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: stroke,
          color: c,
          backgroundColor: track,
          strokeCap: StrokeCap.round,
        ),
      ),
      LoadingType.linear => SizedBox(
        width: px * 4,
        child: LinearProgressIndicator(
          value: value,
          color: c,
          backgroundColor: track,
          minHeight: stroke + 1,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
      ),
      LoadingType.shimmer => SkeletonShimmer(
        child: SkeletonBox(width: px * 4, height: px * 0.7),
      ),
      LoadingType.bouncingDots => _BouncingDots(color: c, size: px),
      LoadingType.spinningCircle => _SpinningArc(
        color: c,
        size: px,
        stroke: stroke,
      ),
      LoadingType.wave => _Wave(color: c, size: px),
    };

    return Semantics(
      label: text ?? 'Loading',
      value: value != null ? '${(value! * 100).round()}%' : null,
      child: ExcludeSemantics(
        child: text == null
            ? indicator
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  indicator,
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    text!,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}

class CustomLoadingOverlay extends StatelessWidget {
  const CustomLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.loadingText,
    this.loadingType = LoadingType.circular,
  });

  final Widget child;
  final bool isLoading;
  final String? loadingText;
  final LoadingType loadingType;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !isLoading,
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: IgnorePointer(
              ignoring: !isLoading,
              child: AnimatedOpacity(
                opacity: isLoading ? 1 : 0,
                duration: AppDurations.fast,
                child: isLoading
                    ? ColoredBox(
                        color: Colors.black.withValues(
                          alpha: context.isDarkMode ? 0.6 : 0.35,
                        ),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.xl),
                            margin: const EdgeInsets.all(AppSpacing.xxl),
                            decoration: BoxDecoration(
                              color: context.cardColor,
                              borderRadius: BorderRadius.circular(AppRadius.xl),
                            ),
                            child: CustomLoadingIndicator(
                              type: loadingType,
                              text: loadingText ?? 'Loading...',
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

mixin _LoopingAnimation<T extends StatefulWidget>
    on State<T>, SingleTickerProviderStateMixin<T> {
  Duration get period;

  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: period,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      controller.value = 0.5;
      controller.stop();
    } else if (!controller.isAnimating) {
      controller.repeat();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _BouncingDots extends StatefulWidget {
  const _BouncingDots({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  State<_BouncingDots> createState() => _BouncingDotsState();
}

class _BouncingDotsState extends State<_BouncingDots>
    with SingleTickerProviderStateMixin, _LoopingAnimation {
  @override
  Duration get period => AppDurations.typingIndicator;

  @override
  Widget build(BuildContext context) {
    final dot = widget.size * 0.2;
    return RepaintBoundary(
      child: SizedBox(
        width: widget.size,
        height: widget.size * 0.6,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < 3; i++)
                Transform.translate(
                  offset: Offset(0, -_bounce(controller.value, i) * dot),
                  child: Container(
                    width: dot,
                    height: dot,
                    margin: EdgeInsets.symmetric(horizontal: dot * 0.25),
                    decoration: BoxDecoration(
                      color: widget.color.withValues(
                        alpha: 0.5 + 0.5 * _bounce(controller.value, i),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  static double _bounce(double t, int i) {
    final phase = (t - i * 0.15) % 1.0;
    return phase < 0.5 ? sin(phase * 2 * pi).clamp(0.0, 1.0) : 0.0;
  }
}

class _Wave extends StatefulWidget {
  const _Wave({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  State<_Wave> createState() => _WaveState();
}

class _WaveState extends State<_Wave>
    with SingleTickerProviderStateMixin, _LoopingAnimation {
  @override
  Duration get period => AppDurations.typingIndicator;

  @override
  Widget build(BuildContext context) {
    final bar = widget.size * 0.1;
    return RepaintBoundary(
      child: SizedBox(
        width: widget.size,
        height: widget.size * 0.6,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < 5; i++)
                Container(
                  width: bar,
                  height:
                      widget.size *
                      0.6 *
                      (0.3 +
                          0.7 *
                              (0.5 +
                                  0.5 *
                                      sin(
                                        (controller.value - i * 0.12) * 2 * pi,
                                      ))),
                  margin: EdgeInsets.symmetric(horizontal: bar * 0.3),
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(bar),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpinningArc extends StatefulWidget {
  const _SpinningArc({
    required this.color,
    required this.size,
    required this.stroke,
  });

  final Color color;
  final double size;
  final double stroke;

  @override
  State<_SpinningArc> createState() => _SpinningArcState();
}

class _SpinningArcState extends State<_SpinningArc>
    with SingleTickerProviderStateMixin, _LoopingAnimation {
  @override
  Duration get period => const Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox.square(
        dimension: widget.size,
        child: CustomPaint(
          painter: _ArcPainter(
            color: widget.color,
            stroke: widget.stroke,
            progress: controller,
          ),
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  _ArcPainter({
    required this.color,
    required this.stroke,
    required this.progress,
  }) : super(repaint: progress);

  final Color color;
  final double stroke;
  final Animation<double> progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - stroke / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(
      center,
      radius,
      paint..color = color.withValues(alpha: 0.15),
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      2 * pi * progress.value - pi / 2,
      pi * 0.6,
      false,
      paint..color = color,
    );
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.color != color || old.stroke != stroke || old.progress != progress;
}
