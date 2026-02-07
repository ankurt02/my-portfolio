import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AndroidDev42Gears extends StatefulWidget {
  const AndroidDev42Gears({super.key});

  @override
  State<AndroidDev42Gears> createState() => _AndroidDev42GearsState();
}

class _AndroidDev42GearsState extends State<AndroidDev42Gears> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 24),

      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.yellow,
      //     width: 2
      //   )
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24),
            // width: 320,
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   border: Border.all(
            //     color: Colors.pink,
            //     width: 2
            //   )
            // ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// LEFT: 42Gears Logo
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  width: 320,
                  child: SvgPicture.asset(
                    "assets/svg/42gearslogo.svg",
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF006CB3),
                      BlendMode.srcIn,
                    ),
                  ),
                ),

                const Spacer(),

                /// RIGHT: Lottie Animation
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  width: 160, // smaller than logo
                  height: 160,
                  child: Lottie.asset(
                    "assets/lottie/Android_logo.json",
                    repeat: true,
                    animate: true,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),

          const Gap(48),

          Row(
            children: [
              Text(
                "Role: ",
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Gap(12),
              Text(
                "Android - Device Platform Engineer",
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const Gap(8),

          Row(
            children: [
              Text(
                "Duration: ",
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Gap(12),
              Text(
                "Oct 2025 - Feb 2026",
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),

              // Gap(12),

              // GlowingBlinkingDot(
              //   colors: [
              //     Color.fromARGB(255, 167, 255, 109),
              //     Color.fromARGB(255, 48, 255, 7),
              //     Color.fromARGB(255, 35, 202, 2),
              //     Color.fromARGB(255, 0, 148, 57),
              //   ],
              //   size: 9,
              // )
            ],
          ),

          const Gap(8),

          Row(
            children: [
              Text(
                "Tech-stack: ",
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Gap(12),
              Text(
                "Java, Kotlin, Flutter, Android",
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const Gap(32),

          // Experience Description Section
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _experienceBullet(
                  "Worked as an Android Device Platform Engineer at 42Gears Mobility System, building native Android services and platform-level features for enterprise device management.",
                ),
                const Gap(12),
                _experienceBullet(
                  "Focused on Flutter–Android interoperability, automated device provisioning, and resolving production issues in large-scale deployments.",
                ),
              ],
            ),
          ),

          // Gap(36),

          // FractionallySizedBox(
          //   alignment: Alignment.center,
          //   widthFactor: 1,
          //   child: Text(
          //     "As an Android Device Platform Engineer at 42Gears, I build and enhance core components of the Android OS to create robust, secure, and scalable enterprise mobility solutions.",
          //     textAlign: TextAlign.justify,
          //     style: GoogleFonts.roboto(
          //       color: Colors.grey.shade300,
          //       fontSize: 16,
          //       height: 1.35,
          //       fontWeight: FontWeight.normal,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  /// Bullet point widget for experience description
  Widget _experienceBullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "•",
          style: GoogleFonts.robotoMono(
            color: Colors.grey.shade300,
            fontSize: 18,
            height: 1.4,
          ),
        ),
        const Gap(8),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.justify,
            style: GoogleFonts.robotoFlex(
              color: Colors.grey.shade300,
              fontSize: 15.5,
              height: 1.4,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
