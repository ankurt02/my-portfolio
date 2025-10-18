import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; 

class LinkedinButton extends StatefulWidget {
  final String text;
  final String url;

  const LinkedinButton({
    Key? key,
    required this.text,
    required this.url,
  }) : super(key: key);

  @override
  State<LinkedinButton> createState() => _GithubButtonState();
}

class _GithubButtonState extends State<LinkedinButton> {
  bool _isHovered = false;

  // Function to launch the URL
  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(widget.url);
    if (!await launchUrl(uri)) {
      // Could not launch the URL
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch ${widget.url}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: _launchURL,
        borderRadius: BorderRadius.circular(16),
        child: Transform(
          // 1. This parent Transform adds the 3D perspective.
          transform: Matrix4.identity()..setEntry(3, 2, 0.001),
          alignment: FractionalOffset.center,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.only(left: 28, right: 28, top: 12, bottom: 12),
            
            // 2. On hover, we now scale up and translate on the Z-axis (towards the user).
            // A negative Z value moves the object closer to the viewer.
            transform: _isHovered
                ? (Matrix4.identity()
                  ..translate(0, 0, -16.0) // Pop out by 20
                  ..scale(1.1, 1.1)) // Scale up by 10%
                : Matrix4.identity(), // Return to normal state
            
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: GoogleFonts.robotoMono(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(8),
                SvgPicture.asset(
                  'assets/svg/linkout01.svg',
                  height: 24,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}