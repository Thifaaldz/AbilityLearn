import 'package:flutter/material.dart';

class GhostHinter extends StatefulWidget {
  final Widget child;
  final Alignment startAlignment;
  final Alignment endAlignment;
  final bool active;
  final Duration duration;

  const GhostHinter({
    super.key,
    required this.child,
    required this.startAlignment,
    required this.endAlignment,
    this.active = false,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<GhostHinter> createState() => _GhostHinterState();
}

class _GhostHinterState extends State<GhostHinter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _updateAnimations();
  }

  @override
  void didUpdateWidget(covariant GhostHinter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startAlignment != oldWidget.startAlignment ||
        widget.endAlignment != oldWidget.endAlignment) {
      _updateAnimations();
    }

    if (widget.active != oldWidget.active) {
      if (widget.active) {
        _controller.repeat();
      } else {
        _controller.stop();
        _controller.reset();
      }
    }
  }

  void _updateAnimations() {
    _alignmentAnimation = AlignmentTween(
      begin: widget.startAlignment,
      end: widget.endAlignment,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.8), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 0.8), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 0.0), weight: 20),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Align(
          alignment: _alignmentAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: widget.child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
