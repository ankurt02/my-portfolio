import 'package:ankur_portfolio/screens/about/index.html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AndroidDev42Gears extends StatefulWidget {
  const AndroidDev42Gears({super.key});

  @override
  State<AndroidDev42Gears> createState() => _AndroidDev42GearsState();
}

class _AndroidDev42GearsState extends State<AndroidDev42Gears> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 24),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.yellow,
      //     width: 2
      //   )
      // ),

      child: 
      /// below one is for trial - testing
      // Center(
      //   child: Text(
      //     "Working on it!",
      //     style: TextStyle(
      //       color: Colors.grey,
      //       fontSize: 14,
      //       fontWeight: FontWeight.bold
      //     ),
      //   ),
      // )

      Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24),
            // height: 120,
            width: 320,
            decoration: BoxDecoration(
              // color: Colors.white,
              // border: Border.all(
              //   color: Colors.pink,
              //   width: 2
              // )
            ),
            child: SvgPicture.asset(
              "assets/svg/42gearslogo.svg",
              colorFilter: ColorFilter.mode(const Color(0xFF006CB3), BlendMode.srcIn),
            ),
          ),

          Gap(48),

          Row(
            children: [
              Text(
                "Role: ",
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 20,
                  // fontWeight: FontWeight.bold
                ),
              ),
              Gap(12),
              Text(
                "Android - Device Platform Engineer",
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                ),
              )
            ],
          ),
          Gap(12),

          Row(
            children: [
              Text(
                "Duration: ",
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 20,
                  // fontWeight: FontWeight.bold
                ),
              ),
              Gap(12),
              Text(
                "Oct 2025 - Present",
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic
                ),
              ),

              Gap(12),

              GlowingBlinkingDot(
                // Colors to be added here
                colors: [
                  const Color.fromARGB(255, 167, 255, 109),
                  const Color.fromARGB(255, 48, 255, 7),
                  const Color.fromARGB(255, 35, 202, 2),
                  Color.fromARGB(255, 0, 148, 57),
                ],
                size: 9,
              )
            ],
          ),

          Gap(12),

          Row(
            children: [
              Text(
                "Tech-stack: ",
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 20,
                  // fontWeight: FontWeight.bold
                ),
              ),
              Gap(12),
              Text(
                "Java, Android",
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic
                ),
              )
            ],
          ),

          // Gap(36),

          // FractionallySizedBox(
          //       alignment: Alignment.center,
          //       widthFactor: 1,
          //       child: Text(
          //         "As an Android Device Platform Engineer at 42Gears, I build and enhance core components of the Android OS to create robust, secure, and scalable enterprise mobility solutions.",
          //         textAlign: TextAlign.justify,
          //         style: GoogleFonts.roboto(
          //             color: Colors.grey.shade300,
          //             fontSize: 16,
          //             height: 1.35,
          //             fontWeight: FontWeight.normal),
          //       ),
          //     )


        ],
      ),
    );
  }
}