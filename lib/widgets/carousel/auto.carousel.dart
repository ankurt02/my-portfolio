import 'dart:async';
import 'package:ankur_portfolio/widgets/carousel/carousel.card.dart';
import 'package:flutter/material.dart';


class SkillData {
  final String assetPath;
  final String skillName;

  const SkillData({required this.assetPath, required this.skillName});
}

class CarouselScreen extends StatelessWidget {
  const CarouselScreen({Key? key}) : super(key: key);

  static const List<SkillData> mySkills = [
    SkillData(assetPath: "assets/svg/mysql.svg", skillName: "MySQL"),
    SkillData(assetPath: "assets/svg/html5.svg", skillName: "HTML5"),
    SkillData(assetPath: "assets/svg/css.svg", skillName: "CSS"),
    SkillData(assetPath: "assets/svg/python.svg", skillName: "Python"),
    SkillData(assetPath: "assets/svg/dart.svg", skillName: "Dart"),
    SkillData(assetPath: "assets/svg/flutter.svg", skillName: "Flutter"),
    SkillData(assetPath: "assets/svg/figma.svg", skillName: "Figma"),
    SkillData(assetPath: "assets/svg/git_icon01.svg", skillName: "Git"),
    SkillData(assetPath: "assets/svg/androidfull01.svg", skillName: "Android"),
    SkillData(assetPath: "assets/svg/kotlin01.svg", skillName: "Kotlin"),
    SkillData(assetPath: "assets/svg/androidStudio.svg", skillName: "Android Studio"),
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF000C18),
      body: Center(
        child: ScrollLoop(
          sourceList: mySkills,
        ),
      ),
    );
  }
}


class ScrollLoop extends StatefulWidget {
  final List<SkillData> sourceList;
  final double height;
  // final double cardWidth;
  final double scrollSpeed;
  final Duration initialDelay;
  final bool pauseOnHover;

  const ScrollLoop({
    Key? key,
    required this.sourceList,
    this.height = 150,
    // this.cardWidth = 150,
    this.scrollSpeed = 2, 
    this.initialDelay = const Duration(seconds: 1),
    this.pauseOnHover = true,
  }) : super(key: key);

  @override
  _ScrollLoopState createState() => _ScrollLoopState();
}

class _ScrollLoopState extends State<ScrollLoop> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.initialDelay, () {
      if (mounted) {
        _startScroll();
      }
    });
  }

  void _startScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (!_controller.hasClients) return;
      
      _controller.animateTo(
        _controller.position.pixels + widget.scrollSpeed,
        duration: const Duration(milliseconds: 20),
        curve: Curves.linear,
      );
    });
  }

  void _stopScroll() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: MouseRegion(
        onEnter: (_) {
          if (widget.pauseOnHover) _stopScroll();
        },
        onExit: (_) {
          if (widget.pauseOnHover) _startScroll();
        },
        child: Center(
          child: SizedBox(
            height: widget.height,
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: 100000, 
              itemBuilder: (context, index) {
                final skill = widget.sourceList[index % widget.sourceList.length];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    // width: widget.cardWidth,
                    child: CarouselCard(
                      assetPath: skill.assetPath,
                      skillName: skill.skillName,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
