import 'package:flutter/material.dart';

enum ProjectStatus {
  completed,
  inProgress,
  production,
  archived,
}

class ProjectCards extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final List<String> techStack;
  final ProjectStatus status;
  final String projectUrl;

  const ProjectCards({
    super.key,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.techStack,
    required this.status,
    required this.projectUrl,
  });

  Color getStatusColor() {
    switch (status) {
      case ProjectStatus.production:
        return Colors.green;
      case ProjectStatus.inProgress:
        return Colors.orange;
      case ProjectStatus.completed:
        return Colors.blue;
      case ProjectStatus.archived:
        return Colors.grey;
    }
  }

  String getStatusText() {
    switch (status) {
      case ProjectStatus.production:
        return "Production";
      case ProjectStatus.inProgress:
        return "In Progress";
      case ProjectStatus.completed:
        return "Completed";
      case ProjectStatus.archived:
        return "Archived";
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          height: 240,
          width: constraints.maxWidth * 0.65,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orangeAccent),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageUrl,
                  width: 220,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const Spacer(),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: techStack.map((tech) {
                        return Chip(
                          label: Text(tech),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: getStatusColor().withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            getStatusText(),
                            style: TextStyle(
                              color: getStatusColor(),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const Spacer(),

                        IconButton(
                          onPressed: () {
                            // launchUrl(...)
                          },
                          icon: const Icon(Icons.open_in_new),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}