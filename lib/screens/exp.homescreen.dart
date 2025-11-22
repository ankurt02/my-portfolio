import 'package:ankur_portfolio/models/editor.tab.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/widgets/layout/activity.bar.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/widgets/layout/activity.bar.dart';
import 'package:ankur_portfolio/widgets/layout/editor.area.dart';
import 'package:ankur_portfolio/widgets/layout/explorer.panel.dart';
import 'package:ankur_portfolio/widgets/layout/status.bar.dart';
import 'package:ankur_portfolio/widgets/layout/task.bar.dart';
import 'package:flutter/material.dart';

class HomeScreenExp extends StatefulWidget {
  final List<SocialProfile> profiles;
  final Widget child;

  const HomeScreenExp({
    super.key,
    required this.profiles,
    required this.child,
  });

  @override
  State<HomeScreenExp> createState() => _HomeScreenExpState();
}

class _HomeScreenExpState extends State<HomeScreenExp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TaskBar(),
          Expanded(
            child: Row(
              children: [
                ActivityBar(),
                ExplorerPanel(
                  profiles: widget.profiles,
                ),
                Expanded(
                  child: EditorArea(child: widget.child),
                ),
              ],
            ),
          ),
          StatusBar(),
        ],
      ),
    );
  }
}