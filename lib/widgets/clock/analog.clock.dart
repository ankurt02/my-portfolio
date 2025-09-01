import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'clock.face.dart';
import 'dial.type.dart';
import 'face.type.dart';

class AnalogClock extends StatefulWidget {
  /// If null, default size = 30% of screen height
  final double? size;

  /// If null, uses system timezone
  final String? location;

  /// Background (transparent if not passed)
  final Color backgroundColor;
  final Gradient? backgroundGradient;
  final ImageProvider<Object>? backgroundImage;

  /// Hand colors
  final Color? hourHandColor;
  final Color? minuteHandColor;
  final Color? secondHandColor;

  /// Dial dash colors
  final Color? hourDashColor;
  final Color? minuteDashColor;

  /// Center dot color
  final Color? centerDotColor;

  /// Dial style
  final DialType dialType;

  /// Whether to show the second hand
  final bool showSecondHand;

  /// Number color
  final Color? numberColor;

  /// Hand extensions
  final bool? extendSecondHand;
  final bool? extendMinuteHand;
  final bool? extendHourHand;

  /// Update interval
  final Duration? updateInterval;

  /// Clock face type (circle/square)
  final FaceType faceType;
  final double borderRadius;
  final bool showHourDash;
  final bool showMinuteDash;
  final bool showDigitalClock;
  final String? locationDisplayName;

  const AnalogClock({
    super.key,
    this.size,
    this.backgroundColor = Colors.transparent,
    this.backgroundImage,
    this.backgroundGradient,
    this.hourHandColor,
    this.minuteHandColor,
    this.secondHandColor,
    this.hourDashColor,
    this.minuteDashColor,
    this.centerDotColor,
    this.location,
    this.dialType = DialType.dashes,
    this.showSecondHand = true,
    this.numberColor,
    this.extendMinuteHand,
    this.extendHourHand,
    this.extendSecondHand,
    this.updateInterval,
    this.faceType = FaceType.circle,

    this.borderRadius = 0.0,
    this.showHourDash = true,
    this.showMinuteDash = false,
    this.showDigitalClock = true,
    this.locationDisplayName,
  });

  @override
  State<AnalogClock> createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  Timer? timer;
  late ValueNotifier<DateTime> currentTime;

  DateTime get locationTime {
    if (widget.location != null) {
      var loc = tz.getLocation(widget.location!);
      return tz.TZDateTime.now(loc);
    }
    return DateTime.now();
  }

  void startClockTime() {
    timer = Timer.periodic(
      widget.updateInterval ??
          (widget.showSecondHand
              ? const Duration(milliseconds: 16)
              : const Duration(seconds: 2)),
      (_) => currentTime.value = locationTime,
    );
  }

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    currentTime = ValueNotifier(locationTime);
    startClockTime();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTime>(
      valueListenable: currentTime,
      builder: (context, value, child) {
        return Column(
          children: [
            ClockFace(
              showDigitalClock: true,
              faceType: widget.faceType,
              borderRadius: widget.borderRadius,
              showHourDash: widget.showHourDash,
              showMinuteDash: widget.showMinuteDash,
              clockSize:
                  widget.size ?? MediaQuery.of(context).size.height * 0.3,
              currentTime: value,

              // ✅ Provide defaults if null
              hourHandColor:
                  widget.hourHandColor ?? Theme.of(context).colorScheme.primary,
              minuteHandColor:
                  widget.minuteHandColor ??
                  Theme.of(context).colorScheme.primary,
              secondHandColor: widget.secondHandColor ?? Colors.red,
              centerDotColor:
                  widget.centerDotColor ??
                  Theme.of(context).colorScheme.primary,

              hourDashColor: widget.hourDashColor ?? Colors.black,
              minuteDashColor: widget.minuteDashColor ?? Colors.grey,
              numberColor: widget.numberColor ?? Colors.white,

              backgroundColor: widget.backgroundColor,
              backgroundGradient: widget.backgroundGradient,
              backgroundImage: widget.backgroundImage,
              dialType: widget.dialType,
              showSecondHand: widget.showSecondHand,
              extendSecondHand: widget.extendSecondHand ?? true,
              extendMinuteHand: widget.extendMinuteHand ?? false,
              extendHourHand: widget.extendHourHand ?? false,
            ),

            if (widget.locationDisplayName != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.locationDisplayName!,
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
