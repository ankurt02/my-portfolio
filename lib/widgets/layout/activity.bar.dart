import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:ankur_portfolio/widgets/tooltip/side.tooltip.dart';

class ActivityBar extends StatefulWidget {
  final VoidCallback onToggle;
  final VoidCallback onHomeTap;
  final bool isOpen;

  const ActivityBar({
    super.key,
    required this.onToggle,
    required this.onHomeTap,
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
            SideTooltip(
              message: "Explorer",
              child: GestureDetector(
                onTap: widget.onToggle,
                child: Icon(
                  Bootstrap.file_earmark,
                  weight: 1,
                  fill: 1,
                  color: widget.isOpen ? Colors.white : Colors.grey.shade200,
                  size: 26,
                ),
              ),
            ),

            const Spacer(), 

            // --- Accounts / Home Icon ---
            SideTooltip(
              message: "Accounts (Home)",
              child: GestureDetector(
                onTap: widget.onHomeTap,
                child: Icon(
                  Bootstrap.person_circle,
                  weight: 1.5,
                  color: Colors.grey.shade200,
                  size: 26,
                ),
              ),
            ),
            Gap(16),
            SideTooltip(         
              message: "Settings",
              child: GestureDetector(
                onTap: widget.onHomeTap,
                child: SvgPicture.asset(
                  "assets/svg/settings01.svg",
                  width: 26,
                  height: 26,
                  colorFilter: ColorFilter.mode(
                    Colors.grey.shade200,
                    BlendMode.srcIn
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Custom Side Tooltip Widget
