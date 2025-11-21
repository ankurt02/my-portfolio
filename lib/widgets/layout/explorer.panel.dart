import 'package:ankur_portfolio/models/editor.tab.dart';
import 'package:ankur_portfolio/screens/about/index.html.dart';
import 'package:ankur_portfolio/screens/education/education.screen.dart';
import 'package:ankur_portfolio/screens/job/android.developer.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/screens/links/twitter.screen.dart';
import 'package:ankur_portfolio/screens/misc/miscellaneous.screen.dart';
import 'package:ankur_portfolio/screens/pdf/certificate.azure.dart';
import 'package:ankur_portfolio/screens/pdf/certificate.oracle.dart';
import 'package:ankur_portfolio/screens/pdf/certificateAI.oracle.dart';
import 'package:ankur_portfolio/screens/pdf/resume.view.dart';
import 'package:ankur_portfolio/screens/projects/shikamaru.ai.dart';
import 'package:ankur_portfolio/screens/skills/my.skills.dart';
import 'package:ankur_portfolio/widgets/explorer%20cards/explorepanel.cardtwo.dart';
import 'package:ankur_portfolio/widgets/explorer%20cards/explorerpanel.cardone.dart';
import 'package:ankur_portfolio/screens/links/github.card.dart';
import 'package:ankur_portfolio/screens/links/gmail.card.dart';
import 'package:ankur_portfolio/screens/links/linkedin.card.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ExplorerPanel extends StatefulWidget {
  final void Function(EditorTab tab) onOpenTab;
  final List<SocialProfile> profiles;

  const ExplorerPanel({
    super.key,
    required this.onOpenTab,
    required this.profiles,
  });

  @override
  State<ExplorerPanel> createState() => _ExplorerPanelState();
}

class _ExplorerPanelState extends State<ExplorerPanel> {
  String _selectedFileName = "";

  void _handleFileTap(String fileName, Widget content) {
    setState(() {
      _selectedFileName = fileName;
    });
    widget.onOpenTab(EditorTab(title: fileName, content: content));
  }

  void _handlePlaceholderTap(String fileName) {
    setState(() {
      _selectedFileName = fileName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final linkedInProfile = widget.profiles.firstWhere((p) => p is LinkedInProfile) as LinkedInProfile;
    final xProfile = widget.profiles.firstWhere((p) => p is XProfile) as XProfile;
    final gitHubProfile = widget.profiles.firstWhere((p) => p is GitHubProfile) as GitHubProfile;

    return Container(
      decoration: const BoxDecoration(color: Color(0xFF252526)),
      width: screenWidth * (320 / 1920),
      height: screenHeight - 48,
      child: SingleChildScrollView( // Added scroll view for safety
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
              isSelected: _selectedFileName == "index.html",
              onTap: () => _handleFileTap("index.html", IndexDotHtml()),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/css.svg",
              tabName: "skills.css",
              isSelected: _selectedFileName == "skills.css",
              onTap: () => _handleFileTap("skills.css", SkillsScreen()),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/js.svg",
              tabName: "education.js",
              isSelected: _selectedFileName == "education.js",
              onTap: () => _handleFileTap("education.js", TimelineScreen()),
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
              isSelected: _selectedFileName == "android-developer.java",
              onTap: () => _handleFileTap("android-developer.java", AndroidDev42Gears()),
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
              isSelected: _selectedFileName == "ShikamaruAI.dart",
              onTap: () => _handleFileTap("ShikamaruAI.dart", ShikamaruAI()),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/jupyter.svg",
              tabName: "PriceLens.ipynb",
              isSelected: _selectedFileName == "PriceLens.ipynb",
              onTap: () => _handlePlaceholderTap("PriceLens.ipynb"),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/python.svg",
              tabName: "EncryptIt.py",
              isSelected: _selectedFileName == "EncryptIt.py",
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
              isSelected: _selectedFileName == "LinkedIn.url",
              onTap: () => _handleFileTap("LinkedIn.url", LinkedInCard(profile: linkedInProfile)),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/twitter.svg",
              tabName: "Twitter.json",
              isSelected: _selectedFileName == "Twitter.json",
              onTap: () => _handleFileTap("Twitter.json", TwitterCard(profile: xProfile)),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/gmail.svg",
              tabName: "Gmail.eml",
              isSelected: _selectedFileName == "Gmail.eml",
              onTap: () => _handleFileTap("Gmail.eml", const GmailCard()),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/github.svg",
              tabName: "Github.md",
              isSelected: _selectedFileName == "Github.md",
              onTap: () => _handleFileTap("Github.md", GitHubCard(profile: gitHubProfile)),
            ),

            // --- CERTIFICATES ---
            ExplorerPanelCardOne(
              iconName: FontAwesome.angle_down_solid,
              tabName: "CERTIFICATES",
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/brave.svg",
              tabName: "MS Azure AI-900",
              isSelected: _selectedFileName == "MS Azure AI-900",
              onTap: () => _handleFileTap("MS Azure AI-900", CertificateAzure()),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/chrome.svg",
              tabName: "Oracle Cloud Infrastructure",
              isSelected: _selectedFileName == "Oracle Cloud Infrastructure",
              onTap: () => _handleFileTap("Oracle Cloud Infrastructure", CertificateOracle()),
            ),
            ExplorePanelCardTwo(
              assetPath: "assets/svg/edge01.svg",
              tabName: "Oracle Cloud Infrastructure - AI",
              isSelected: _selectedFileName == "Oracle Cloud Infrastructure - AI",
              onTap: () => _handleFileTap("Oracle Cloud Infrastructure - AI", CertificateOracleAI()),
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
              isSelected: _selectedFileName == "Miscellaneous",
              onTap: () => _handleFileTap("Miscellaneous", MiscellaneousScreen(onOpenTab: widget.onOpenTab)),
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
              isSelected: _selectedFileName == "Resume.pdf",
              onTap: () => _handleFileTap("Resume.pdf", const ResumeView()),
            ),
          ],
        ),
      ),
    );
  }
}