import 'package:ankur_portfolio/widgets/clock/analog.clock.dart';
import 'package:ankur_portfolio/widgets/clock/face.type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultEditorScreen extends StatefulWidget {
  const DefaultEditorScreen({super.key});

  @override
  State<DefaultEditorScreen> createState() => _DefaultEditorScreenState();
}

class _DefaultEditorScreenState extends State<DefaultEditorScreen> {
  @override
  Widget build(BuildContext context) {
    // no need for the screen size, as it takes that of the parent
    return Material(
      color: Color(0xFF000C18),
      // color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.green, width: 2),
              // ),
              padding: EdgeInsets.only(left: 100, top: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CurrentIST(),
                  AnalogClock(
                    faceType: FaceType.circle, // or FaceType.square
                    size: 150,
                    location: "Asia/Kolkata",
                    centerDotColor: Colors.pink,
                    hourHandColor: Colors.grey.shade50,
                    minuteHandColor: Colors.grey.shade50,
                    secondHandColor: Colors.amber,
                    hourDashColor: Colors.white70,
                    minuteDashColor: Colors.grey.shade700,
                    showMinuteDash: true,
                  ),
                  Gap(30),
                  Text(
                    "Ankur Tiwary",
                    style: GoogleFonts.roboto(
                      fontSize: 36,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 35),
                      Text(
                        "- Software Developer",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          height: 0.9,
                        ),
                      ),
                    ],
                  ),

                  Gap(40),

                  Text(
                    "Start",
                    style: GoogleFonts.workSans(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  // Skills
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/filemain2.svg',
                        height: 16,
                        width: 16,
                        colorFilter: ColorFilter.mode(
                          Color(0xFF3B82F6),
                          BlendMode.srcIn,
                        ),
                      ),
                      Gap(2),
                      Text(
                        "Skills ...",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),

                  // Projects
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/filemain2.svg',
                        height: 16,
                        width: 16,
                        colorFilter: ColorFilter.mode(
                          Color(0xFF3B82F6),
                          BlendMode.srcIn,
                        ),
                      ),
                      Gap(2),
                      Text(
                        "Projects ...",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),

                  // Anime
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/filemain2.svg',
                        height: 16,
                        width: 16,
                        colorFilter: ColorFilter.mode(
                          Color(0xFF3B82F6),
                          BlendMode.srcIn,
                        ),
                      ),
                      Gap(2),
                      Text(
                        "Recent Anime ...",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 100, top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Walkthroughs",
                    style: GoogleFonts.workSans(
                      color: Colors.grey.shade100,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      wordSpacing: -0.75,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
