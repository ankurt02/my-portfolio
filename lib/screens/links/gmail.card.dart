import 'package:flutter/material.dart';

class GmailCard extends StatelessWidget {
  const GmailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF000C18),
      child: Center(
        child: Text("Gmail page is Under Progress", style: TextStyle(color: Colors.white54)),
      ),
    );
  }
}