import 'package:flutter/material.dart';
import 'package:loading_indicators/app_config.dart';
import 'package:loading_indicators/app_theme.dart';
import 'package:loading_indicators/skeleton_shimmer.dart';

class StateViewPreview extends StatefulWidget {
  const StateViewPreview({super.key});

  @override
  State<StateViewPreview> createState() => _StateViewPreviewState();
}

class _StateViewPreviewState extends State<StateViewPreview> {
  ViewState _state = ViewState.loading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('State View Preview')),
      body: Column(
        children: [
          // State selector
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                _stateButton(
                  label: 'Loading',
                  icon: Icons.refresh_rounded,
                  state: ViewState.loading,
                ),
                _stateButton(
                  label: 'Empty',
                  icon: Icons.inbox_outlined,
                  state: ViewState.empty,
                ),
                _stateButton(
                  label: 'Error',
                  icon: Icons.error_outline_rounded,
                  state: ViewState.error,
                ),
                _stateButton(
                  label: 'Content',
                  icon: Icons.check_circle_outline_rounded,
                  state: ViewState.content,
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Current state preview
          Expanded(
            child: StateView(
              state: _state,
              skeletonType: SkeletonType.list,
              errorMessage: 'Unable to load. Please try again.',
              onRetry: () {
                setState(() {
                  _state = ViewState.loading;
                });

                Future.delayed(const Duration(seconds: 1), () {
                  if (!mounted) return;

                  setState(() {
                    _state = ViewState.content;
                  });
                });
              },
              builder: (context) {
                return _contentPreview();
              },
            ),
          ),

          // Skeleton previews
          const Divider(height: 1),

          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text('Skeleton Types', style: context.textTheme.titleMedium),
          ),

          SizedBox(
            height: 180,
            child: Row(
              children: [
                Expanded(
                  child: _skeletonPreview(
                    title: 'List',
                    type: SkeletonType.list,
                  ),
                ),
                Expanded(
                  child: _skeletonPreview(
                    title: 'Contents',
                    type: SkeletonType.content,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  Widget _stateButton({
    required String label,
    required IconData icon,
    required ViewState state,
  }) {
    final selected = _state == state;

    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: ChoiceChip(
        selected: selected,
        avatar: Icon(icon, size: 18),
        label: Text(label),
        onSelected: (_) {
          setState(() {
            _state = state;
          });
        },
      ),
    );
  }

  Widget _contentPreview() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Content State', style: context.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'This is the normal content state displayed by StateView.',
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.xl),
        Card(
          child: ListTile(
            leading: CircleAvatar(child: const Icon(Icons.person)),
            title: const Text('John Doe'),
            subtitle: const Text('This is example content.'),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(child: const Icon(Icons.chat)),
            title: const Text('Another conversation'),
            subtitle: const Text('Content loaded successfully.'),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
        ),
      ],
    );
  }

  Widget _skeletonPreview({required String title, required SkeletonType type}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        border: Border.all(color: context.dividerColor),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Text(title, style: context.textTheme.labelLarge),
          ),
          const Divider(height: 1),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: SkeletonList(type: type, itemCount: 3),
            ),
          ),
        ],
      ),
    );
  }
}
