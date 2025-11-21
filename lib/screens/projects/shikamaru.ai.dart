import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShikamaruAI extends StatefulWidget {
  const ShikamaruAI({super.key});

  @override
  State<ShikamaruAI> createState() => _ShikamaruAIState();
}

class _ShikamaruAIState extends State<ShikamaruAI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.pink, width: 2),
      ),
      child: Center(
        child: Text(
            "Under Construction",
            style: GoogleFonts.jetBrainsMono(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.pinkAccent
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
