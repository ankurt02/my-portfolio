import 'package:ankur_portfolio/screens/home.screen.dart';
import 'package:ankur_portfolio/screens/misc/research.paper.dart';
import 'package:ankur_portfolio/screens/splash.screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';
  static const String researchPaper = '/researchPpaer';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => SplashScreen(),
    home: (context) => HomeScreen(),
    researchPaper: (context) => ResearchPaperView(),
  };
}
