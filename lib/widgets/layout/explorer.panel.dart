
import 'package:ankur_portfolio/providers/tab.management.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/widgets/explorer%20cards/explorepanel.cardtwo.dart';
import 'package:ankur_portfolio/widgets/explorer%20cards/explorerpanel.cardone.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
  void _handleFileTap(BuildContext context, {
    required String routePath,
    required String title,
    required String iconPath,
  }) {
    context.read<TabManager>().openTab(
          id: routePath,
          title: title,
          route: routePath,
          iconPath: iconPath,
        );
    
    context.go(routePath);
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
              children: [
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/html5.svg",
                  tabName: "index.html",
                  isSelected: currentLocation == "/about/index.html",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/about/index.html',
                    title: 'index.html',
                    iconPath: 'assets/svg/html5.svg',
                  ),
                ),
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/css.svg",
                  tabName: "skills.css",
                  isSelected: currentLocation == "/about/skills.css",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/about/skills.css',
                    title: 'skills.css',
                    iconPath: 'assets/svg/css.svg',
                  ),
                ),
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/js.svg",
                  tabName: "education.js",
                  isSelected: currentLocation == "/about/education.js",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/about/education.js',
                    title: 'education.js',
                    iconPath: 'assets/svg/js.svg',
                  ),
                ),
              ],
            ),

            // --- EXPERIENCE ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: 'EXPERIENCE',
              assetPath: 'assets/svg/folder.svg',
              children: [
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/androidfull01.svg",
                  tabName: "android-developer.java",
                  isSelected: currentLocation == "/experience/android",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/experience/android',
                    title: 'android-developer.java',
                    iconPath: 'assets/svg/androidfull01.svg',
                  ),
                ),
              ],
            ),

            // --- PROJECTS ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: "PROJECTS",
              assetPath: 'assets/svg/folder.svg',
              children: [
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/dart.svg",
                  tabName: "ShikamaruAI.dart",
                  isSelected: currentLocation == "/projects/shikamaruAi",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/projects/shikamaruAi',
                    title: 'ShikamaruAI.dart',
                    iconPath: 'assets/svg/dart.svg',
                  ),
                ),
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/jupyter.svg",
                  tabName: "PriceLens.ipynb",
                  isSelected: currentLocation == "/projects/priceLense",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/projects/priceLense',
                    title: 'PriceLens.ipynb',
                    iconPath: 'assets/svg/jupyter.svg',
                  ),
                ),
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/python.svg",
                  tabName: "EncryptIt.py",
                  isSelected: currentLocation == "/projects/encryptIt",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/projects/encryptIt',
                    title: 'EncryptIt.py',
                    iconPath: 'assets/svg/python.svg',
                  ),
                ),
              ],
            ),

            // --- SOCIAL LINKS ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: "SOCIAL LINKS",
              assetPath: 'assets/svg/folder.svg',
              children: [
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/linkedin.svg",
                  tabName: "LinkedIn.url",
                  isSelected: currentLocation == "/social/linkedin",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/social/linkedin',
                    title: 'LinkedIn.url',
                    iconPath: 'assets/svg/linkedin.svg',
                  ),
                ),
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/twitter.svg",
                  tabName: "Twitter.json",
                  isSelected: currentLocation == "/social/twitter",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/social/twitter',
                    title: 'Twitter.json',
                    iconPath: 'assets/svg/twitter.svg',
                  ),
                ),
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/gmail.svg",
                  tabName: "Gmail.eml",
                  isSelected: currentLocation == "/social/gmail",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/social/gmail',
                    title: 'Gmail.eml',
                    iconPath: 'assets/svg/gmail.svg',
                  ),
                ),
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/github.svg",
                  tabName: "Github.md",
                  isSelected: currentLocation == "/social/github",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/social/github',
                    title: 'Github.md',
                    iconPath: 'assets/svg/github.svg',
                  ),
                ),
              ],
            ),

            // --- CERTIFICATES ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: "CERTIFICATES",
              assetPath: 'assets/svg/folder.svg',
              children: [
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/brave.svg",
                  tabName: "MS Azure AI-900",
                  isSelected: currentLocation == "/certificates/azure",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/certificates/azure',
                    title: 'MS Azure AI-900',
                    iconPath: 'assets/svg/brave.svg',
                  ),
                ),
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/chrome.svg",
                  tabName: "Oracle Cloud Infrastructure",
                  isSelected: currentLocation == "/certificates/oracle",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/certificates/oracle',
                    title: 'Oracle Cloud Infrastructure',
                    iconPath: 'assets/svg/chrome.svg',
                  ),
                ),
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/edge01.svg",
                  tabName: "Oracle Cloud Infrastructure - AI",
                  isSelected: currentLocation == "/certificates/oracle-ai",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/certificates/oracle-ai',
                    title: 'Oracle Cloud Infrastructure - AI',
                    iconPath: 'assets/svg/edge01.svg',
                  ),
                ),
              ],
            ),

            // --- MISC ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: "MISC",
              assetPath: 'assets/svg/folder.svg',
              children: [
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/folder3.svg",
                  tabName: "Miscellaneous",
                  isSelected: currentLocation.startsWith("/misc"),
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/misc',
                    title: 'Miscellaneous',
                    iconPath: 'assets/svg/folder3.svg',
                  ),
                ),
              ],
            ),

            // --- RESUME ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: "RESUME",
              assetPath: 'assets/svg/folder.svg',
              children: [
                ExplorePanelCardTwo(
                  assetPath: "assets/svg/pdf.svg",
                  tabName: "Resume.pdf",
                  isSelected: currentLocation == "/resume",
                  onTap: () => _handleFileTap(
                    context,
                    routePath: '/resume',
                    title: 'Resume.pdf',
                    iconPath: 'assets/svg/pdf.svg',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}