import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
    _animation = TweenSequence<int>([
      TweenSequenceItem(tween: ConstantTween(0), weight: 1),
      TweenSequenceItem(tween: ConstantTween(1), weight: 1),
      TweenSequenceItem(tween: ConstantTween(2), weight: 1),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _Indicator(index == _animation.value),
              );
            }),
          );
        },
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator(this.active);

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            active ? AppColors.accent : AppColors.accent.withValues(alpha: 0.2),
      ),
    );
  }
}
