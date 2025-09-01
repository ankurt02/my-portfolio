import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      height: 24,
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
                height: 18,
                width: 18,
              ),
          ),

          
        ],
      ),
    );
  }
}