import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/widgets/buttons/linkedin.button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';



class LinkedInCard extends StatelessWidget {
  final LinkedInProfile profile;
  const LinkedInCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 12),
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     color: Colors.pink,
          //     width: 2
          //   )
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svg/linkedin.svg", height: 60,),
              Gap(6),
              Text(
                "Linkedin",
                style: GoogleFonts.ibmPlexMono(
                  fontSize: 42,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
        Gap(16),
        Container(
          margin: const EdgeInsets.only(top: 12, left: 72, right: 72, bottom: 24),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8.0),
            // border: Border.all(
            //   color: const Color.fromARGB(255, 156, 156, 156),
            //   width: 2
            // ),

            // Adding a subtle shadow to replicate the Card's elevation.
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bannerHeight = constraints.maxWidth / 4.0;
          
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderStack(bannerHeight: bannerHeight),
                  _buildInfoSection(),
                  // _buildButtonsSection(),
          
                ],
              );
            },
          ),
        ),
        Gap(12),
        LinkedinButton(text: 'Visit Profile', url: 'https://www.linkedin.com/in/ankur-tiwary-393479230/',),
        Spacer(),
      ],
    );
  }

  Widget _buildHeaderStack({required double bannerHeight}) {
    const double profileImageRadius = 92;

    return SizedBox(
      height: bannerHeight + profileImageRadius,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Banner Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: bannerHeight,
              child: Image.network(
                profile.bannerImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xff2d3b51),
                    child: const Center(
                      child: Text(
                        'Banner Image',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // 2. Profile Picture
          Positioned(
            left: 50,
            bottom: 0,
            child: CircleAvatar(
              radius: profileImageRadius + 4,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: profileImageRadius,
                backgroundImage: NetworkImage(profile.profileImageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the section with name, title, and location
  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8),
                  if (profile.isVerified)
                    Icon(Icons.verified, color: Colors.grey[600], size: 18),
                ],
              ),
              Gap(1),
              Text(
                profile.workingat,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Gap(4),
              Text(
                profile.location,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(8),
              Text(
                profile.connections,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xff0a66c2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Spacer(),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/42GearsLogo01.png",
                    height: 40,
                    fit: BoxFit.contain,
                    // Add this line
                    filterQuality: FilterQuality.high,
                  ),
                  Gap(6),
                  Text("Android Engineer @42Gears", style: GoogleFonts.robotoCondensed(
                    fontSize: 16, 
                    color: Colors.black87,
                    fontWeight: FontWeight.w500
                  ),),
                ],
              // ),
              // Gap(18),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Image.asset(
              //       "assets/images/image.png",
              //       height: 40,
              //       fit: BoxFit.contain,
              //       // Add this line
              //       filterQuality: FilterQuality.high,
              //     ),
              //     Gap(6),
              //     Text("Nitte Meenakshi Institute of\nTechnology", style: GoogleFonts.robotoCondensed(
              //       fontSize: 16, 
              //       color: Colors.black87,
              //       fontWeight: FontWeight.w500
              //     ),),
              //   ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Builds the row of action buttons
  // Widget _buildButtonsSection() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(40, 0, 40, 16),
  //     child: Wrap(
  //       spacing: 8.0,
  //       runSpacing: 8.0,
  //       children: [
  //         ElevatedButton(
  //           onPressed: () {},
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: const Color(0xff0a66c2),
  //             foregroundColor: Colors.white,
  //             shape: const StadiumBorder(),
  //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //           ),
  //           child: const Text('Open to', style: TextStyle(fontSize: 13)),
  //         ),
  //         OutlinedButton(
  //           onPressed: () {},
  //           style: OutlinedButton.styleFrom(
  //             foregroundColor: const Color(0xff0a66c2),
  //             side: const BorderSide(color: Color(0xff0a66c2), width: 1.5),
  //             shape: const StadiumBorder(),
  //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //           ),
  //           child: const Text(
  //             'Add profile section',
  //             style: TextStyle(fontSize: 13),
  //           ),
  //         ),
  //         OutlinedButton(
  //           onPressed: () {},
  //           style: OutlinedButton.styleFrom(
  //             foregroundColor: Colors.grey[700],
  //             side: BorderSide(color: Colors.grey[700]!, width: 1),
  //             shape: const StadiumBorder(),
  //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //           ),
  //           child: const Text('Resources', style: TextStyle(fontSize: 13)),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
