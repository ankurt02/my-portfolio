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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double sWidth = 272;

    // final now = DateTime.now();
    // String suffix = 'th';
    // int day = now.day;
    // if (day % 10 == 1 && day != 11) suffix = 'st';
    // else if (day % 10 == 2 && day != 12) suffix = 'nd';
    // else if (day % 10 == 3 && day != 13) suffix = 'rd';
    // // Format: "25th Nov, 25"
    // String formattedDate = "${day}${suffix} ${DateFormat('MMM, yy').format(now)}";
   

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF121212),
        // image: DecorationImage(
        //   image: AssetImage("assets/images/gemini01.png"),
        //   fit: BoxFit.cover, // optional but recommended
        // ),
        // border: Border.all(color: Colors.yellow, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // column-1
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // moon container
              // Container(
              //   height: 472,
              //   width: sWidth,
              //   decoration: BoxDecoration(
              //     // border: Border.all(color: Colors.pink, width: 2),
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Column(
              //     children: [
                    
              //       MoonWidget(width: sWidth),
              //       // Spacer(),
              //       Container(
              //         // height: 120,
              //         width: sWidth,
              //         // decoration: BoxDecoration(
              //         //   border: Border.all(
              //         //     color: Colors.yellow,
              //         //     width: 2
              //         //   )
              //         // ),
              //         child:
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Moon as on",
              //               style: GoogleFonts.jetBrainsMono(
              //                 color: Colors.grey.shade600,
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.bold
              //               )
              //             ),
              //             Text(
              //               "$formattedDate",
              //               style: GoogleFonts.jetBrainsMono(
              //                 color: Colors.grey.shade300,
              //                 fontSize: 24,
              //                 fontWeight: FontWeight.bold
              //               )
              //             ),
              //             Row(
              //               children: [
              //                 Spacer(),
              //                 Text(
              //                   "- Kolkata, India",
              //                   style: GoogleFonts.jetBrainsMono(
              //                 color: Colors.grey.shade300,
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.bold
              //               )
              //                 )
              //               ],
              //             )
              //           ],
              //         )
                      //  Text.rich(
                      //   TextSpan(children: [
                      //     TextSpan(
                      //       text: "Moon as on\n",
                      //       style: GoogleFonts.jetBrainsMono(
                      //         color: Colors.grey.shade600,
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.bold
                      //       )
                      //     ),
                      //     TextSpan(
                      //       text: "$formattedDate\n",
                      //       style: GoogleFonts.jetBrainsMono(
                      //         color: Colors.grey.shade400,
                      //         fontSize: 24,
                      //         fontWeight: FontWeight.w800,
                      //       )
                      //     ),
                      //     TextSpan(
                      //       text: "- Kolkata",
                      //       style: GoogleFonts.jetBrainsMono(
                      //         color: Colors.grey.shade400,
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w800,
                      //       )
                      //     )
                      //   ])
                      // ),
              //       ),

              //     ],
              //   ),
              // ),

              // Gap(12),

              // Container(
              //   height: 120,
              //   width: sWidth,
              //   decoration: BoxDecoration(
              //     // border: Border.all(color: Colors.green, width: 2),
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              // ),
            ],
          ),

          // Gap(64),

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
                          child: Image.asset("assets/images/download (1).jpeg"),
                        ),
                      ),
                    ),
                    // Center(
                    //   child: Container(
                    //     height: 180,
                    //     width: 180,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(100),
                    //       gradient: LinearGradient(
                    //         begin: Alignment.topLeft,
                    //         end: Alignment.bottomRight,
                    //         colors: [
                    //           const Color.fromARGB(255, 246, 174, 79),
                    //           const Color.fromARGB(255, 251, 105, 60),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // BlurContainer(width: sWidth),
                    // Container(width: sWidth).blurry(
                    //   blur: 12,
                    //   width: 120,
                    //   elevation: 0,
                    //   color: Colors.white.withOpacity(0.4),
                    //   padding: const EdgeInsets.all(8),
                    //   borderRadius: const BorderRadius.all(Radius.circular(16)),
                    // ),

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
                            // height: 120,
                            // width: sWidth ,
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            // color: Colors.yellow,
                            //     width: 2,
                            //   ),
                            // ),
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
                                // Spacer()

                                // Text(
                                //   "India",
                                  // style: GoogleFonts.jetBrainsMono(
                                  //   color: Colors.grey.shade800,
                                  //   fontSize: 16,
                                  //   fontWeight: FontWeight.bold,
                                  // ),
                                // ),
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
                          // Spacer(),
                          // Container(
                          //   height: 120,
                          //   width: sWidth / 2,
                          //   // decoration: BoxDecoration(
                          //   //   border: Border.all(
                          //   //     color: Colors.purple,
                          //   //     width: 2,
                          //   //   ),
                          //   // ),
                          //   child: Text("Ankur"),
                          // ),
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
