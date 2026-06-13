import 'package:ankur_portfolio/widgets/bg/grid.painter.dart';
import 'package:ankur_portfolio/widgets/clock/current.time.dart';
import 'package:ankur_portfolio/widgets/clock/date.timec.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double sWidth = 272;

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Main dark background color
      body: Stack(
        children: [
          // LAYER 1: The Grid Background
          const Positioned.fill(
            child: CustomPaint(
              painter: GridBackgroundPainter(),
            ),
          ),
          
          // LAYER 2: Your Content
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  alignment: Alignment.center,
                  height: 172,
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212), // Gives the code container a solid back so grid lines don't slice through text
                    border: Border.all(color: const Color(0xFF24273A), width: 1.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, 
                    child: SelectableText.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Courier', 
                          fontSize: 14,
                          height: 1.25,
                        ),
                        children: [
                          const TextSpan(text: "1     ", style: TextStyle(color: Colors.grey)),
                          TextSpan(text: "const ", style: GoogleFonts.spaceMono(color: const Color(0xFFC6A0D7))),
                          TextSpan(text: "developer", style: GoogleFonts.spaceMono(color: const Color(0xFFE8B96B), fontStyle: FontStyle.italic)),
                          const TextSpan(text: " = ", style: TextStyle(color: Colors.white)),
                          const TextSpan(text: "{\n", style: TextStyle(color: Color(0xFFEE99A0))),
                          
                          const TextSpan(text: "2     ", style: TextStyle(color: Colors.grey)),
                          TextSpan(text: "\t\t\t\t\t\tname: ", style: GoogleFonts.spaceMono(color: const Color(0xFF8AADF4), fontStyle: FontStyle.italic)),
                          TextSpan(text: "'Ankur Tiwary',\n", style: GoogleFonts.spaceMono(color: const Color(0xFFA6DA95))),
                          
                          const TextSpan(text: "3     ", style: TextStyle(color: Colors.grey)),
                          TextSpan(text: "\t\t\t\t\t\tlocation: ", style: GoogleFonts.spaceMono(color: const Color(0xFF8AADF4), fontStyle: FontStyle.italic)),
                          TextSpan(text: "'India',\n", style: GoogleFonts.spaceMono(color: const Color(0xFFA6DA95))),
                          
                          const TextSpan(text: "4     ", style: TextStyle(color: Colors.grey)),
                          TextSpan(text: "\t\t\t\t\t\tstack: ", style: GoogleFonts.spaceMono(color: const Color(0xFF8AADF4), fontStyle: FontStyle.italic)),
                          TextSpan(text: "['Flutter', 'AI/ML', 'Python'],\n", style: GoogleFonts.spaceMono(color: const Color(0xFFA6DA95))),
                          
                          const TextSpan(text: "5     ", style: TextStyle(color: Colors.grey)),
                          TextSpan(text: "\t\t\t\t\t\tpassion: ", style: GoogleFonts.spaceMono(color: const Color(0xFF8AADF4), fontStyle: FontStyle.italic)),
                          TextSpan(text: "'Crafting seamless digital experiences',\n", style: GoogleFonts.spaceMono(color: const Color(0xFFA6DA95))),
                          
                          const TextSpan(text: "6     ", style: TextStyle(color: Colors.grey)),
                          TextSpan(text: "}\t;", style: TextStyle(color: const Color(0xFFEE99A0))),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}