import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:flutter/material.dart';

class TwitterCard extends StatelessWidget {
  final XProfile profile;
  const TwitterCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return 
    // Card(
    //   elevation: 8,
    //   clipBehavior: Clip.antiAlias,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    //   child: Container(
    //     height: 120,
    //     child: Stack(
    //       children: [
    //         Positioned.fill(
    //           child: Image.network(
    //             profile.bannerUrl,
    //             fit: BoxFit.cover,
    //             errorBuilder: (context, error, stackTrace) => Container(color: Colors.blueGrey[900]),
    //           ),
    //         ),
    //         Container(
    //           decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //               colors: [Colors.black.withOpacity(0.8), Colors.black.withOpacity(0.2), Colors.transparent],
    //               stops: const [0.0, 0.7, 1.0],
    //               begin: Alignment.centerLeft,
    //               end: Alignment.centerRight,
    //             ),
    //           ),
    //         ),
    //         Positioned.fill(
    //           child: Material(
    //             color: Colors.transparent,
    //             child: InkWell(
    //               onTap: () => launchUrl(Uri.parse(profile.profileUrl)),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(16.0),
    //                 child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     CircleAvatar(
    //                       radius: 30,
    //                       backgroundImage: NetworkImage(profile.profilePicUrl),
    //                       backgroundColor: Colors.grey[700],
    //                     ),
    //                     const SizedBox(width: 16),
    //                     Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(profile.name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    //                         Text('@${profile.username}', style: const TextStyle(color: Colors.white70, fontSize: 14)),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    Material(
      color: Color(0xFF000C18),
      child: Center(
        child: Text("Twitter page is Under Progress", style: TextStyle(color: Colors.white54)),
      ),
    );
  }
}