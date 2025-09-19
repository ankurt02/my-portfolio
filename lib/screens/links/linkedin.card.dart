import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkedInCard extends StatelessWidget {
  final LinkedInProfile profile;
  const LinkedInCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return 
    // Card(
    //   elevation: 8,
    //   color: const Color(0xFF000C18),
    //   clipBehavior: Clip.antiAlias,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    //   child: Material(
    //     color: Colors.transparent,
    //     child: Container(
    //       padding: EdgeInsets.all(12),
    //       decoration: BoxDecoration(
    //         border: Border.all(color: Colors.pinkAccent, width: 2),
    //       ),
    //       child: LayoutBuilder(
    //         builder: (context, constraints) {
    //            return Column(
    //             children: [
    //               Container(
    //                 height: 200,
    //                 decoration: BoxDecoration(
    //                   border: Border.all(color: Colors.yellow, width: 3),
    //                 ),
    //               ),

    //               Gap(16),

    //               Container(
    //                 // container inkwell
    //                 width: constraints.maxWidth * 0.65,
    //                 decoration: BoxDecoration(
    //                   border: Border.all(color: Colors.green, width: 2),
    //                 ),
    //                 child: InkWell(
    //                   onTap: () => launchUrl(Uri.parse(profile.profileUrl)),
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(16.0),
    //                     child: Row(
    //                       children: [
    //                         CircleAvatar(
    //                           radius: 50,
    //                           backgroundImage: NetworkImage(
    //                             profile.profilePicUrl,
    //                           ),
    //                           backgroundColor: Colors.white,
    //                           onBackgroundImageError: (exception, stackTrace) {
    //                             print(exception);
    //                           },
    //                         ),
    //                         Gap(16),
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               profile.name,
    //                               style: const TextStyle(
    //                                 color: Colors.white,
    //                                 fontSize: 18,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                             Text(
    //                               '${profile.connections} connections',
    //                               style: const TextStyle(
    //                                 color: Colors.white70,
    //                                 fontSize: 14,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),

    //               Gap(16),

    //               Container(
    //                 height: 200,
    //                 decoration: BoxDecoration(
    //                   border: Border.all(color: Colors.yellow, width: 3),
    //                 ),
    //               ),
    //             ],
    //           );
    //         },
    //       ),
    //     ),
    //   ),
    // );
    Material(
      color: Color(0xFF000C18),
      child: Center(
        child: Text("Linkedin page is Under Progress", style: TextStyle(color: Colors.white54)),
      ),
    );
  }
}
