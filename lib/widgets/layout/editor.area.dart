import 'package:ankur_portfolio/widgets/layout/tab.bar.dart';
// import 'package:ankur_portfolio/widgets/layout/tab_bar.dart';
import 'package:flutter/material.dart';

class EditorArea extends StatelessWidget {
  final Widget child;

  const EditorArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      color: const Color(0xFF24273A),
      child: Container(
        width: screenWidth * (1540 / 1920),
        child: Column(
          children: [
            // Tab bar
            const EditorTabBar(),
            
            // Editor content
            Expanded(
              child: Container(
                color: const Color(0xFF24273A),
                child: Center(child: child),
              ),
            ),
          ],
        ),
      ),
    );
  }
}