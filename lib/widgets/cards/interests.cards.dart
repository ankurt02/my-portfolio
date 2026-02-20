import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback? onTap;
  final List<Color> gradientColors;

  const InfoCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.gradientColors,
    this.onTap,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: _isHovered
            ? (Matrix4.identity()
              ..translate(0, -8, 0)
              ..scale(1.025)) // CONTROLS THE RATIO OF SCALE ON-HOVER
            : Matrix4.identity(),
        margin: const EdgeInsets.all(8),
        child: Stack(
          children: [
            // Gradient border layer with animated opacity
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              opacity: _isHovered ? 1.0 : 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.gradientColors,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            
            // Content container with margin for border
            Container(
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.yellow
              //   )
              // ),
              // height: 320,
              margin: const EdgeInsets.all(1.75),
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212),
                    borderRadius: BorderRadius.circular(14),
                    // border: Border.all(
                    //   color: Colors.pink
                    // )
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(8)),
                        child: Image.asset(
                          widget.imagePath,
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                      const Gap(12),
                      Text(
                        widget.title,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        widget.description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}