import 'package:flutter/material.dart';

enum TooltipDirection { top, bottom, left, right }

class SideTooltip extends StatefulWidget {
  final String message;
  final Widget child;
  final TooltipDirection direction;

  const SideTooltip({
    required this.message,
    required this.child,
    this.direction = TooltipDirection.right,
  });

  @override
  State<SideTooltip> createState() => SideTooltipState();
}

class SideTooltipState extends State<SideTooltip> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final LayerLink _link = LayerLink();

  Alignment get _targetAnchor => switch (widget.direction) {
        TooltipDirection.right  => Alignment.centerRight,
        TooltipDirection.left   => Alignment.centerLeft,
        TooltipDirection.top    => Alignment.topCenter,
        TooltipDirection.bottom => Alignment.bottomCenter,
      };

  Alignment get _followerAnchor => switch (widget.direction) {
        TooltipDirection.right  => Alignment.centerLeft,
        TooltipDirection.left   => Alignment.centerRight,
        TooltipDirection.top    => Alignment.bottomCenter,
        TooltipDirection.bottom => Alignment.topCenter,
      };

  Offset get _offset => switch (widget.direction) {
        TooltipDirection.right  => const Offset(12, 0),
        TooltipDirection.left   => const Offset(-12, 0),
        TooltipDirection.top    => const Offset(0, -12),
        TooltipDirection.bottom => const Offset(0, 12),
      };

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
              targetAnchor: _targetAnchor,
              followerAnchor: _followerAnchor,
              offset: _offset,
              child: FractionalTranslation(
                translation: const Offset(0, 0),
                child: IgnorePointer(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 0,
                        maxWidth: 220,
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