import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EncryptIt extends StatefulWidget {
  const EncryptIt({super.key});

  @override
  State<EncryptIt> createState() => _EncryptItState();
}

class _EncryptItState extends State<EncryptIt> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.pink, width: 2),
        color: const Color(0xFFE0E0E0)
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/lottie/BackendIcon02.json",
              height: 120,
              width: 120
            ),
            Gap(18),
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
      ),
    );
  }
}