import 'package:ankur_portfolio/widgets/blink/blinking.dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.pink,
        //   width: 2
        // ),
      color: Colors.transparent,
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(32),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
              children: [
                Gap(16),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 82,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://resume-hosting-f1c9d.web.app/fil.png',
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
                Spacer(),
                Text(
                  "About Me",
                  style: GoogleFonts.robotoMono(
                    fontSize: 54,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Gap(18),
          Row(
            children: [
              // Gap(16),
              // GlowingBlinkingDot(
              //   // Colors to be added here
              //   colors: [
              //     Colors.yellowAccent,
              //     Color.fromARGB(255, 224, 202, 8),
              //     Colors.amber,
              //   ],
              //   size: 9,
              // ),
              Gap(8),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      Colors.green, 
                      Colors.lightGreen, 
                      Colors.blue, 
                      Colors.blueAccent
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Text(
                  // "Android Developer - Device Platform Engineer",
                  "Android Developer | Flutter",
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
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesome.angle_right_solid,
                      color: Colors.grey,
                      size: 34,
                    ),
                    Gap(4),
                    Text(
                      "Ankur Tiwary",
                      style: GoogleFonts.spaceMono(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                      ),
                    ),
                    Gap(6),
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
                  alignment: Alignment.center,
                  widthFactor: 0.85,
                  child: Text(
                    "Hi there,\n",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.spaceMono(
                        color: Colors.grey.shade200,
                        fontSize: 24,
                        height: 1.35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 0.85,
                  child: Text(
                    "I’m a Computer Science graduate and an Android & Flutter developer with hands-on experience building scalable mobile and device-level solutions. I’ve worked on bridging native Android services with Flutter, automating device workflows, and solving real production issues in enterprise environments.\n\nBeyond mobile development, I enjoy working at the intersection of UI engineering and machine learning, having built end-to-end ML-powered applications using Python, Flutter, and modern ML techniques. I care deeply about clean architecture, thoughtful UI design, and building products that feel solid, fast, and intuitive to use.\n\nI’m currently exploring opportunities where I can grow as a mobile or platform engineer while continuing to build impactful, user-focused products.",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.robotoFlex(
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