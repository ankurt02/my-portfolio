import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ResearchPaperCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String conference;
  final VoidCallback? onTap;
  final List<Color> gradientColors;

  const ResearchPaperCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.conference,
    required this.gradientColors,
    this.onTap,
  });

  @override
  State<ResearchPaperCard> createState() => _ResearchPaperCardState();
}

class _ResearchPaperCardState extends State<ResearchPaperCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        transform:
            _isHovered
                ? (Matrix4.identity()
                  ..translate(0, -4, 0)
                  ..scale(1.02))
                : Matrix4.identity(),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: widget.gradientColors),
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(8),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            margin: const EdgeInsets.all(2.25), // Border thickness
            decoration: BoxDecoration(
              color: const Color(0xFF121212),
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    height: 360,
                    width: double.infinity,
                  ),
                ),
                const Gap(12),
                Text(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  widget.title,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Gap(24),

                Text(
                  widget.conference,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
