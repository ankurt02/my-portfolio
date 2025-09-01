// ignore: unused_import
import 'package:ankur_portfolio/screens/home/welcome.screen.dart';
import 'package:ankur_portfolio/widgets/layout/activity.bar.dart';
import 'package:ankur_portfolio/widgets/layout/editor.area.dart';
import 'package:ankur_portfolio/widgets/layout/explorer.panel.dart';
import 'package:ankur_portfolio/widgets/layout/status.bar.dart';
import 'package:ankur_portfolio/widgets/layout/task.bar.dart';
import 'package:flutter/material.dart';
import 'package:ankur_portfolio/models/editor.tab.dart';

class HomeScereen extends StatefulWidget {
  const HomeScereen({super.key});

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
      
                // Explorer panel (pass callback)
                ExplorerPanel(onOpenTab: openTab),
      
                // Editor area (shows selected file)
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
