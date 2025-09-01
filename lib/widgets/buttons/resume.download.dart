import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ResumeDownloadButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const ResumeDownloadButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<ResumeDownloadButton> createState() => _ResumeDownloadButtonState();
}

class _ResumeDownloadButtonState extends State<ResumeDownloadButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Transform(
          transform: Matrix4.identity()..setEntry(3, 2, 0.001),
          alignment: FractionalOffset.center,
          child: AnimatedContainer(
            margin: EdgeInsets.only(right: 20),
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.only(left: 28, right: 28, top: 12, bottom: 12),
            transform: _isHovered
                ? (Matrix4.identity()
                  ..translate(0, 0, -20.0) // Pop out
                  ..scale(1.1, 1.1)) // Scale up
                : Matrix4.identity(),
            decoration: BoxDecoration(
              color: Color(0xFF252526),
              border: Border.all(
                color: Color(0xFF252526),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        // color: Colors.black.withOpacity(0.6),
                        blurRadius: 0,
                        offset: const Offset(0, 0),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.download, color: Color(0xFFEEEEEE), size: 16),
                const Gap(10),
                Text(
                  widget.text,
                  style: GoogleFonts.robotoMono(
                    fontSize: 14,
                    color: const Color(0xFFEEEEEE),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

