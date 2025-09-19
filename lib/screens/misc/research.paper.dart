import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ResearchPaperView extends StatefulWidget {
  const ResearchPaperView({super.key});

  @override
  State<ResearchPaperView> createState() => _ResearchPaperViewState();
}

class _ResearchPaperViewState extends State<ResearchPaperView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 30, left: 20),
      // decoration: BoxDecoration(
      //   // color: Colors.white,
      //   border: Border.all(color: Colors.pink, width: 2),
      // ),
      child: Column(
        children: [
          Gap(24),
          Text("Research papers",
            style: GoogleFonts.gideonRoman(
              fontSize: 54,
              color: Colors.white,
            ),
          ),
          Gap(36),
          Container(
            // height: 220,
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 105, 105, 105), width: 1), borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              children: [
                Text("Content-Based Anime Recommendation Using BERT & TF-IDF",
                textAlign: TextAlign.start,
                  style: GoogleFonts.gideonRoman(
                    fontSize: 24,
                    color: Colors.grey.shade200
                  ),
                ),

                Gap(12),

                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child : Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey,
                          )
                        ),
                        child: Text(
                          "View Paper ->",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Gap(24)
                  ],
                ),
              ],
            ),
          ),

          Gap(24),

          Container(
            // height: 220,
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 105, 105, 105), width: 1), borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              children: [
                Text("Anime Recommendation : Beyond Euclidean, Leveraging Distance Metrices for Better Suggestions",
                textAlign: TextAlign.start,
                  style: GoogleFonts.gideonRoman(
                    fontSize: 24,
                    color: Colors.grey.shade200
                  ),
                ),

                Gap(12),

                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child : Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey,
                          )
                        ),
                        child: Text(
                          "View Paper ->",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Gap(24)
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
