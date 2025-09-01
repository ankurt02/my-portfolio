// ignore_for_file: unused_import

import 'package:ankur_portfolio/screens/defaulteditor.screen.dart';
import 'package:ankur_portfolio/screens/links/github.card.dart';
import 'package:ankur_portfolio/screens/links/linkedin.card.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:flutter/material.dart';
import 'package:ankur_portfolio/models/editor.tab.dart';
import 'package:ankur_portfolio/screens/links/twitter.screen.dart';

// Converted to a StatelessWidget for better performance as it no longer manages its own state.
class EditorArea extends StatelessWidget {
  final EditorTab? activeTab;

  const EditorArea({super.key, this.activeTab});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      color: const Color(0xFF000C18),
      child: Container(
        width: screenWidth * (1540 / 1920),
        // This is the core logic:
        // If no tab is active, show the default screen.
        // If a tab IS active, show that tab's content widget.
        child: activeTab == null
            ? const Center(child: DefaultEditorScreen())
            : Center(child: activeTab!.content), // Show the active tab's content
      ),
    );
  }
}