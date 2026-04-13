import 'package:ankur_portfolio/constants/constants.dart';
import 'package:ankur_portfolio/widgets/cards/researchPaper.card.dart';
import 'package:ankur_portfolio/widgets/tooltip/side.tooltip.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResearchPaperView extends StatefulWidget {
  const ResearchPaperView({super.key});

  @override
  State<ResearchPaperView> createState() => _ResearchPaperViewState();
}

Future<void> openLink(String link) async {
  final Uri url = Uri.parse(link);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}

class _ResearchPaperViewState extends State<ResearchPaperView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        spacing: 180,
        runSpacing: 60,
        children: [
          SideTooltip(
            message: "Published • Click to open",
            direction: TooltipDirection.top,
            child: Container(
              width: 396 / 1.35,
              height: 540 / 1.25,
              child: ResearchPaperCard(
                onTap: () {
                  openLink(Links.animeRecommendationIEEE_ICERECT);
                },
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
          ),
          SideTooltip(
            message: "Selected • Awaiting Publication",
            direction: TooltipDirection.top,
            child: Container(
              width: 396 / 1.35,
              height: 540 / 1.25,
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
          ),
        ],
      ),
    );
  }
}
