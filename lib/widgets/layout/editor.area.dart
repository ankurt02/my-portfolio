// ignore_for_file: unused_import

import 'package:ankur_portfolio/screens/defaulteditor.screen.dart';
import 'package:ankur_portfolio/screens/links/github.card.dart';
import 'package:ankur_portfolio/screens/links/linkedin.card.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/screens/misc/miscellaneous.screen.dart';
import 'package:flutter/material.dart';
import 'package:ankur_portfolio/models/editor.tab.dart';
import 'package:ankur_portfolio/screens/links/twitter.screen.dart';

class EditorArea extends StatelessWidget {
  final Widget child;

  const EditorArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      color: const Color(0xFF000C18),
      child: Container(
        width: screenWidth * (1540 / 1920),
        child: Center(child: child),
      ),
    );
  }
}