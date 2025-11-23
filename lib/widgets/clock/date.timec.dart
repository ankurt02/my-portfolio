import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current date
    DateTime now = DateTime.now();

    // Format weekday like Mon, Tue, Wed...
    String dayName = DateFormat('E').format(now); // 'E' gives short day
    // You can use 'EEEE' for full day like "Wednesday"

    // Get the day of month with suffix (1st, 2nd, 3rd, etc.)
    int dayNumber = now.day;
    String daySuffix = getDaySuffix(dayNumber);

    return Container(
      padding: EdgeInsets.all(8),
      // height: 120,
      // width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // color: Colors.white.withOpacity(0.9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Day of week
          Text(
            dayName,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade800,
            ),
          ),
          
          // Date of month with suffix
          Text(
            '$dayNumber$daySuffix',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 32,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to add suffix like 1st, 2nd, 3rd, 4th...
  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
