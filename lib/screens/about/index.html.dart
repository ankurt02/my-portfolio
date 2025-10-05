import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

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
          Gap(18),
          Row(
            children: [
              const Gap(16),
              const Icon(
                FontAwesome.circle_solid,
                size: 9,
                // color: Color.fromARGB(255, 82, 246, 109),
                color: Colors.yellowAccent,
              ),
              const Gap(8),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      // Color.fromARGB(255, 20, 235, 56),
                      // Color.fromARGB(255, 6, 232, 44),
                      Colors.yellow,
                      Colors.yellowAccent
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Text(
                  // "Open to opportunities ...",
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
          Gap(32),
          Padding( // Added padding for overall alignment
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
                Gap(16),
                
                FractionallySizedBox(
                  widthFactor: 0.7, 
                  child: Text(
                    "Hey there, I'm Ankur! I just wrapped up my degree in Computer Science and I'm eager to dive into the world of professional development. My true passion is building attractive and engaging user interfaces. I'm the kind of developer who will happily spend time perfecting the details, making sure every pixel, font, and color choice contributes to a seamless user experience.",
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