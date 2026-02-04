import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ActivityBar extends StatefulWidget {
  final VoidCallback onToggle;
  final VoidCallback onHomeTap; // 1. Add this callback
  final bool isOpen;

  const ActivityBar({
    super.key,
    required this.onToggle,
    required this.onHomeTap, // 2. Require it in constructor
    required this.isOpen,
  });

  @override
  State<ActivityBar> createState() => _ActivityBarState();
}

class _ActivityBarState extends State<ActivityBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF333333)),
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
            // --- File Explorer Icon ---
            GestureDetector(
              onTap: widget.onToggle,
              child: Tooltip(
                message: "Explorer",
                child: Icon(
                  Bootstrap.file_earmark,
                  weight: 1,
                  fill: 1,
                  color: widget.isOpen ? Colors.white : Colors.grey.shade400,
                  size: 24,
                ),
              ),
            ),

            const Spacer(), 

            // --- Accounts / Home Icon ---
            GestureDetector(
              onTap: widget.onHomeTap, // 3. Link the tap
              child: Tooltip(
                message: "Accounts (Home)",
                child: Icon(
                  Bootstrap.person_circle,
                  weight: 1.5,
                  color: Colors.grey.shade400,
                  size: 24,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}