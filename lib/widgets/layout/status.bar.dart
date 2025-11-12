import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({super.key});

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF007ACC)),
      height: 24,
      width: screenWidth,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Gap(8),
          Row(
            children: [
              Gap(12),
              SvgPicture.asset(
                "assets/svg/branch01.svg",
                height: 16,
                width: 10,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),

              Gap(6),

              Text(
                "main*",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 0,
                ),
              ),

              Gap(16),

              SvgPicture.asset(
                "assets/svg/error01.svg",
                height: 16,
                width: 16,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              Gap(2),

              Text(
                "0",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 0,
                ),
              ),
              Gap(6),

              SvgPicture.asset(
                "assets/svg/warnings01.svg",
                height: 16,
                width: 16,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),

              Gap(2),

              Text(
                "0",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 0,
                ),
              ),

              Gap(6),

              SvgPicture.asset(
                "assets/svg/warning02.svg",
                height: 16,
                width: 16,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),

              Gap(2),

              Text(
                "0",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Text(
                "v1.2.5-release",
                style: GoogleFonts.robotoMono(
                  fontSize: 12,
                  color: Colors.grey.shade300,
                  letterSpacing: 0,
                ),
              ),

              Gap(30),

              Text(
                "host : github-pages / firebase",
                style: GoogleFonts.robotoMono(
                  fontSize: 12,
                  color: Colors.grey.shade300,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
          // Gap(16),

          // Spacer(),

          // Gap(8),
          Row(
            children: [
              Text(
                "Spaces : 2",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 0,
                ),
              ),

              Gap(20),
              Text(
                "UTF-8",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 0,
                ),
              ),

              Gap(20),
              Text(
                "CRLF",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 0,
                ),
              ),

              Gap(20),

              SvgPicture.asset(
                "assets/svg/curlybraces.svg",
                height: 16,
                width: 16,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),

              Gap(2),

              Text(
                "Dart",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 0,
                ),
              ),
              Gap(12),
            ],
          ),

          //   Text(
          //   "Made with Flutter",
          //   // 💛
          //   textAlign: TextAlign.start,
          //   style: TextStyle(
          //     fontSize: 13,
          //     color: Colors.grey.shade300,
          //     decoration: TextDecoration.none,
          //     fontWeight: FontWeight.w100,
          //   ),
          // ),
        ],
      ),
    );
  }
}
