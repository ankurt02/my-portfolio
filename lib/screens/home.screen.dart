import 'package:ankur_portfolio/widgets/bg/grid.painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

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
            child: CustomPaint(painter: GridBackgroundPainter()),
          ),

          // LAYER 2: Your Content
          Positioned.fill(
            top: -100,
            left: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF22C55E).withOpacity(0.25),
                            ),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF22C55E),
                            ),
                          ),
                        ],
                      ),
                      Gap(12),
                      Text(
                        "Available for new opportunites",
                        style: GoogleFonts.robotoMono(color: Colors.grey),
                      ),
                      Gap(24),
                      Container(
                        height: 3,
                        width: 3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                      Gap(24),
                      Icon(
                        Icons.location_on_outlined,
                        size: 24,
                        color: Colors.grey,
                      ),
                      Gap(12),
                      Text(
                        "India - Remote",
                        style: GoogleFonts.robotoMono(color: Colors.grey),
                      ),
                    ],
                  ),
                  Gap(24),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.pinkAccent),
                    // ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(wordSpacing: 0.75),
                        children: [
                          TextSpan(
                            text: "Hello,\t",
                            style: GoogleFonts.spaceMono(
                              color: Colors.grey.shade400,
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: "I'm\t",
                            style: GoogleFonts.spaceMono(
                              color: Colors.grey.shade400,
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: "Ankur Tiwary",
                            style: GoogleFonts.spaceMono(
                              color: const Color(0xFF8AADF4),
                              fontSize: 56,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ".",
                            style: GoogleFonts.spaceMono(
                              color: Colors.grey.shade400,
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.pinkAccent),
                    // ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(wordSpacing: 0.75),
                        children: [
                          TextSpan(
                            text: "//\t",
                            style: GoogleFonts.spaceMono(
                              color: Colors.green,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: "Software Developer",
                            style: GoogleFonts.spaceMono(
                              color: Colors.grey.shade400,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Gap(24),

                  // Container info
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        height: 220,
                        width: constraints.maxWidth * 0.75,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF121212,
                          ), // Gives the code container a solid back so grid lines don't slice through text
                          border: Border.all(
                            color: const Color(0xFF24273A),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 12,
                                        width: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xFFFF605C)
                                        ),
                                      ),
                                      Gap(4),
                                      Container(
                                        height: 12,
                                        width: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xFFFFBD44)
                                        ),
                                      ),
                                      Gap(4),
                                      Container(
                                        height: 12,
                                        width: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xFF00CA4E)
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),

                                SvgPicture.asset(
                                  'assets/svg/light-json-svgrepo-com-01.svg',
                                  height: 20,
                                ),
                                Gap(6),
                                Text(
                                  "hello.json",
                                  style: GoogleFonts.jetBrainsMono(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                Spacer()
                                
                            ],
                            ),
                            Gap(22),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SelectableText.rich(
                                TextSpan(
                                  style: const TextStyle(
                                    fontFamily: 'Courier',
                                    fontSize: 16,
                                    height: 1.25,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: "1     ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: "const ",
                                      style: GoogleFonts.spaceMono(
                                        color: const Color(0xFFC6A0D7),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "developer",
                                      style: GoogleFonts.spaceMono(
                                        color: const Color(0xFFE8B96B),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: " = ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const TextSpan(
                                      text: "{\n",
                                      style: TextStyle(
                                        color: Color(0xFFEE99A0),
                                      ),
                                    ),

                                    const TextSpan(
                                      text: "2     ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: "\t\t\t\t\t\tname: ",
                                      style: GoogleFonts.spaceMono(
                                        color: const Color(0xFF8AADF4),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "'Ankur Tiwary',\n",
                                      style: GoogleFonts.spaceMono(
                                        color: const Color(0xFFA6DA95),
                                      ),
                                    ),

                                    const TextSpan(
                                      text: "3     ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: "\t\t\t\t\t\tlocation: ",
                                      style: GoogleFonts.spaceMono(
                                        color: const Color(0xFF8AADF4),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "'India',\n",
                                      style: GoogleFonts.spaceMono(
                                        color: const Color(0xFFA6DA95),
                                      ),
                                    ),

                                    const TextSpan(
                                      text: "4     ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: "\t\t\t\t\t\tstack: ",
                                      style: GoogleFonts.spaceMono(
                                        color: const Color(0xFF8AADF4),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "['Flutter', 'AI/ML', 'Python'],\n",
                                      style: GoogleFonts.spaceMono(
                                        color: const Color(0xFFA6DA95),
                                      ),
                                    ),

                                    const TextSpan(
                                      text: "5     ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: "\t\t\t\t\t\tpassion: ",
                                      style: GoogleFonts.spaceMono(
                                        color: const Color(0xFF8AADF4),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "'Crafting seamless digital experiences',\n",
                                      style: GoogleFonts.spaceMono(
                                        color: const Color(0xFFA6DA95),
                                      ),
                                    ),

                                    const TextSpan(
                                      text: "6     ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: "}\t;",
                                      style: TextStyle(
                                        color: const Color(0xFFEE99A0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Gap(32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
