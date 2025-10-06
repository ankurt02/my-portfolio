import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExplorerPanelCardOne extends StatefulWidget {
  final IconData iconName;
  final String tabName;
  final String? assetPath;

  const ExplorerPanelCardOne({
    super.key,
    required this.iconName,
    required this.tabName,
    this.assetPath,
  });

  @override
  State<ExplorerPanelCardOne> createState() => _ExplorerPanelCardOneState();
}

class _ExplorerPanelCardOneState extends State<ExplorerPanelCardOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, left: 4, right: 2, bottom: 0),
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Row(
        children: [
          Icon(widget.iconName, size: 14, color:  Colors.grey.shade300),
          Gap(4),

          if (widget.assetPath != null)
            // SvgPicture.asset(widget.assetPath!, height: 20, width: 20),

          Gap(6),

          Text(
            widget.tabName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade300,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }
}
