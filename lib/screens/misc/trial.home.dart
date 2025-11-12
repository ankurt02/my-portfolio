import 'dart:math';
import 'dart:ui';

import 'package:ankur_portfolio/screens/misc/blur.container.dart';
import 'package:ankur_portfolio/widgets/clock/current.time.dart';
import 'package:ankur_portfolio/widgets/clock/date.timec.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glass/glass.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

class TrialHomeScreen extends StatefulWidget {
  const TrialHomeScreen({super.key});

  @override
  State<TrialHomeScreen> createState() => _TrialHomeScreenState();
}

class _TrialHomeScreenState extends State<TrialHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double sWidth = 280;

    return Container(
      decoration: BoxDecoration(
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
              Container(
                height: 340,
                width: sWidth,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.pink, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),

              Gap(12),

              Container(
                height: 120,
                width: sWidth,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ],
          ),

          Gap(16),

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
                    Center(
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color.fromARGB(255, 246, 174, 79),
                              const Color.fromARGB(255, 251, 105, 60),
                            ],
                          ),
                        ),
                      ),
                    ),

                    BlurContainer(width: sWidth / 2),
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
                      width: sWidth / 2,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.red, width: 2),
                      ),
                      child: Column(
                        children: [
                          DateContainer(),
                          Spacer(),
                          Container(
                            height: 120,
                            width: sWidth / 2,
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                                // color: Colors.yellow,
                            //     width: 2,
                            //   ),
                            // ),
                            child: Center(
                              child: LiveClock(),
                            ),
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
