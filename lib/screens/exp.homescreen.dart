import 'package:ankur_portfolio/models/editor.tab.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/widgets/layout/activity.bar.dart';
import 'package:ankur_portfolio/widgets/layout/editor.area.dart';
import 'package:ankur_portfolio/widgets/layout/explorer.panel.dart';
import 'package:ankur_portfolio/widgets/layout/status.bar.dart';
import 'package:ankur_portfolio/widgets/layout/task.bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 

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
  bool _isExplorerOpen = true;

  void _toggleExplorer() {
    setState(() {
      _isExplorerOpen = !_isExplorerOpen;
    });
  }

  void _navigateToHome() {
   while (context.canPop()) {
      context.pop();
    }
    context.replace('/'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TaskBar(),
          Expanded(
            child: Row(
              children: [
                ActivityBar(
                  onToggle: _toggleExplorer,
                  isOpen: _isExplorerOpen,
                  onHomeTap: _navigateToHome, // Pass the navigation function
                ),
                
                if (_isExplorerOpen)
                  ExplorerPanel(
                    profiles: widget.profiles,
                  ),
                  
                Expanded(
                  child: EditorArea(child: widget.child),
                ),
              ],
            ),
          ),
          const StatusBar(),
        ],
      ),
    );
  }
}