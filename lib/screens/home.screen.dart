import 'package:ankur_portfolio/models/editor.tab.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/widgets/layout/activity.bar.dart';
import 'package:ankur_portfolio/widgets/layout/editor.area.dart';
import 'package:ankur_portfolio/widgets/layout/explorer.panel.dart';
import 'package:ankur_portfolio/widgets/layout/status.bar.dart';
import 'package:ankur_portfolio/widgets/layout/task.bar.dart';
import 'package:flutter/material.dart';

class HomeScereen extends StatefulWidget {
  final List<SocialProfile> profiles;

  const HomeScereen({super.key, required this.profiles});

  @override
  State<HomeScereen> createState() => _HomeScereenState();
}

class _HomeScereenState extends State<HomeScereen> {
  EditorTab? activeTab;

  void openTab(EditorTab tab) {
    setState(() => activeTab = tab);
  }

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
                  onOpenTab: openTab,
                  profiles: widget.profiles,
                ),
                Expanded(
                  child: EditorArea(activeTab: activeTab),
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