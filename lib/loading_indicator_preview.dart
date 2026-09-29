import 'package:flutter/material.dart';
import 'package:loading_indicators/app_theme.dart';
import 'package:loading_indicators/loading_indicators.dart';

class LoadingIndicatorPreview extends StatelessWidget {
  const LoadingIndicatorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loading Indicators')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _section(
            context,
            title: 'Circular',
            child: Column(
              children: [
                _previewItem(
                  'Tiny',
                  const CustomLoadingIndicator(
                    type: LoadingType.circular,
                    size: LoadingSize.tiny,
                  ),
                ),
                _previewItem(
                  'Small',
                  const CustomLoadingIndicator(
                    type: LoadingType.circular,
                    size: LoadingSize.small,
                  ),
                ),
                _previewItem(
                  'Medium',
                  const CustomLoadingIndicator(
                    type: LoadingType.circular,
                    size: LoadingSize.medium,
                  ),
                ),
                _previewItem(
                  'Large',
                  const CustomLoadingIndicator(
                    type: LoadingType.circular,
                    size: LoadingSize.large,
                  ),
                ),
                _previewItem(
                  'Extra Large',
                  const CustomLoadingIndicator(
                    type: LoadingType.circular,
                    size: LoadingSize.extraLarge,
                  ),
                ),
              ],
            ),
          ),

          _section(
            context,
            title: 'Circular - Determinate',
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomLoadingIndicator(
                  type: LoadingType.circular,
                  size: LoadingSize.medium,
                  value: 0.25,
                ),
                CustomLoadingIndicator(
                  type: LoadingType.circular,
                  size: LoadingSize.medium,
                  value: 0.50,
                ),
                CustomLoadingIndicator(
                  type: LoadingType.circular,
                  size: LoadingSize.medium,
                  value: 0.75,
                ),
                CustomLoadingIndicator(
                  type: LoadingType.circular,
                  size: LoadingSize.medium,
                  value: 1.0,
                ),
              ],
            ),
          ),

          _section(
            context,
            title: 'Linear',
            child: Column(
              children: [
                _previewItem(
                  'Indeterminate',
                  const CustomLoadingIndicator(
                    type: LoadingType.linear,
                    size: LoadingSize.small,
                  ),
                ),
                _previewItem(
                  '25%',
                  const CustomLoadingIndicator(
                    type: LoadingType.linear,
                    size: LoadingSize.small,
                    value: 0.25,
                  ),
                ),
                _previewItem(
                  '50%',
                  const CustomLoadingIndicator(
                    type: LoadingType.linear,
                    size: LoadingSize.small,
                    value: 0.50,
                  ),
                ),
                _previewItem(
                  '75%',
                  const CustomLoadingIndicator(
                    type: LoadingType.linear,
                    size: LoadingSize.small,
                    value: 0.75,
                  ),
                ),
              ],
            ),
          ),

          _section(
            context,
            title: 'Shimmer',
            child: Column(
              children: [
                _previewItem(
                  'Small',
                  const CustomLoadingIndicator(
                    type: LoadingType.shimmer,
                    size: LoadingSize.small,
                  ),
                ),
                _previewItem(
                  'Medium',
                  const CustomLoadingIndicator(
                    type: LoadingType.shimmer,
                    size: LoadingSize.medium,
                  ),
                ),
                _previewItem(
                  'Large',
                  const CustomLoadingIndicator(
                    type: LoadingType.shimmer,
                    size: LoadingSize.large,
                  ),
                ),
              ],
            ),
          ),

          _section(
            context,
            title: 'Bouncing Dots',
            child: Column(
              children: [
                _previewItem(
                  'Small',
                  const CustomLoadingIndicator(
                    type: LoadingType.bouncingDots,
                    size: LoadingSize.small,
                  ),
                ),
                _previewItem(
                  'Medium',
                  const CustomLoadingIndicator(
                    type: LoadingType.bouncingDots,
                    size: LoadingSize.medium,
                  ),
                ),
                _previewItem(
                  'Large',
                  const CustomLoadingIndicator(
                    type: LoadingType.bouncingDots,
                    size: LoadingSize.large,
                  ),
                ),
              ],
            ),
          ),

          _section(
            context,
            title: 'Spinning Circle',
            child: Column(
              children: [
                _previewItem(
                  'Small',
                  const CustomLoadingIndicator(
                    type: LoadingType.spinningCircle,
                    size: LoadingSize.small,
                  ),
                ),
                _previewItem(
                  'Medium',
                  const CustomLoadingIndicator(
                    type: LoadingType.spinningCircle,
                    size: LoadingSize.medium,
                  ),
                ),
                _previewItem(
                  'Large',
                  const CustomLoadingIndicator(
                    type: LoadingType.spinningCircle,
                    size: LoadingSize.large,
                  ),
                ),
              ],
            ),
          ),

          _section(
            context,
            title: 'Wave',
            child: Column(
              children: [
                _previewItem(
                  'Small',
                  const CustomLoadingIndicator(
                    type: LoadingType.wave,
                    size: LoadingSize.small,
                  ),
                ),
                _previewItem(
                  'Medium',
                  const CustomLoadingIndicator(
                    type: LoadingType.wave,
                    size: LoadingSize.medium,
                  ),
                ),
                _previewItem(
                  'Large',
                  const CustomLoadingIndicator(
                    type: LoadingType.wave,
                    size: LoadingSize.large,
                  ),
                ),
              ],
            ),
          ),

          _section(
            context,
            title: 'With Text',
            child: Column(
              children: const [
                CustomLoadingIndicator(
                  type: LoadingType.circular,
                  size: LoadingSize.medium,
                  text: 'Loading...',
                ),
                SizedBox(height: 30),
                CustomLoadingIndicator(
                  type: LoadingType.bouncingDots,
                  size: LoadingSize.medium,
                  text: 'Please wait',
                ),
                SizedBox(height: 30),
                CustomLoadingIndicator(
                  type: LoadingType.wave,
                  size: LoadingSize.medium,
                  text: 'Processing...',
                ),
              ],
            ),
          ),

          _section(
            context,
            title: 'All Types',
            child: const Wrap(
              alignment: WrapAlignment.center,
              spacing: 40,
              runSpacing: 35,
              children: [
                _TypePreview(title: 'Circular', type: LoadingType.circular),
                _TypePreview(title: 'Linear', type: LoadingType.linear),
                _TypePreview(title: 'Shimmer', type: LoadingType.shimmer),
                _TypePreview(title: 'Bouncing', type: LoadingType.bouncingDots),
                _TypePreview(
                  title: 'Spinning',
                  type: LoadingType.spinningCircle,
                ),
                _TypePreview(title: 'Wave', type: LoadingType.wave),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  static Widget _section(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  static Widget _previewItem(String title, Widget indicator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(title)),
          Expanded(child: Center(child: indicator)),
        ],
      ),
    );
  }
}

class _TypePreview extends StatelessWidget {
  const _TypePreview({required this.title, required this.type});

  final String title;
  final LoadingType type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          SizedBox(
            height: 55,
            child: Center(
              child: CustomLoadingIndicator(
                type: type,
                size: LoadingSize.medium,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
