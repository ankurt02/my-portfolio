import 'package:ankur_portfolio/screens/home.screen.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScereen(profiles: profiles),
          ),
        );
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
    return Scaffold(
      backgroundColor: Colors.black, 
      body: Center(
        child: Lottie.network(
  'assets/gif/hello.json',
  controller: _controller,
  onLoaded: (composition) {
    _controller
      ..duration = composition.duration
      ..forward().whenComplete(_onAnimationComplete);
  },
)
,
      ),
    );
  }
}