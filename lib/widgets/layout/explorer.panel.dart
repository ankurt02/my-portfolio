import 'package:ankur_portfolio/models/editor.tab.dart';
import 'package:ankur_portfolio/screens/links/socials.dart'; // Import your social profiles
import 'package:ankur_portfolio/screens/links/twitter.screen.dart';
import 'package:ankur_portfolio/screens/pdf/resume.view.dart';
import 'package:ankur_portfolio/widgets/explorer%20cards/explorepanel.cardtwo.dart';
import 'package:ankur_portfolio/widgets/explorer%20cards/explorerpanel.cardone.dart';
import 'package:ankur_portfolio/screens/links/github.card.dart';
import 'package:ankur_portfolio/screens/links/gmail.card.dart';
import 'package:ankur_portfolio/screens/links/linkedin.card.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ExplorerPanel extends StatefulWidget {
  final void Function(EditorTab tab) onOpenTab;
  const ExplorerPanel({super.key, required this.onOpenTab});

  @override
  State<ExplorerPanel> createState() => _ExplorerPanelState();
}

class _ExplorerPanelState extends State<ExplorerPanel> {
  // Future to hold the social profiles data
  late Future<List<SocialProfile>> _profilesFuture;

  @override
  void initState() {
    super.initState();
    // Fetch the profiles when the widget is initialized
    _profilesFuture = SocialsService.fetchProfiles();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF252526)),
      width: screenWidth * (320 / 1920),
      height: screenHeight - 48,

      child: FutureBuilder<List<SocialProfile>>(
        future: _profilesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF252526)),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Error', style: TextStyle(color: Colors.redAccent)),
            );
          }

          final profiles = snapshot.data!;
          
          final linkedInProfile =
              profiles.firstWhere((p) => p is LinkedInProfile)
                  as LinkedInProfile;
          final xProfile =
              profiles.firstWhere((p) => p is XProfile) as XProfile;
          final gitHubProfile =
              profiles.firstWhere((p) => p is GitHubProfile) as GitHubProfile;

          
          return Column(
            children: [
              ExplorerPanelCardOne(
                iconName: FontAwesome.angle_down_solid,
                tabName: 'ABOUT',
                assetPath: 'assets/svg/folder.svg',
              ),
              ExplorePanelCardTwo(
                assetPath: "assets/svg/html5.svg",
                tabName: "index.html",
              ),
              ExplorePanelCardTwo(
                assetPath: "assets/svg/css.svg",
                tabName: "skills.css",
              ),
              ExplorePanelCardTwo(
                assetPath: "assets/svg/js.svg",
                tabName: "project.js",
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
                onTap:
                    () => widget.onOpenTab(
                      EditorTab(
                        title: "LinkedIn.url",
                        content: LinkedInCard(profile: linkedInProfile),
                      ),
                    ),
              ),
              ExplorePanelCardTwo(
                assetPath: "assets/svg/twitter.svg",
                tabName: "Twitter.json",
                onTap:
                    () => widget.onOpenTab(
                      EditorTab(
                        title: "Twitter.json",
                        content: TwitterCard(profile: xProfile),
                      ),
                    ),
              ),
              ExplorePanelCardTwo(
                assetPath: "assets/svg/gmail.svg",
                tabName: "Gmail.eml",
                onTap:
                    () => widget.onOpenTab(
                      EditorTab(title: "Gmail.eml", content: const GmailCard()),
                    ),
              ),
              ExplorePanelCardTwo(
                assetPath: "assets/svg/github.svg",
                tabName: "Github.md",
                onTap:
                    () => widget.onOpenTab(
                      EditorTab(
                        title: "Github.md",
                        content: GitHubCard(profile: gitHubProfile),
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
                tabName: "Anime.mkv",
              ),
              ExplorePanelCardTwo(
                assetPath: "assets/svg/spotify-color-svgrepo-com.svg",
                tabName: "Songs.mp3",
              ),
              ExplorePanelCardTwo(
                assetPath: "assets/svg/netflixfull.svg",
                tabName: "Webseries.binge",
              ),
              ExplorerPanelCardOne(
                iconName: FontAwesome.angle_down_solid,
                tabName: "RESUME",
                assetPath: 'assets/svg/folder.svg',
              ),
              ExplorePanelCardTwo(
                assetPath: "assets/svg/pdf.svg",
                tabName: "Resume.pdf",
                onTap:
                    () => widget.onOpenTab(
                      EditorTab(
                        title: "Resume.pdf",
                        content: const ResumeView(),
                      ),
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}
