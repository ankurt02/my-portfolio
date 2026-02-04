import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ExplorePanelCardTwo extends StatelessWidget {
  final String assetPath;
  final String tabName;
  final VoidCallback? onTap;
  final Color? customColor;
  final bool isSelected;

  const ExplorePanelCardTwo({
    super.key,
    required this.assetPath,
    required this.tabName,
    this.onTap,
    this.customColor,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = customColor ?? Colors.white70;
    const selectedColor = Color(0xFF37373D);

    return Material(
      color: isSelected ? selectedColor : Colors.transparent,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(left: 36),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              SvgPicture.asset(
                assetPath,
                height: 18,
                width: 18,
                colorFilter:
                    customColor != null
                        ? ColorFilter.mode(customColor!, BlendMode.srcIn)
                        : null,
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  tabName,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
