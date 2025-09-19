import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class TaskBar extends StatefulWidget {
  const TaskBar({super.key});

  @override
  State<TaskBar> createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 32,
      width: screenWidth,
      decoration: BoxDecoration(
        color: const Color(0xFF252526)
      ),


      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SvgPicture.asset(
                "assets/svg/vscode.svg",
                height: 22,
                width: 22,
              ),
          ),
          Spacer(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 200),
            decoration: BoxDecoration(
              color: Color(0xFF464646),
              border: Border.all(
                color: Color(0XFF5a5a5a),
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Transform.flip(
                  flipX: true,
                  child: Icon(
                  FontAwesome.magnifying_glass_solid,
                  color: Colors.grey.shade400,
                  weight: 0.75,
                  fontWeight: FontWeight.w100,
                  size: 14,
                  ),
                ),
              Gap(12),
                Text(
                  "ankur_tiwary",
                  style: GoogleFonts.roboto(
                    color: Colors.grey.shade300,
                    fontSize: 13,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),

          Spacer()         
        ],
      ),
    );
  }
}