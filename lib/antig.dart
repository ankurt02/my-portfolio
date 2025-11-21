import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MaterialApp(
    home: AntigravityJellyfishPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class AntigravityJellyfishPage extends StatelessWidget {
  const AntigravityJellyfishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. The Jellyfish Background Layer
          // We use Positioned.fill so it covers the whole screen area
          // The widget itself now centers the effect automatically.
          const Positioned.fill(
            child: JellyfishField(),
          ),
          
          // 2. Foreground Content (The Page)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.change_history, size: 28, color: Colors.grey[800]),
                    const SizedBox(width: 8),
                    Text(
                      "Google Antigravity",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Experience liftoff",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                    letterSpacing: -2.0,
                  ),
                ),
                const Text(
                  "with the next-generation IDE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF444444),
                    fontSize: 64,
                    fontWeight: FontWeight.w300, 
                    height: 1.1,
                    letterSpacing: -2.0,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.window, color: Colors.white, size: 22),
                      SizedBox(width: 12),
                      Text(
                        "Download for Windows",
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JellyfishField extends StatefulWidget {
  const JellyfishField({super.key});

  @override
  State<JellyfishField> createState() => _JellyfishFieldState();
}

class _JellyfishFieldState extends State<JellyfishField>
    with SingleTickerProviderStateMixin {
  List<Offset> _dots = [];
  
  late Ticker _ticker;
  double _time = 0.0;
  Size? _lastSize;

  // High density for visible border dots
  final double _gridSpacing = 36.0; 
  final double _jitterAmount = 12.0; 

  @override
  void initState() {
    super.initState();
    // Ticker is only needed for Time now, no mouse interpolation
    _ticker = createTicker((elapsed) {
      setState(() {
        _time = elapsed.inMilliseconds / 1000.0;
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _initDots(Size size) {
    if (_dots.isNotEmpty && _lastSize == size) return;
    _lastSize = size;
    _dots.clear();

    final random = math.Random(52); 

    int cols = (size.width / _gridSpacing).ceil() + 2;
    int rows = (size.height / _gridSpacing).ceil() + 2;

    for (int i = -1; i < cols; i++) {
      for (int j = -1; j < rows; j++) {
        double x = i * _gridSpacing;
        double y = j * _gridSpacing;

        x += (random.nextDouble() - 0.5) * 2 * _jitterAmount;
        y += (random.nextDouble() - 0.5) * 2 * _jitterAmount;

        _dots.add(Offset(x, y));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 1. Initialize Grid
        _initDots(Size(constraints.maxWidth, constraints.maxHeight));
        
        // 2. Calculate Center Fixed Position
        final center = Offset(constraints.maxWidth / 2, constraints.maxHeight / 2);

        // 3. Return Painter with fixed center (No MouseRegion)
        return CustomPaint(
          painter: JellyfishPainter(
            points: _dots, 
            centerPos: center, // Pass center instead of mouse
            time: _time
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class JellyfishPainter extends CustomPainter {
  final List<Offset> points;
  final Offset centerPos; // Renamed from mousePos for clarity
  final double time;

  JellyfishPainter({
    required this.points, 
    required this.centerPos, 
    required this.time
  });

  // ZONES (Scaled for screen fit + visual balance)
  final double centerZoneRadius = 75.0; 
  final double peakRadius = 160.0;       
  final double contractionRadius = 220.0; 
  final double outerRadius = 360.0;       

  final double baseLength = 5.0;     
  final double baseWidth = 3.5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4285F4)
      ..strokeCap = StrokeCap.round;

    for (var origin in points) {
      // --- 1. FLUID MOTION ---
      double w1 = math.sin(time * 0.5 + (origin.dx * 0.01));
      double w2 = math.cos(time * 0.8 + (origin.dy * 0.015));
      
      double floatX = (w1 + w2) * 14.0; 
      double floatY = (math.cos(time * 0.5 + origin.dy * 0.01) + math.sin(time + origin.dx * 0.01)) * 14.0;
      
      Offset currentPos = origin + Offset(floatX, floatY);

      // --- DISTANCE CHECK (From Center) ---
      double dx = currentPos.dx - centerPos.dx;
      double dy = currentPos.dy - centerPos.dy;
      double dist = math.sqrt(dx * dx + dy * dy);

      if (dist > outerRadius) continue;

      // --- 2. CENTER ZONE (SPARSITY LOGIC) ---
      if (dist < centerZoneRadius) {
        int hash = (origin.dx.toInt() ^ origin.dy.toInt());
        if ((hash % 10) > 2) {
           continue; 
        }
      }

      // --- 3. OUTER CONTRACTION ---
      if (dist > contractionRadius) {
        double angleToCenter = math.atan2(dy, dx);
        double outwardFactor = (dist - contractionRadius) / (outerRadius - contractionRadius);
        
        double swimCycle = math.sin(time * 2.0 + (origin.dy * 0.05));
        
        // Strong pull (220.0) so dots clearly move inward at borders
        double pullAmount = 220.0 * outwardFactor * swimCycle; 
        
        currentPos -= Offset(
          math.cos(angleToCenter) * pullAmount,
          math.sin(angleToCenter) * pullAmount
        );
      }

      // --- 4. DYNAMIC PULSE ---
      double speedBlend = (dist / outerRadius).clamp(0.0, 1.0);
      double phase = (origin.dx * 0.02) + (origin.dy * 0.02);
      double combinedPulse = (math.sin(time * 1.5 + phase) * (1.0 - speedBlend)) + 
                             (math.sin(time * 6.0 + phase) * speedBlend);
      double lenMult = 1.3 + (combinedPulse * 0.5); 

      // --- 5. DIMINISHING & SHAPE ---
      double scaleFactor = 1.0;
      double actualLen = baseLength;

      if (dist < centerZoneRadius) {
        actualLen = 0.1; 
        scaleFactor = 0.6; 
        
      } else if (dist < peakRadius) {
        double t = (dist - centerZoneRadius) / (peakRadius - centerZoneRadius);
        t = t * t * (3 - 2 * t); 
        actualLen = 0.1 + (baseLength * lenMult * t);
        scaleFactor = 0.6 + (0.4 * t); 
        
      } else if (dist > contractionRadius) {
        scaleFactor = 1.0 - ((dist - contractionRadius) / (outerRadius - contractionRadius));
        actualLen = baseLength * lenMult * scaleFactor;
      } else {
        actualLen = baseLength * lenMult;
      }

      double actualWidth = baseWidth * scaleFactor; 

      if (actualWidth < 0.5) continue;

      paint.strokeWidth = actualWidth;

      // --- 6. WOBBLE ---
      double baseAngle = math.atan2(dy, dx);
      double wobble = math.sin(time * 3.0 + (origin.dy * 0.05)) * 0.12;
      double finalAngle = baseAngle + wobble;

      double cosA = math.cos(finalAngle);
      double sinA = math.sin(finalAngle);

      // --- 7. DRAW ---
      Offset start = Offset(
        currentPos.dx - (cosA * actualLen * 0.5),
        currentPos.dy - (sinA * actualLen * 0.5),
      );
      Offset end = Offset(
        currentPos.dx + (cosA * actualLen * 0.5),
        currentPos.dy + (sinA * actualLen * 0.5),
      );

      paint.color = const Color(0xFF4285F4).withOpacity((scaleFactor * 0.9).clamp(0.0, 1.0));
      
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant JellyfishPainter oldDelegate) {
    return oldDelegate.time != time ||
           oldDelegate.centerPos != centerPos;
  }
}