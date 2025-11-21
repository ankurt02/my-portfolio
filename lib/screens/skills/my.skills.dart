import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orangeAccent, width: 2),
      ),
      child: Center(
        child: Text(
          "Under Construction",
          style: GoogleFonts.jetBrainsMono(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber
          ),
        ),
      ),
    );
    // Material(
    //   color: Color(0xFF000C18),
    //   child: Center(
    //     child: Text("Project page is Under Progress", style: TextStyle(color: Colors.white54)),
    //   ),
    // );
  }
}
