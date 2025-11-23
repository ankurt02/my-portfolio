import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  final double width;
  const BlurContainer({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        blendMode: BlendMode.srcIn,
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          width: width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.01),
            // borderRadius: BorderRadius.circular(12),
           
          ),
        ),
      ),
    );
  }
}
