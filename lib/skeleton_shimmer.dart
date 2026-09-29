import 'package:flutter/material.dart';
import 'package:loading_indicators/app_config.dart';
import 'package:loading_indicators/app_theme.dart';

enum ViewState { loading, empty, error, content }

enum SkeletonType { list, content }

class StateView extends StatelessWidget {
  const StateView({
    super.key,
    required this.state,
    required this.builder,
    this.skeletonType = SkeletonType.list,
    this.loading,
    this.empty,
    this.error,
    this.errorMessage,
    this.onRetry,
  });

  final ViewState state;
  final WidgetBuilder builder;
  final SkeletonType skeletonType;

  final Widget? loading;
  final Widget? empty;
  final Widget? error;

  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final child = switch (state) {
      ViewState.loading => loading ?? SkeletonList(type: skeletonType),
      ViewState.empty => empty ?? const EmptyStateView(),
      ViewState.error =>
        error ?? ErrorStateView(message: errorMessage, onRetry: onRetry),
      ViewState.content => builder(context),
    };

    return AnimatedSwitcher(
      duration: AppDurations.normal,
      switchInCurve: AppDurations.curve,
      switchOutCurve: AppDurations.curve,
      child: KeyedSubtree(key: ValueKey(state), child: child),
    );
  }
}

class SkeletonList extends StatelessWidget {
  const SkeletonList({
    super.key,
    this.type = SkeletonType.list,
    this.itemCount = 10,
  });

  final SkeletonType type;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading',
      liveRegion: true,
      child: ExcludeSemantics(
        child: SkeletonShimmer(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            itemCount: itemCount,
            itemBuilder: (context, i) => switch (type) {
              SkeletonType.list => const SkeletonChatTile(),
              SkeletonType.content => SkeletonMessageBubble(isMe: i % 3 == 1),
            },
          ),
        ),
      ),
    );
  }
}

class SkeletonShimmer extends StatefulWidget {
  const SkeletonShimmer({super.key, required this.child});

  final Widget child;

  @override
  State<SkeletonShimmer> createState() => _SkeletonShimmerState();
}

class _SkeletonShimmerState extends State<SkeletonShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.shimmer,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return widget.child;

    final base = context.chipBackground;
    final highlight = context.isDarkMode
        ? context.dividerColor
        : context.surfaceColor;

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (context, child) => ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) => LinearGradient(
            begin: const Alignment(-1, -0.3),
            end: const Alignment(1, 0.3),
            colors: [base, highlight, base],
            stops: const [0.35, 0.5, 0.65],
            transform: _SlideGradient(_controller.value),
          ).createShader(bounds),
          child: child,
        ),
      ),
    );
  }
}

class _SlideGradient extends GradientTransform {
  const _SlideGradient(this.progress);

  final double progress;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * (progress * 2 - 1), 0, 0);
}

class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    this.width,
    this.height = 12,
    this.radius = AppRadius.sm,
  });

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.chipBackground,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class SkeletonChatTile extends StatelessWidget {
  const SkeletonChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          SkeletonBox(
            width: AppSizes.avatarMd,
            height: AppSizes.avatarMd,
            radius: AppRadius.pill,
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.45,
                  child: SkeletonBox(height: 14),
                ),
                SizedBox(height: AppSpacing.sm),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: SkeletonBox(height: 12),
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.md),
          SkeletonBox(width: 32, height: 10),
        ],
      ),
    );
  }
}

class SkeletonMessageBubble extends StatelessWidget {
  const SkeletonMessageBubble({super.key, this.isMe = false});

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: isMe ? 0.5 : 0.65,
          child: const SkeletonBox(height: 40, radius: AppRadius.bubble),
        ),
      ),
    );
  }
}

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    super.key,
    this.icon = Icons.chat_bubble_outline_rounded,
    this.title = 'Not yet',
    this.message = 'Start and it will show up here.',
    this.actionLabel,
    this.onAction,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? context.primaryColor;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: AppSizes.avatarLg + AppSpacing.lg,
                height: AppSizes.avatarLg + AppSpacing.lg,
                decoration: BoxDecoration(
                  color: color.withValues(
                    alpha: context.isDarkMode ? 0.2 : 0.1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: AppSizes.iconLg + 8, color: color),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                title,
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  message!,
                  style: context.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: AppSpacing.xl),
                FilledButton(onPressed: onAction, child: Text(actionLabel!)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorStateView extends StatelessWidget {
  const ErrorStateView({
    super.key,
    this.title = 'Something went wrong',
    this.message,
    this.onRetry,
  });

  final String title;
  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return EmptyStateView(
      icon: Icons.cloud_off_rounded,
      iconColor: context.errorColor,
      title: title,
      message: message ?? 'Check your connection and try again.',
      actionLabel: onRetry != null ? 'Retry' : null,
      onAction: onRetry,
    );
  }
}
