import 'dart:math' as math;
import 'package:flutter/material.dart';

class GradientBorderButton extends StatefulWidget {
  final String title;
  final Widget icon; 
  final VoidCallback onTap;

  const GradientBorderButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  State<GradientBorderButton> createState() => _GradientBorderButtonState();
}

class _GradientBorderButtonState extends State<GradientBorderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(PointerEvent details) {
    setState(() {
      _isHovered = true;
    });
    _controller.repeat();
  }

  void _onExit(PointerEvent details) {
    setState(() {
      _isHovered = false;
    });
    _controller.stop();
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: GradientBorderPainter(
                animationValue: _controller.value,
                isHovered: _isHovered,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.icon,
                    const SizedBox(width: 8),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final double animationValue;
  final bool isHovered;

  GradientBorderPainter({
    required this.animationValue,
    required this.isHovered,
  });

  final List<Color> _colors = const [
    Color(0xFF4285F4),
    Color(0xFFDB4437), 
    Color(0xFFF4B400), 
    Color(0xFF0F9D58), 
    Color(0xFF4285F4),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(50));

    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5.0
          ..isAntiAlias = true;

    if (isHovered) {
      final shader = SweepGradient(
        colors: _colors,
        stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
        transform: GradientRotation(animationValue * 2 * math.pi),
      ).createShader(rect);

      paint.shader = shader;
    } else {
      paint.color = Colors.grey.shade300;
    }

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant GradientBorderPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.isHovered != isHovered;
  }
}
