import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HackerTextEffect extends StatefulWidget {
  final String text;

  const HackerTextEffect({
    super.key,
    required this.text,
  });

  @override
  State<HackerTextEffect> createState() => _HackerTextEffectState();
}

class _HackerTextEffectState extends State<HackerTextEffect> {
  final _random = Random();
  final String _chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz!@#\$%^&*()_+-=[]{}|;':\",./<>?";
  String _currentText = "";
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _currentText = widget.text;

    // Animate the text for the first time when the widget is built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateText();
    });
  }

  /// Starts the scrambling animation.
  void _animateText() async {
    if (_isAnimating) return;
    setState(() {
      _isAnimating = true;
    });

    // The animation iterates through the string, "decoding" one letter at a time.
    for (int i = 0; i <= widget.text.length; i++) {

      // This inner loop creates the rapid scrambling effect for the remaining letters.
      for (int j = 0; j < 2; j++) { // Run the scramble effect a few times for each letter
        String scrambledPart = '';
        for (int k = i; k < widget.text.length; k++) {
          // Keep spaces as they are for better readability
          if (widget.text[k] == ' ') {
            scrambledPart += ' ';
          } else {
            scrambledPart += _chars[_random.nextInt(_chars.length)];
          }
        }
        
        if (!mounted) return;
        setState(() {
          // Combine the "decoded" part with the scrambled part
          _currentText = widget.text.substring(0, i) + scrambledPart;
        });
        await Future.delayed(const Duration(milliseconds: 10));
      }
    }
    
    if (!mounted) return;
    setState(() {
      _currentText = widget.text; 
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _animateText(),
      cursor: SystemMouseCursors.click,
      child: Text(
        _currentText,
        textAlign: TextAlign.center,
        style: GoogleFonts.ibmPlexMono(
          fontSize: 60,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          letterSpacing: -2,
        ),
      ),
    );
  }
}

enum HighlightType { marker, underline }

class HighlightInfo {
  final String text;
  final Color color;
  final HighlightType type;

  HighlightInfo({required this.text, required this.color, required this.type});
}

class MagicHighlighter extends StatelessWidget {
  final String fullText;
  final List<HighlightInfo> highlights;
  final TextStyle textStyle;

  const MagicHighlighter({
    super.key,
    required this.fullText,
    required this.highlights,
    this.textStyle = const TextStyle(
      fontSize: 28,
      color: Colors.black87,
      fontWeight: FontWeight.w500,
    ),
  });
  
  List<TextSpan> _buildTextSpans() {
    final List<TextSpan> spans = [];
    int start = 0;

    final Map<String, HighlightInfo> highlightMap = {
      for (var h in highlights) h.text: h
    };
    
    final String pattern = highlights.map((h) => RegExp.escape(h.text)).join('|');
    final RegExp regex = RegExp(pattern);

    regex.allMatches(fullText).forEach((match) {
      if (match.start > start) {
        spans.add(TextSpan(text: fullText.substring(start, match.start)));
      }
      final String matchedText = match.group(0)!;
      final HighlightInfo info = highlightMap[matchedText]!;
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: HighlightedText(
            text: matchedText,
            style: textStyle,
            highlightColor: info.color,
            highlightType: info.type,
          ),
        ) as TextSpan
      );
      start = match.end;
    });

    if (start < fullText.length) {
      spans.add(TextSpan(text: fullText.substring(start)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textStyle,
        children: _buildTextSpans(),
      ),
    );
  }
}

class HighlightedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color highlightColor;
  final HighlightType highlightType;

  const HighlightedText({
    super.key,
    required this.text,
    required this.style,
    required this.highlightColor,
    required this.highlightType,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              painter: HighlightPainter(
                type: highlightType,
                color: highlightColor,
              ),
              child: SizedBox(width: constraints.maxWidth, height: constraints.maxHeight),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Text(text, style: style),
        ),
      ],
    );
  }
}

class HighlightPainter extends CustomPainter {
  final HighlightType type;
  final Color color;
  final Random _random = Random();

  HighlightPainter({required this.type, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = type == HighlightType.marker ? PaintingStyle.fill : PaintingStyle.stroke;

    if (type == HighlightType.underline) {
      paint.strokeWidth = 2.5;
      paint.strokeCap = StrokeCap.round;
      _drawWigglyLine(canvas, size, paint);
    } else {
      _drawMarkerHighlight(canvas, size, paint);
    }
  }

  void _drawWigglyLine(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    path.moveTo(size.width * 0.05, size.height * 0.85 + _random.nextDouble() * 4 - 2);
    path.quadraticBezierTo(
      size.width * 0.4, size.height * 0.85 + _random.nextDouble() * 6 - 3,
      size.width * 0.95, size.height * 0.85 + _random.nextDouble() * 4 - 2,
    );
    canvas.drawPath(path, paint);
  }

  void _drawMarkerHighlight(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final topLeft = Offset(-size.width * 0.05, -size.height * 0.1);
    final topRight = Offset(size.width * 1.05, -size.height * 0.15);
    final bottomRight = Offset(size.width * 1.03, size.height * 0.95);
    final bottomLeft = Offset(-size.width * 0.03, size.height * 0.9);

    path.moveTo(topLeft.dx, topLeft.dy + _random.nextDouble() * 4);
    path.quadraticBezierTo(
      (topLeft.dx + topRight.dx) / 2 + _random.nextDouble() * 10 - 5, (topLeft.dy + topRight.dy) / 2 + _random.nextDouble() * 6 - 3,
      topRight.dx, topRight.dy + _random.nextDouble() * 4 - 2,
    );
     path.quadraticBezierTo(
      (topRight.dx + bottomRight.dx) / 2 + _random.nextDouble() * 6 - 3, (topRight.dy + bottomRight.dy) / 2,
      bottomRight.dx, bottomRight.dy + _random.nextDouble() * 4 - 2,
    );
     path.quadraticBezierTo(
      (bottomRight.dx + bottomLeft.dx) / 2 + _random.nextDouble() * 10 - 5, (bottomRight.dy + bottomLeft.dy) / 2 + _random.nextDouble() * 6 - 3,
      bottomLeft.dx, bottomLeft.dy + _random.nextDouble() * 4 - 2,
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}