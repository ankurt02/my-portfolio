import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(color: const Color(0xFF000C18)),
      height: screenHeight - 58,
      width: screenWidth * (1540 / 1920),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[          
          AnimatedTextKit(
            animatedTexts: [
              RotateAnimatedText('Hello', textStyle: TextStyle(
                color: Colors.grey.shade200, decoration: TextDecoration.none
              )),
              RotateAnimatedText('Namaste', textStyle: TextStyle(
                color: Colors.grey.shade200, fontFamily: 'Saman', decoration: TextDecoration.none
              )),
            ],
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}
