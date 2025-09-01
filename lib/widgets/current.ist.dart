import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class CurrentIST extends StatefulWidget {
  const CurrentIST({super.key});

  @override
  State<CurrentIST> createState() => _CurrentISTState();
}

class _CurrentISTState extends State<CurrentIST> {
  @override
  void initState() {
    super.initState();
    // This should ideally be called once in your main() function,
    // but it's safe to have here as a fallback.
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    // 1. We create the Card structure here
    return Card(
      elevation: 8.0,
      color: const Color(0xFF2D2F31), // A dark charcoal color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
        // Use a Column to stack the clock and the location text
        child: Column(
          mainAxisSize: MainAxisSize.min, // Make the card wrap its content
          children: [
            // The real-time clock widget goes here
            const RealTimeClock(timeZoneName: 'Asia/Kolkata'),
            const SizedBox(height: 16), // Spacing
            // The static location text
            Text(
              'India',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RealTimeClock extends StatefulWidget {
  final String timeZoneName;

  const RealTimeClock({super.key, required this.timeZoneName});

  @override
  State<RealTimeClock> createState() => _RealTimeClockState();
}

class _RealTimeClockState extends State<RealTimeClock> {
  late Timer _timer;
  late tz.Location _location;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _location = tz.getLocation(widget.timeZoneName);
    _currentTime = tz.TZDateTime.now(_location);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = tz.TZDateTime.now(_location);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 2. We change the format and styling to match the watch face
    String dayOfWeek = DateFormat('E').format(_currentTime).toUpperCase(); // "MON"
    String time = DateFormat('h:mm a').format(_currentTime); // "5:52 PM"

    // Use a Row to place the day and time side-by-side
    return Row(
      mainAxisSize: MainAxisSize.min, // Make the Row wrap its content
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          dayOfWeek,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 16), // Spacing between day and time
        Text(
          time,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}