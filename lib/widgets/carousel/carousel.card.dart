import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';


class SkillData {
  final String assetPath;
  final String skillName;

  const SkillData({required this.assetPath, required this.skillName});
}

class CarouselCard extends StatelessWidget {
  final String assetPath;
  final String skillName;

  const CarouselCard({
    super.key,
    required this.assetPath,
    required this.skillName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.only(left: 30, right: 30),
      height: 50,
      width: 250,
      // decoration: BoxDecoration(
      //   color: Colors.transparent,
      //   border: Border.all(
      //     color: Colors.grey.shade300,
      //     width: 1.5,
      //   ),
      //   borderRadius: BorderRadius.circular(30)
      // ),
      
    
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetPath, 
            height: 40, 
            width: 40,
            // colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          Gap(8),
          Text(
            skillName,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
