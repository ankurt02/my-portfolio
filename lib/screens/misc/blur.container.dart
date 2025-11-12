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
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.02),
            // borderRadius: BorderRadius.circular(12),
           
          ),
        ),
      ),
    );
  }
}
