import 'package:ankur_portfolio/widgets/cards/project.cards.dart';
import 'package:flutter/material.dart';

class ProjectsJsonScreen extends StatefulWidget {
  const ProjectsJsonScreen({super.key});

  @override
  State<ProjectsJsonScreen> createState() => _ProjectsJsonScreenState();
}

class _ProjectsJsonScreenState extends State<ProjectsJsonScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.pink, width: 2),
        color: const Color(0xFF24273A),
      ),
      child: Column(
        children: [
          ProjectCards(
            name: "ShikamaruAI",
            description: "To find realted anime",
            imageUrl: "assets/images/download (5).jpeg",
            status: ProjectStatus.production,
            techStack: ['Flutter', 'Python', 'AI/ML'],
            projectUrl: "https://ankurt02.github.io/flutter_anime_recom/",
          ),
          // ProjectCards()
        ],
      ),
    );
  }
}
