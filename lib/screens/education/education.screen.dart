import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';


/// A model class to hold the data for each timeline event.
class TimelineEvent {
  final String year;
  final String number;
  final String title;
  final String description;
  final Color color;

  const TimelineEvent({
    required this.year,
    required this.number,
    required this.title,
    required this.description,
    required this.color,
  });
}

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  // A list of timeline events. This would typically come from an API or database.
  final List<TimelineEvent> _events = const [
    TimelineEvent(
      year: '2010',
      number: '',
      title: 'CBSE - X',
      description:
          'Kendriya Vidyalaya, AFS Borjhar, Guwahati\nPercentage : 89.4%',
      color: Colors.orange,
    ),
    
    TimelineEvent(
      year: '2020',
      number: '',
      title: 'CBSE - XII',
      description:
          'Kendriya Vidyalaya, AFS Borjhar, Guwahati\n(Science) Percentage : 80.0%',
      color: Colors.pink,
    ),
    TimelineEvent(
      year: '2025',
      number: '',
      title: 'B.E. Computer Science & Engineering',
      description:
          'Nitte Meenakshi Institute of Technology, Bangalore\nCGPA : 8.24',
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000C18),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'Education',
                textAlign: TextAlign.center,
                style: GoogleFonts.spaceMono(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 241, 241, 241),
                ),
              ),
            ),
            Expanded(
              // Using ListView.separated to easily add the connecting arrows
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  return TimelineItem(
                    event: _events[index],
                  );
                },
                separatorBuilder: (context, index) => const _Connector(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget that represents a single event in the timeline.
class TimelineItem extends StatelessWidget {
  final TimelineEvent event;

  const TimelineItem({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    // The overlapping number box, wrapped in a Stack to allow it to overflow.
    final numberBox = Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // This container reserves the vertical space in the Row for the card's height.
        Container(
          height: 60,
        ),
        // The actual colored number box is positioned to be vertically centered
        // and overflow the bounds of the card.
        Positioned(
          top: (60 - 130) / 2, // (cardHeight - boxHeight) / 2
          child: Container(
            height: 130, // Taller than the card to create the overlap
            width: 100,
            decoration: BoxDecoration(
              color: event.color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                event.number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    // The main card widget
    return Center(
      // Padding to ensure the overflowing box doesn't touch other items.
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Container(
          width: 550,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  event.year,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: event.color, // Year color matches the number box color
                  ),
                ),
              ),
              Gap(36),
              numberBox,
              Gap(48),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 8.0, 16.0, 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                    event.title,
                    style: GoogleFonts.roboto(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Gap(24),
                      Text(
                    event.description,
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A simple downward-pointing arrow to connect timeline items.
class _Connector extends StatelessWidget {
  const _Connector();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.grey.shade400,
        size: 36,
      ),
    );
  }
}

