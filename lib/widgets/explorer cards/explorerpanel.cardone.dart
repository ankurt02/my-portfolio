import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExplorerPanelCardOne extends StatefulWidget {
  final IconData iconName;
  final String tabName;
  final String? assetPath;
  final List<Widget> children;

  const ExplorerPanelCardOne({
    super.key,
    required this.iconName,
    required this.tabName,
    this.assetPath,
    this.children = const [],
  });

  @override
  State<ExplorerPanelCardOne> createState() => _ExplorerPanelCardOneState();
}

class _ExplorerPanelCardOneState extends State<ExplorerPanelCardOne> {
  bool isExpanded = true;

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleExpansion,
          child: Container(
            margin: const EdgeInsets.only(top: 0, left: 4, right: 2, bottom: 0),
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            child: Row(
              children: [
                AnimatedRotation(
                  turns: isExpanded ? 0 : -0.25,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    widget.iconName,
                    size: 14,
                    color: Colors.grey.shade300,
                  ),
                ),
                const Gap(4),
                if (widget.assetPath != null)
                  // SvgPicture.asset(widget.assetPath!, height: 20, width: 20),
                  const Gap(6),
                Text(
                  widget.tabName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade300,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.children,
          ),
          secondChild: const SizedBox.shrink(),
          crossFadeState: isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}