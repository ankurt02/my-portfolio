import 'package:flutter/material.dart';

class AndroidDev42Gears extends StatefulWidget {
  const AndroidDev42Gears({super.key});

  @override
  State<AndroidDev42Gears> createState() => _AndroidDev42GearsState();
}

class _AndroidDev42GearsState extends State<AndroidDev42Gears> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.yellow,
          width: 2
        )
      ),

      child: Center(
        child: Text(
          "Working on it!",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),
        ),
      )
      // Column(
      //   children: [
      //     Container(
      //       height: 200,
      //       width: 200,
      //       decoration: BoxDecoration(
      //         border: Border.all(
      //           color: Colors.pink,
      //           width: 2
      //         )
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}