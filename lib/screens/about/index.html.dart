import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

// --- MODIFIED WIDGET ---
// This version uses an AnimationController for smooth transitions.
class GlowingBlinkingDot extends StatefulWidget {
  final List<Color> colors;
  final Duration duration; // Now controls the duration of ONE color transition
  final double size;

  const GlowingBlinkingDot({
    super.key,
    this.colors = const [Color.fromARGB(255, 248, 236, 131), Color.fromARGB(255, 240, 228, 1), Color.fromARGB(255, 255, 196, 17)],
    this.duration = const Duration(milliseconds: 1200), // A slightly longer duration feels smoother
    this.size = 9.0,
  });

  @override
  State<GlowingBlinkingDot> createState() => _GlowingBlinkingDotState();
}

// Add 'SingleTickerProviderStateMixin' for the AnimationController
class _GlowingBlinkingDotState extends State<GlowingBlinkingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  int _currentColorIndex = 0;

  @override
  void initState() {
    super.initState();
    // 1. Initialize the AnimationController
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

class IndexDotHtml extends StatefulWidget {
  const IndexDotHtml({super.key});

  @override
  State<IndexDotHtml> createState() => _IndexDotHtmlState();
}

class _IndexDotHtmlState extends State<IndexDotHtml> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(32),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
              children: [
                const Gap(16),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 82,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/fil_bangalore01.png',
                        ),
                        radius: 80,
                      ),
                    ),
                    Positioned(
                      top: 85,
                      left: 100,
                      child: Transform.flip(
                        flipX: true,
                        child: Image.asset(
                          "assets/images/coffee_mug01.png",
                          height: 85,
                          width: 85,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "About Me",
                  style: GoogleFonts.robotoMono(
                    fontSize: 54,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const Gap(18),
          Row(
            children: [
              const Gap(16),
              const GlowingBlinkingDot(
                // Colors to be added here
                colors: [
                  Colors.yellowAccent,
                  Color.fromARGB(255, 224, 202, 8),
                  Colors.amber,
                ],
                size: 9,
              ),
              const Gap(8),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [Colors.yellow, Colors.yellowAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Text(
                  "Android Developer - Device Platform Engineer",
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          const Gap(32),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      FontAwesome.angle_right_solid,
                      color: Colors.grey,
                      size: 34,
                    ),
                    const Gap(4),
                    Text(
                      "Ankur Tiwary",
                      style: GoogleFonts.spaceMono(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      "_",
                      style: GoogleFonts.spaceMono(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 0.8,
                  child: Text(
                    "Hey there, I'm Ankur! I just wrapped up my degree in Computer Science and currently working as an Android Developer - Device Platform Engineer at 42Gears. My true passion is building attractive and engaging user interfaces. I'm the kind of developer who will happily spend time perfecting the details, making sure every pixel, font, and color choice contributes to a seamless user experience.",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.roboto(
                        color: Colors.grey.shade300,
                        fontSize: 16,
                        height: 1.35,
                        fontWeight: FontWeight.normal),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}