import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HackerTextEffect extends StatefulWidget {
  final String text;

  /// Optional parameters for customization
  final double? fontSize;
  final Color? textColor;

  const HackerTextEffect({
    super.key,
    required this.text,
    this.fontSize,
    this.textColor,
  });

  @override
  State<HackerTextEffect> createState() => _HackerTextEffectState();
}

class _HackerTextEffectState extends State<HackerTextEffect> {
  final _random = Random();
  final String _chars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz!@#\$%^&*()_+-=[]{}|;':\",./<>?";
  String _currentText = "";
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _currentText = widget.text;

    // Start the animation once the widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateText();
    });
  }

  /// Scramble animation logic
  void _animateText() async {
    if (_isAnimating) return;
    setState(() {
      _isAnimating = true;
    });

    for (int i = 0; i <= widget.text.length; i++) {
      for (int j = 0; j < 2; j++) {
        String scrambledPart = '';
        for (int k = i; k < widget.text.length; k++) {
          if (widget.text[k] == ' ') {
            scrambledPart += ' ';
          } else {
            scrambledPart += _chars[_random.nextInt(_chars.length)];
          }
        }

        if (!mounted) return;
        setState(() {
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
          fontSize: widget.fontSize ?? 60, // Use passed fontSize or default
          fontWeight: FontWeight.w500,
          color: widget.textColor ?? Colors.white, // Use passed color or default
          letterSpacing: -2,
        ),
      ),
    );
  }
}
