import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:ankur_portfolio/models/editor.tab.dart';
import 'package:ankur_portfolio/widgets/cards/interests.cards.dart';
import 'package:ankur_portfolio/widgets/animations/scramble.text.dart';

class MiscellaneousScreen extends StatefulWidget {
  final void Function(EditorTab tab) onOpenTab;

  const MiscellaneousScreen({super.key, required this.onOpenTab});

  @override
  State<MiscellaneousScreen> createState() => _MiscellaneousScreenState();
}

class _MiscellaneousScreenState extends State<MiscellaneousScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24273A),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        // decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HackerTextEffect(
              text: 'Cache of Curiosities!',
              fontSize: 42,
              textColor: Colors.white,
            ),
            const Gap(16),

            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 8,
                childAspectRatio: 0.9,
                children: [
                  InfoCard(
                    imagePath: 'assets/images/anime01.jpg',
                    title: 'Anime',
                    description: 'My late-night watchlist of Anime',
                    gradientColors: [
                      // const Color.fromARGB(255, 250, 120, 163),
                      // Colors.pinkAccent,
                      // const Color.fromARGB(255, 236, 7, 179),
                      Colors.grey.shade800,
                      Colors.grey.shade800,
                    ],
                    onTap: () {},
                  ),
                  InfoCard(
                    imagePath: 'assets/images/movie.jpeg',
                    title: 'Movies',
                    description: 'Weekend escapes with Snacks and beverages.',
                    gradientColors: [
                      // Colors.orangeAccent, 
                      // Colors.redAccent,
                      Colors.grey.shade800,
                      Colors.grey.shade800,
                    ],
                    onTap: () {},
                  ),
                  InfoCard(
                    imagePath: 'assets/images/music02.jpeg',
                    title: 'Music',
                    description: '...',
                    gradientColors: [
                      // const Color.fromARGB(255, 5, 202, 126),
                      // const Color.fromARGB(255, 24, 193, 255),
                      Colors.grey.shade800,
                      Colors.grey.shade800,
                    ],
                    onTap: () {},
                  ),
                  InfoCard(
                    imagePath: 'assets/images/researchPaper02.png',
                    title: 'Research Papers',
                    description:
                        'Things I Googled too much — turned into research.',
                    gradientColors: [
                      // const Color.fromARGB(255, 96, 151, 247),
                      // const Color.fromARGB(255, 59, 92, 235),
                      // Colors.deepPurpleAccent,
                      // const Color.fromARGB(255, 84, 32, 225),
                      Colors.grey.shade800,
                      Colors.grey.shade800,
                    ],
                    onTap: () {
                      context.go('/misc/research');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
