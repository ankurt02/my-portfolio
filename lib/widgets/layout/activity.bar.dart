import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ActivityBar extends StatefulWidget {
  const ActivityBar({super.key});

  @override
  State<ActivityBar> createState() => _ActivityBarState();
}

class _ActivityBarState extends State<ActivityBar> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF333333)),
      // height: screenHeight - 58 ,
      width: screenWidth * (60 / 1920),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          left: 8,
          right: 8,
          bottom: 12
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Bootstrap.file_earmark,
              weight: 1,
              fill: 1,
              color: Colors.grey.shade400,
              size: 24,
            ),

            const Spacer(), 

            Icon(
              Bootstrap.person_circle,
              weight: 1.5,
              color: Colors.grey.shade400,
              size: 24,

            )
          ],
        ),
      ),
    );
  }
}
