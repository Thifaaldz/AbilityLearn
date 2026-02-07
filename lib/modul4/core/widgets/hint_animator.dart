import 'package:flutter/material.dart';

class HintAnimator extends StatefulWidget {
  final Widget child;
  final bool active;

  const HintAnimator({
    super.key,
    required this.child,
    this.active = false,
  });

  @override
  State<HintAnimator> createState() => _HintAnimatorState();
}

class _HintAnimatorState extends State<HintAnimator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.active) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant HintAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active != oldWidget.active) {
      if (widget.active) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.reset();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: widget.active
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Generic radius, might clip
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow.withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 5,
                      )
                    ],
                  )
                : null,
            child: widget.child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
