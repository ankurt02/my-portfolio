import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Needed for smooth infinite animation

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
          // 1. The Jellyfish/Streak Layer
          const Positioned.fill(
            child: JellyfishField(),
          ),
          
          // 2. Foreground Content
          Center(
            child: PointerInterceptor(
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
          ),
        ],
      ),
    );
  }
}

class PointerInterceptor extends StatelessWidget {
  final Widget child;
  const PointerInterceptor({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(child: child);
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
  
  // PHYSICS STATE
  Offset _targetMousePos = const Offset(-1000, -1000); 
  Offset _currentMousePos = const Offset(-1000, -1000); 
  
  late Ticker _ticker;
  double _time = 0.0;
  
  Size? _lastSize;

  final double _gridSpacing = 45.0; 
  final double _jitterAmount = 16.0; 

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        _time = elapsed.inMilliseconds / 1000.0;

        if (_currentMousePos != _targetMousePos) {
           double dist = (_currentMousePos - _targetMousePos).distance;
           if (dist > 0.5) {
             _currentMousePos = Offset.lerp(_currentMousePos, _targetMousePos, 0.15)!;
           } else {
             _currentMousePos = _targetMousePos;
           }
        }
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
        _initDots(Size(constraints.maxWidth, constraints.maxHeight));

        return MouseRegion(
          onHover: (event) {
            _targetMousePos = event.localPosition;
          },
          onExit: (event) {
             // Optional: drift away
          },
          child: CustomPaint(
            painter: JellyfishPainter(
              points: _dots, 
              mousePos: _currentMousePos, 
              time: _time
            ),
            size: Size.infinite,
          ),
        );
      },
    );
  }
}

class JellyfishPainter extends CustomPainter {
  final List<Offset> points;
  final Offset mousePos;
  final double time;

  JellyfishPainter({
    required this.points, 
    required this.mousePos, 
    required this.time
  });

  final double peakRadius = 210.0;   
  final double outerRadius = 520.0;  

  final double baseLength = 3.0;     
  final double baseWidth = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4285F4)
      ..strokeCap = StrokeCap.round;

    for (var origin in points) {
      // --- 1. FLUID JELLYFISH MOTION (Positional) ---
      // Keep this consistent regardless of distance
      double w1 = math.sin(time * 0.5 + (origin.dx * 0.01));
      double w2 = math.cos(time * 0.8 + (origin.dy * 0.015));
      
      double floatX = (w1 + w2) * 14.0; 
      double floatY = (math.cos(time * 0.5 + origin.dy * 0.01) + math.sin(time + origin.dx * 0.01)) * 14.0;
      
      Offset currentPos = origin + Offset(floatX, floatY);

      // --- 2. DYNAMIC SPEED LOGIC ---
      double dx = currentPos.dx - mousePos.dx;
      double dy = currentPos.dy - mousePos.dy;
      double dist = math.sqrt(dx * dx + dy * dy);

      if (dist > outerRadius) continue;

      // Calculate 'blend' factor (0.0 = near mouse, 1.0 = far boundary)
      double speedBlend = (dist / outerRadius).clamp(0.0, 1.0);

      // Create two independent waves:
      // 1. Slow Wave (Near): Frequency 1.5
      // 2. Fast Wave (Far):  Frequency 6.0
      double phase = (origin.dx * 0.02) + (origin.dy * 0.02);
      
      double slowPulse = math.sin(time * 1.0 + phase);
      double fastPulse = math.sin(time * 6.0 + phase);

      // Blend them based on distance
      // lerpDouble ensures smooth transition without strobing/phase-jumping
      double combinedPulse = (slowPulse * (1.0 - speedBlend)) + (fastPulse * speedBlend);

      // Apply the combined pulse to length multiplier
      // Ranges from ~0.8x to ~1.8x length
      double lenMult = 1.3 + (combinedPulse * 0.5); 

      // --- 3. DIMINISHING LOGIC ---
      double scaleFactor = 0.0;

      if (dist < peakRadius) {
        scaleFactor = dist / peakRadius; 
        scaleFactor = math.pow(scaleFactor, 1.5).toDouble();
      } else {
        scaleFactor = 1.0 - ((dist - peakRadius) / (outerRadius - peakRadius));
      }

      double actualLen = baseLength * lenMult * scaleFactor;
      double actualWidth = baseWidth * scaleFactor; 

      if (actualWidth < 0.4 || actualLen < 0.4) continue;

      paint.strokeWidth = actualWidth;

      // --- 4. REDUCED ROTATION (WOBBLE) ---
      double baseAngle = math.atan2(dy, dx);
      
      // Reduced from 0.35 to 0.12 (~7 degrees)
      // This is subtle but keeps it from looking stiff
      double wobble = math.sin(time * 3.0 + (origin.dy * 0.05)) * 0.12;
      
      double finalAngle = baseAngle + wobble;

      double cosA = math.cos(finalAngle);
      double sinA = math.sin(finalAngle);

      // --- 5. DRAW ---
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
           oldDelegate.mousePos != mousePos;
  }
}