import 'package:ankur_portfolio/models/editor.tab.dart';
import 'package:ankur_portfolio/screens/about/index.html.dart';
import 'package:ankur_portfolio/screens/education/education.screen.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/screens/links/twitter.screen.dart';
import 'package:ankur_portfolio/screens/misc/research.paper.dart';
import 'package:ankur_portfolio/screens/pdf/certificate.azure.dart';
import 'package:ankur_portfolio/screens/pdf/certificate.oracle.dart';
import 'package:ankur_portfolio/screens/pdf/resume.view.dart';
import 'package:ankur_portfolio/widgets/explorer%20cards/explorepanel.cardtwo.dart';
import 'package:ankur_portfolio/widgets/explorer%20cards/explorerpanel.cardone.dart';
import 'package:ankur_portfolio/screens/links/github.card.dart';
import 'package:ankur_portfolio/screens/links/gmail.card.dart';
import 'package:ankur_portfolio/screens/links/linkedin.card.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ExplorerPanel extends StatelessWidget {
  final void Function(EditorTab tab) onOpenTab;
  final List<SocialProfile> profiles;

  const ExplorerPanel({
    super.key,
    required this.onOpenTab,
    required this.profiles,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // The Future is already completed, so we can directly access the data
    final linkedInProfile =
        profiles.firstWhere((p) => p is LinkedInProfile) as LinkedInProfile;
    final xProfile = profiles.firstWhere((p) => p is XProfile) as XProfile;
    final gitHubProfile =
        profiles.firstWhere((p) => p is GitHubProfile) as GitHubProfile;

    return Container(
      decoration: const BoxDecoration(color: Color(0xFF252526)),
      width: screenWidth * (320 / 1920),
      height: screenHeight - 48,
      child: Column(
        children: [
          ExplorerPanelCardOne(
            iconName: FontAwesome.angle_down_solid,
            tabName: 'ABOUT',
            assetPath: 'assets/svg/folder.svg',
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/html5.svg",
            tabName: "index.html",
            onTap: () => onOpenTab(
              EditorTab(title: "Index.html", content: IndexDotHtml()),
            ),
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/css.svg",
            tabName: "skills.css",
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/js.svg",
            tabName: "education.js",
            onTap: () => onOpenTab(
              EditorTab(
                title: "education.js",
                content: TimelinePage(),
              ),
            ),
          ),
          ExplorerPanelCardOne(
            iconName: FontAwesome.angle_down_solid,
            tabName: "PROJECTS",
            assetPath: 'assets/svg/folder.svg',
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/dart.svg",
            tabName: "ShikamaruAI.dart",
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/python.svg",
            tabName: "EncryptIt.py",
          ),
          ExplorerPanelCardOne(
            iconName: FontAwesome.angle_down_solid,
            tabName: "SOCIAL LINKS",
            assetPath: 'assets/svg/folder.svg',
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/linkedin.svg",
            tabName: "LinkedIn.url",
            onTap: () => onOpenTab(
              EditorTab(
                title: "LinkedIn.url",
                content: LinkedInCard(profile: linkedInProfile),
              ),
            ),
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/twitter.svg",
            tabName: "Twitter.json",
            onTap: () => onOpenTab(
              EditorTab(
                title: "Twitter.json",
                content: TwitterCard(profile: xProfile),
              ),
            ),
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/gmail.svg",
            tabName: "Gmail.eml",
            onTap: () => onOpenTab(
              EditorTab(title: "Gmail.eml", content: const GmailCard()),
            ),
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/github.svg",
            tabName: "Github.md",
            onTap: () => onOpenTab(
              EditorTab(
                title: "Github.md",
                content: GitHubCard(profile: gitHubProfile),
              ),
            ),
          ),
          ExplorerPanelCardOne(
            iconName: FontAwesome.angle_down_solid,
            tabName: "CERTIFICATES",
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/brave.svg",
            tabName: "MS Azure AI-900",
            onTap: () => onOpenTab(
              EditorTab(
                title: "MS Azure AI-900",
                content: CertificateAzure(),
              ),
            ),
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/chrome.svg",
            tabName: "Oracle Cloud Infrastructure",
            onTap: () => onOpenTab(
              EditorTab(
                title: "Oracle Cloud Infrastructure",
                content: CertificateOracle(),
              ),
            ),
          ),
          ExplorerPanelCardOne(
            iconName: FontAwesome.angle_down_solid,
            tabName: "MISC",
            assetPath: 'assets/svg/folder.svg',
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/crunchyroll001.svg",
            customColor: const Color(0xFFF47521),
            tabName: "Anime.mkv",
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/spotify-color-svgrepo-com.svg",
            tabName: "Songs.mp3",
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/netflix.svg",
            customColor: Color(0xFFB2070F),
            tabName: "Webseries.binge",
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/paperclip01.svg",
            customColor: Colors.grey.shade400,
            tabName: "Research-paper",
            onTap: () => onOpenTab(
              EditorTab(
                title: "Research-paper",
                content: ResearchPaperView(),
              ),
            ),
          ),
          ExplorerPanelCardOne(
            iconName: FontAwesome.angle_down_solid,
            tabName: "RESUME",
            assetPath: 'assets/svg/folder.svg',
          ),
          ExplorePanelCardTwo(
            assetPath: "assets/svg/pdf.svg",
            tabName: "Resume.pdf",
            onTap: () => onOpenTab(
              EditorTab(
                title: "Resume.pdf",
                content: const ResumeView(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}