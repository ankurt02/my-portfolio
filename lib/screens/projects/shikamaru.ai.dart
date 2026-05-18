import 'package:ankur_portfolio/constants/constants.dart';
import 'package:ankur_portfolio/widgets/buttons/gradient.button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ShikamaruAI extends StatefulWidget {
  const ShikamaruAI({super.key});

  @override
  State<ShikamaruAI> createState() => _ShikamaruAIState();
}

class _ShikamaruAIState extends State<ShikamaruAI> {
  final String _projectUrl = Links.shikamaruProjectLink;

  Future<void> _launchProjectUrl() async {
    if (!await launchUrl(Uri.parse(_projectUrl), mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_projectUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFE0E0E0),
      ),
      child: Column(
        children: [
          Gap(12),
          Text(
            "Shikamaru-Ai",
            style: GoogleFonts.ibmPlexMono(
              color: Colors.grey.shade800,
              fontSize: 36,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/lottie/BackendIcon02.json",
                height: 120,
                width: 120,
              ),
              const Gap(18),
              Text(
                "Crafting project showcase.",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // const Gap(64),
                Spacer(),
                Text(
                  "Explore the live project deployment:",
                  style: GoogleFonts.spaceMono(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                const Gap(8),
                GradientBorderButton(
                  title: "Try Live Demo",
                  icon: const Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: _launchProjectUrl,
                ),
                Gap(32)
              ],
            ),
          ),
        ],
      ),
    );
  }
}