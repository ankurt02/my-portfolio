import 'package:ankur_portfolio/screens/about/index.html.dart';
import 'package:ankur_portfolio/screens/education/education.screen.dart';
import 'package:ankur_portfolio/screens/exp.homescreen.dart';
import 'package:ankur_portfolio/screens/home.screen.dart';
import 'package:ankur_portfolio/screens/job/android.developer.dart';
import 'package:ankur_portfolio/screens/links/github.card.dart';
import 'package:ankur_portfolio/screens/links/gmail.card.dart';
import 'package:ankur_portfolio/screens/links/linkedin.card.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/screens/links/twitter.screen.dart';
import 'package:ankur_portfolio/screens/misc/miscellaneous.screen.dart';
import 'package:ankur_portfolio/screens/misc/research.paper.dart';
import 'package:ankur_portfolio/screens/pdf/certificate.azure.dart';
import 'package:ankur_portfolio/screens/pdf/certificate.oracle.dart';
import 'package:ankur_portfolio/screens/pdf/certificateAI.oracle.dart';
import 'package:ankur_portfolio/screens/pdf/resume.view.dart';
import 'package:ankur_portfolio/screens/projects/shikamaru.ai.dart';
import 'package:ankur_portfolio/screens/skills/my.skills.dart';
import 'package:ankur_portfolio/screens/splash.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

class ProfileStore {
  static List<SocialProfile> profiles = [];
}

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => NoTransitionPage(child: const SplashScreen()),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return HomeScreenExp(
          profiles: ProfileStore.profiles, 
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => NoTransitionPage(child: const HomeScreen()),
        ),
        GoRoute(
          path: '/about/index.html',
          pageBuilder: (context, state) => NoTransitionPage(child: const IndexDotHtml()),
        ),
        GoRoute(
          path: '/about/skills.css',
          pageBuilder: (context, state) => NoTransitionPage(child: const SkillsScreen()),
        ),
        GoRoute(
          path: '/about/education.js',
          pageBuilder: (context, state) => NoTransitionPage(child: const TimelineScreen()),
        ),
        GoRoute(
          path: '/experience/android',
          pageBuilder: (context, state) => NoTransitionPage(child: const AndroidDev42Gears()),
        ),
        GoRoute(
          path: '/projects/shikamaru',
          pageBuilder: (context, state) => NoTransitionPage(child: const ShikamaruAI()),
        ),
        GoRoute(
          path: '/social/linkedin',
          pageBuilder: (context, state) {
             final profile = ProfileStore.profiles.firstWhere((p) => p is LinkedInProfile, orElse: () => LinkedInProfile(
               name: 'User',
               username: 'user',
               profilePicUrl: '',
               workingat: '',
               location: '',
               connections: '',
               bannerImageUrl: '',
             ));
             return NoTransitionPage(child: LinkedInCard(profile: profile as LinkedInProfile));
          },
        ),
        GoRoute(
          path: '/social/twitter',
          pageBuilder: (context, state) {
            final profile = ProfileStore.profiles.firstWhere((p) => p is XProfile, orElse: () => XProfile(
              name: 'User',
              username: 'user',
              profilePicUrl: '',
              bannerUrl: '',
            ));
            return NoTransitionPage(child: TwitterCard(profile: profile as XProfile));
          },
        ),
        GoRoute(
          path: '/social/gmail',
          pageBuilder: (context, state) => NoTransitionPage(child: const GmailCard()),
        ),
        GoRoute(
          path: '/social/github',
          pageBuilder: (context, state) {
            final profile = ProfileStore.profiles.firstWhere((p) => p is GitHubProfile, orElse: () => GitHubProfile(
              name: 'User',
              username: 'user',
              profilePicUrl: '',
              totalRepos: 0,
              followers: 0,
              totalContributions: 0,
            ));
            return NoTransitionPage(child: GitHubCard(profile: profile as GitHubProfile));
          },
        ),
        GoRoute(
          path: '/certificates/azure',
          pageBuilder: (context, state) => NoTransitionPage(child: const CertificateAzure()),
        ),
        GoRoute(
          path: '/certificates/oracle',
          pageBuilder: (context, state) => NoTransitionPage(child: const CertificateOracle()),
        ),
        GoRoute(
          path: '/certificates/oracle-ai',
          pageBuilder: (context, state) => NoTransitionPage(child: const CertificateOracleAI()),
        ),
        GoRoute(
          path: '/misc',
          pageBuilder: (context, state) => NoTransitionPage(child: MiscellaneousScreen(
            onOpenTab: (tab) {}, 
          )),
        ),
        GoRoute(
          path: '/misc/research',
          pageBuilder: (context, state) => NoTransitionPage(child: const ResearchPaperView()),
        ),
        GoRoute(
          path: '/resume',
          pageBuilder: (context, state) => NoTransitionPage(child: const ResumeView()),
        ),
      ],
    ),
  ],
);
