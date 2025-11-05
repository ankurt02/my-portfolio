import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class TimelineEvent {
  final String year;
  final String title;
  final String description;
  final Color color;

  const TimelineEvent({
    required this.year,
    required this.title,
    required this.description,
    required this.color,
  });
}

class TimelineScreen extends StatefulWidget {
  
  const TimelineScreen({super.key});
  
  static const List<TimelineEvent> _events = [
    TimelineEvent(
      year: '2025',
      title: 'B.E. Computer Science & Engineering',
      description: 'Nitte Meenakshi Institute of Technology, Bangalore\nCGPA : 8.24',
      color: Colors.purple,
    ),
    TimelineEvent(
      year: '2020',
      title: 'CBSE - XII, AISSCE',
      description: 'Kendriya Vidyalaya, AFS Borjhar, Guwahati\n(Science) Percentage : 80.0%',
      color: Colors.pink,
    ),
    TimelineEvent(
      year: '2018',
      title: 'CBSE - X, AISSE',
      description: 'Kendriya Vidyalaya, AFS Borjhar, Guwahati\nPercentage : 89.4%',
      color: Colors.orange,
    ),
  ];

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  
  /// Builds the continuous timeline graphic in the background.
  Widget _buildContinuousTimeline() {
    final screenHeight = MediaQuery.of(context).size.height;
    const double lineWidth = 3.0;
    
    // List of colors for the gradient line
    final List<Color> gradientColors = [
      const Color.fromARGB(255, 18, 15, 114),
      const Color.fromARGB(255, 89, 42, 155),
      const Color(0xFFC7579C),
      const Color(0xFFEDDD53),
    ];

    return Center(
      child: Container(
        width: lineWidth,
        height: screenHeight*0.75,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000C18),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
              child: Text(
                'Education',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),

            // Timeline Section
            Expanded(
              child: Stack(
                children: [
                  // The continuous timeline line in the background.
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: _buildContinuousTimeline(),
                  ),

                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        for (int index = 0; index < TimelineScreen._events.length; index++)
                          TimelineItem(
                            event: TimelineScreen._events[index],
                            isLeftAligned: index.isEven,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class TimelineItem extends StatelessWidget {
  final TimelineEvent event;
  final bool isLeftAligned;

  const TimelineItem({
    super.key,
    required this.event,
    required this.isLeftAligned,
  });

  Widget _buildTimelineDot(double circleRadius) {
    return Container(
      width: circleRadius * 1.5,
      height: circleRadius * 1.5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: event.color, // the Dot color now matches the card's color
        boxShadow: [
          BoxShadow(
            color: event.color.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double circleRadius = 8.0;
    const double cardPadding = 12.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Pane
          Expanded(
            child: isLeftAligned
                ? Align(
                    alignment: Alignment.centerRight,
                    child: EventCard(event: event, isLeftAligned: isLeftAligned),
                  )
                : const SizedBox(),
          ),

          // central gutter with the dot
          const Gap(cardPadding),
          _buildTimelineDot(circleRadius),
          const Gap(cardPadding),

          // Right Pane
          Expanded(
            child: !isLeftAligned
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: EventCard(event: event, isLeftAligned: isLeftAligned),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final TimelineEvent event;
  final bool isLeftAligned;

  const EventCard({
    super.key,
    required this.event,
    required this.isLeftAligned,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final colorBox = Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(height: 60),
        Positioned(
          top: (60 - screenHeight/6) / 2, // (cardHeight - boxHeight) / 2
          child: Container(
            height: screenHeight/6,
            width: 16, // colored-box width
            decoration: BoxDecoration(
              color: event.color,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );

    final cardContent = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.year,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: event.color,
              ),
            ),
            const Gap(8),
            Text(
              event.title,
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(8),
            Text(
              event.description,
              style: GoogleFonts.spaceGrotesk(
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );

    // The main card widget
    return Container(
      width: screenWidth/4, // card width
      height: screenHeight/5,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: isLeftAligned
            ? [
                colorBox,
                const Gap(30),
                cardContent,
              ]
            : [
                const Gap(30),
                cardContent,
                colorBox,
              ],
      ),
    );
  }
}

