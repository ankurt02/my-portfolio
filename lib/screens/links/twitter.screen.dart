import 'package:ankur_portfolio/constants/constants.dart';
import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/widgets/buttons/gradient.button.dart';
import 'package:ankur_portfolio/widgets/tooltip/side.tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class TwitterCard extends StatelessWidget {
  final XProfile profile;
  const TwitterCard({super.key, required this.profile});

  final String _twitterProfileLink = Links.twitterProfileLink;

  Future<void> _launchXUrl() async {
    if (!await launchUrl(
      Uri.parse(_twitterProfileLink),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $_twitterProfileLink');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final editorAreaHeight = constraints.maxHeight;
        final editorAreaWidth = constraints.maxWidth;

        return Material(
          color: Color(0xFF000C18),
          // child: Center(
          //   child: Text("Twitter page is Under Progress", style: TextStyle(color: Colors.white54)),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(12),
              Container(
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.orange,
                //     width: 2
                //   )
                // ),
                child: 
                    SvgPicture.asset('assets/svg/twitter_org.svg', height: 80),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 90),
                height: editorAreaHeight / 2.75,
                width: editorAreaWidth / 1.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF002549), width: 2),
                  borderRadius: BorderRadius.circular(600),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SideTooltip(
                      message: "@_ankur2_",
                      direction: TooltipDirection.bottom,
                      child: GestureDetector(
                        onTap: _launchXUrl,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 36),
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF002549),
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.network(
                              "https://resume-hosting-f1c9d.web.app/fil_bangalore_blue_bg.jpg",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Gap(6),
                    Container(
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: Colors.pink),
                      // ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.blue),
                            // ),
                            child: Text(
                              "at",
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Gap(6),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.red),
                            // ),
                            child: Text(
                              "@_ankur2_",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    SideTooltip(
                      message: "Open X (formerly twitter)",
                      child: GradientBorderButton(
                        title: "Connect on ",
                        icon: SvgPicture.asset(
                          'assets/svg/twitter-xbg.svg',
                          height: 24,
                          width: 24,
                        ),
                        onTap: _launchXUrl,
                      ),
                    ),
                    Gap(64),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
