import 'package:ankur_portfolio/screens/exp.homescreen.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:ankur_portfolio/routing/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Future<List<SocialProfile>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = SocialsService.fetchProfiles();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onAnimationComplete() async {
    try {
      final profiles = await _dataFuture;
      ProfileStore.profiles = profiles; // Store profiles globally for the ShellRoute
      if (mounted) {
        context.replace('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading portfolio data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: screenHeight,
          width: screenWidht,
          child: Lottie.network(
            'https://resume-hosting-f1c9d.web.app/Hello.json',
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward().whenComplete(_onAnimationComplete);
            },
          ),
        ),
      ),
    );
  }
}
