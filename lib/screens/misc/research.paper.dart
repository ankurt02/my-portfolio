import 'package:ankur_portfolio/widgets/cards/researchPaper.card.dart';
import 'package:flutter/material.dart';

class ResearchPaperView extends StatefulWidget {
  const ResearchPaperView({super.key});

  @override
  State<ResearchPaperView> createState() => _ResearchPaperViewState();
}

class _ResearchPaperViewState extends State<ResearchPaperView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        spacing: 60,
        runSpacing: 40,
        children: [
          Container(
            width: 396,
            height: 540,
            child: ResearchPaperCard(
              imagePath: "assets/images/gemini02.png",
              title:
                  "Anime Recommendations: Beyond Euclidean, Leveraging Distance Metrics for Better Suggestions",
              conference:
                  "5th International Conference on Emerging research in electronics, computer science and technology (ICERECT-2025) - IEEE",
              gradientColors: [
                Colors.grey.shade800,
                Colors.grey.shade500,
                Colors.grey.shade200,
              ],
            ),
          ),
          Container(
            width: 396,
            height: 540,
            child: ResearchPaperCard(
              imagePath: "assets/images/download.jpeg",
              title: "Content-Based Anime Recommendation Using BERT & TF-IDF",
              conference:
                  "International Conference on Grid and Parallel Computing (ICGPC-2025) - Springer",
              gradientColors: [
                Colors.grey.shade200,
                Colors.grey.shade800,
                Colors.grey.shade500,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
