import 'dart:ui';

import 'package:flutter/material.dart';

class GlowingBlinkingDot extends StatefulWidget {
  final List<Color> colors;
  final Duration duration;
  final double size;

  const GlowingBlinkingDot({
    super.key,
    this.colors = const [Color.fromARGB(255, 248, 236, 131), Color.fromARGB(255, 240, 228, 1), Color.fromARGB(255, 255, 196, 17)],
    this.duration = const Duration(milliseconds: 1200), 
    this.size = 9.0,
  });

  @override
  State<GlowingBlinkingDot> createState() => _GlowingBlinkingDotState();
}

class _GlowingBlinkingDotState extends State<GlowingBlinkingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  int _currentColorIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _setupAnimation();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentColorIndex = (_currentColorIndex + 1) % widget.colors.length;
          _setupAnimation(); 
        });
        _controller.forward(from: 0.0);
      }
    });

    _controller.forward();
  }

  void _setupAnimation() {
    final beginColor = widget.colors[_currentColorIndex];
    final endColor = widget.colors[(_currentColorIndex + 1) % widget.colors.length];

    _colorAnimation = ColorTween(
      begin: beginColor,
      end: endColor,
    ).animate(_controller);
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        final currentColor = _colorAnimation.value;
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: currentColor, 
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: (currentColor ?? Colors.transparent).withOpacity(0.75),
                blurRadius: widget.size,
                spreadRadius: widget.size * 0.1,
              ),
            ],
          ),
        );
      },
    );
  }
}