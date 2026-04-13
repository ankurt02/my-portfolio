import 'package:ankur_portfolio/widgets/clock/current.time.dart';
import 'package:ankur_portfolio/widgets/clock/date.timec.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.height;

    double sWidth = 272;   

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF121212),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          // column - 2 - time and clob
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                height: 472,
                width: sWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          child: Image(image: NetworkImage("https://resume-hosting-f1c9d.web.app/background001.jpeg")),
                        ),
                      ),
                    ),

                    // for time and clock
                    Container(
                      // padding: EdgeInsets.only(top: 10),
                      // height: 1,
                      width: sWidth,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.red, width: 2),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                LiveClock(),
                                Text.rich(
                                  TextSpan(
                                    text: '+05:30 GMT, ', 
                                    style: GoogleFonts.jetBrainsMono(
                                    color: Colors.grey.shade800,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: 'India',
                                        style: GoogleFonts.jetBrainsMono(
                                    color: Colors.grey.shade800,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Spacer(),
                              DateContainer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
