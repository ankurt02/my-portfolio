import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

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
            _SideTooltip(
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
            _SideTooltip(
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
            _SideTooltip(
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
class _SideTooltip extends StatefulWidget {
  final String message;
  final Widget child;

  const _SideTooltip({
    required this.message,
    required this.child,
  });

  @override
  State<_SideTooltip> createState() => _SideTooltipState();
}


class _SideTooltipState extends State<_SideTooltip> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final LayerLink _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _tooltipController,
        overlayChildBuilder: (BuildContext context) {
          return Positioned(
            height: 32,
            child: CompositedTransformFollower(
              link: _link,
              showWhenUnlinked: false,
              targetAnchor: Alignment.centerRight,
              followerAnchor: Alignment.centerLeft,
              offset: const Offset(16, 0),
              child: FractionalTranslation(
                translation: const Offset(0, 0),
                child: IgnorePointer(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 0,
                        maxWidth: 180,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade700,
                          width: 0.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        widget.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        child: MouseRegion(
          onEnter: (_) => _tooltipController.show(),
          onExit: (_) => _tooltipController.hide(),
          child: widget.child,
        ),
      ),
    );
  }
}