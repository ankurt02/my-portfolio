import 'dart:math';
import 'package:ankur_portfolio/widgets/clock/dial.type.dart';
import 'package:ankur_portfolio/widgets/clock/face.type.dart';
import 'package:flutter/material.dart';

class ClockDashesPainter extends CustomPainter {
  final double clockSize;
  final Color? hourDashColor;
  final DialType dialType;
  final Color? minuteDashColor;
  final Color? numberColor;
  // NEW: The painter now knows about the face type
  final FaceType faceType;
  final bool showHourDash;
  final bool showMinuteDash;

  ClockDashesPainter({
    required this.clockSize,
    this.hourDashColor,
    this.minuteDashColor,
    required this.dialType,
    this.numberColor,
    // NEW: Added to the constructor
    required this.faceType,
    required this.showHourDash,
    required this.showMinuteDash,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        clockSize / 2; // This represents half the width of the square/circle

    // Helper function to get coordinates for either shape
    Offset getCoordinates(double angle, double r) {
      if (faceType == FaceType.circle) {
        // Original circular logic
        return Offset(center.dx + r * cos(angle), center.dy + r * sin(angle));
      } else {
        // NEW: Square logic
        // Project the circular point onto the square's perimeter
        final cosA = cos(angle);
        final sinA = sin(angle);
        final maxVal = max(cosA.abs(), sinA.abs());
        return Offset(
          center.dx + r * cosA / maxVal,
          center.dy + r * sinA / maxVal,
        );
      }
    }

    final double padding = clockSize / 20;
    final hourDashLength = clockSize / 20;
    final minuteDashLength = clockSize / 35;

    final hourPaint =
        Paint()
          ..color = hourDashColor ?? Colors.black
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 2.5;

    final minutePaint =
        Paint()
          ..color = minuteDashColor ?? Colors.grey
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1.5;

    // --- Draw Dashes ---
    if (dialType == DialType.dashes || dialType == DialType.numberAndDashes) {
      // Draw minute dashes
      if (showMinuteDash) {
        for (int i = 0; i < 60; i++) {
          // Only draw if it's not an hour mark
          if (i % 5 != 0) {
            final angle = 2 * pi * i / 60;
            final startPoint = getCoordinates(angle, radius - padding);
            final endPoint = getCoordinates(
              angle,
              radius - padding - minuteDashLength,
            );
            canvas.drawLine(startPoint, endPoint, minutePaint);
          }
        }
      }

      // Draw hour dashes
      if (showHourDash) {
        for (int i = 0; i < 12; i++) {
          // For numberAndDashes, skip the number positions
          if (dialType == DialType.numberAndDashes &&
              [0, 3, 6, 9].contains(i)) {
            continue;
          }
          final angle = 2 * pi * i / 12;
          final startPoint = getCoordinates(angle, radius - padding);
          final endPoint = getCoordinates(
            angle,
            radius - padding - hourDashLength,
          );
          canvas.drawLine(startPoint, endPoint, hourPaint);
        }
      }
    }

    // --- Draw Numbers ---
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    if (dialType == DialType.numbers ||
        dialType == DialType.numberAndDashes ||
        dialType == DialType.romanNumerals) {
      const romanNumerals = [
        'XII',
        'I',
        'II',
        'III',
        'IV',
        'V',
        'VI',
        'VII',
        'VIII',
        'IX',
        'X',
        'XI',
      ];

      for (int i = 0; i < 12; i++) {
        // Logic for which numbers to show
        if (dialType == DialType.numberAndDashes && ![0, 3, 6, 9].contains(i)) {
          continue;
        }

        String text;
        if (dialType == DialType.romanNumerals) {
          text = romanNumerals[i];
        } else {
          text = (i == 0 ? 12 : i).toString();
        }

        final angle = 2 * pi * (i - 3) / 12; // Angle adjusted for text rotation
        final textPosition = getCoordinates(
          angle,
          radius - hourDashLength * 1.2,
        );

        textPainter.text = TextSpan(
          text: text,
          style: TextStyle(
            fontSize: clockSize / 16,
            color: numberColor ?? Colors.white,
            fontWeight: FontWeight.w500,
          ),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            textPosition.dx - textPainter.width / 2,
            textPosition.dy - textPainter.height / 2,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
