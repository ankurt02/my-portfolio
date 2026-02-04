import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/widgets/explorer%20cards/explorepanel.cardtwo.dart';
import 'package:ankur_portfolio/widgets/explorer%20cards/explorerpanel.cardone.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';

class ExplorerPanel extends StatefulWidget {
  final List<SocialProfile> profiles;

  const ExplorerPanel({
    super.key,
    required this.profiles,
  });

  @override
  State<ExplorerPanel> createState() => _ExplorerPanelState();
}

class _ExplorerPanelState extends State<ExplorerPanel> {

  void _handleFileTap(String routePath) {
    context.go(routePath);
  }

  void _handlePlaceholderTap(String fileName) {
    // Placeholder logic, or just show a snackbar
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    final String currentLocation = GoRouterState.of(context).uri.toString();

    return Container(
      decoration: const BoxDecoration(color: Color(0xFF252526)),
      width: screenWidth * (320 / 1920),
      height: screenHeight - 48,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // --- ABOUT ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: 'ABOUT',
              assetPath: 'assets/svg/folder.svg',
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/html5.svg",
              tabName: "index.html",
              isSelected: currentLocation == "/about/index.html",
              onTap: () => _handleFileTap('/about/index.html'),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/css.svg",
              tabName: "skills.css",
              isSelected: currentLocation == "/about/skills.css",
              onTap: () => _handleFileTap('/about/skills.css'),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/js.svg",
              tabName: "education.js",
              isSelected: currentLocation == "/about/education.js",
              onTap: () => _handleFileTap('/about/education.js'),
            ),

            // --- EXPERIENCE ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: 'EXPERIENCE',
              assetPath: 'assets/svg/folder.svg',
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/androidfull01.svg",
              tabName: "android-developer.java",
              isSelected: currentLocation == "/experience/android",
              onTap: () => _handleFileTap('/experience/android'),
            ),

            // --- PROJECTS ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: "PROJECTS",
              assetPath: 'assets/svg/folder.svg',
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/dart.svg",
              tabName: "ShikamaruAI.dart",
              isSelected: currentLocation == "/projects/shikamaru",
              onTap: () => _handleFileTap('/projects/shikamaru'),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/jupyter.svg",
              tabName: "PriceLens.ipynb",
              isSelected: false, // Placeholder
              onTap: () => _handlePlaceholderTap("PriceLens.ipynb"),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/python.svg",
              tabName: "EncryptIt.py",
              isSelected: false, // Placeholder
              onTap: () => _handlePlaceholderTap("EncryptIt.py"),
            ),

            // --- SOCIAL LINKS ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: "SOCIAL LINKS",
              assetPath: 'assets/svg/folder.svg',
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/linkedin.svg",
              tabName: "LinkedIn.url",
              isSelected: currentLocation == "/social/linkedin",
              onTap: () => _handleFileTap('/social/linkedin'),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/twitter.svg",
              tabName: "Twitter.json",
              isSelected: currentLocation == "/social/twitter",
              onTap: () => _handleFileTap('/social/twitter'),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/gmail.svg",
              tabName: "Gmail.eml",
              isSelected: currentLocation == "/social/gmail",
              onTap: () => _handleFileTap('/social/gmail'),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/github.svg",
              tabName: "Github.md",
              isSelected: currentLocation == "/social/github",
              onTap: () => _handleFileTap('/social/github'),
            ),

            // --- CERTIFICATES ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: "CERTIFICATES",
              assetPath: 'assets/svg/folder.svg',
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/brave.svg",
              tabName: "MS Azure AI-900",
              isSelected: currentLocation == "/certificates/azure",
              onTap: () => _handleFileTap('/certificates/azure'),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/chrome.svg",
              tabName: "Oracle Cloud Infrastructure",
              isSelected: currentLocation == "/certificates/oracle",
              onTap: () => _handleFileTap('/certificates/oracle'),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/edge01.svg",
              tabName: "Oracle Cloud Infrastructure - AI",
              isSelected: currentLocation == "/certificates/oracle-ai",
              onTap: () => _handleFileTap('/certificates/oracle-ai'),
            ),

            // --- MISC ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: "MISC",
              assetPath: 'assets/svg/folder.svg',
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/folder3.svg",
              tabName: "Miscellaneous",
              isSelected: currentLocation.startsWith("/misc"),
              onTap: () => _handleFileTap('/misc'),
            ),

            // --- RESUME ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: "RESUME",
              assetPath: 'assets/svg/folder.svg',
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/pdf.svg",
              tabName: "Resume.pdf",
              isSelected: currentLocation == "/resume",
              onTap: () => _handleFileTap('/resume'),
            ),
          ],
        ),
      ),
    );
  }
}