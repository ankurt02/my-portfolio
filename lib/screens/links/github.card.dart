import 'package:ankur_portfolio/screens/links/socials.dart';
import 'package:ankur_portfolio/widgets/animations/scramble.text.dart';
import 'package:ankur_portfolio/widgets/buttons/github.button.dart';
import 'package:ankur_portfolio/widgets/carousel/auto.carousel.dart';
import 'package:ankur_portfolio/widgets/heatmap/heatmap.design.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContributionData {
  final Map<DateTime, int> datasets;
  final int totalContributions;

  ContributionData({required this.datasets, required this.totalContributions});
}

class GitHubCard extends StatefulWidget {
  final GitHubProfile profile;
  const GitHubCard({super.key, required this.profile});

  @override
  State<GitHubCard> createState() => _GitHubCardState();
}

class _GitHubCardState extends State<GitHubCard> {
  late Future<ContributionData> _contributionData;

  
  // This reads the variable passed in by --dart-define=TOKEN_GITHUB=...
final String githubToken = const String.fromEnvironment('TOKEN_GITHUB');

  @override
  void initState() {
    super.initState();
    _contributionData = _fetchContributionData();
  }

  /// Fetches contribution data for the current year from the GitHub GraphQL API.
  Future<ContributionData> _fetchContributionData() async {
    if (githubToken.isEmpty) {
    throw Exception('Failed to load contribution data: The TOKEN_GITHUB was not provided during the build process.');
  }
    final now = DateTime.now();
    final startDate = DateTime(now.year, 1, 1);
    final endDate = DateTime(now.year, 12, 31);

    final String query = """
      query(\$from: DateTime!, \$to: DateTime!) {
        viewer {
          contributionsCollection(from: \$from, to: \$to) {
            contributionCalendar {
              totalContributions
              weeks {
                contributionDays {
                  contributionCount
                  date
                }
              }
            }
          }
        }
      }
    """;

    final response = await http.post(
      Uri.parse('https://api.github.com/graphql'),
      headers: {
        'Authorization': 'Bearer $githubToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'query': query,
        'variables': {
          'from': startDate.toIso8601String(),
          'to': endDate.toIso8601String(),
        },
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final calendar =
          data['data']['viewer']['contributionsCollection']['contributionCalendar'];
      final weeks = calendar['weeks'];
      final totalContributions = calendar['totalContributions'];
      final Map<DateTime, int> datasets = {};

      for (var week in weeks) {
        for (var day in week['contributionDays']) {
          final date = DateTime.parse(day['date']);
          final count = day['contributionCount'];
          datasets[date] = count;
        }
      }
      return ContributionData(
        datasets: datasets,
        totalContributions: totalContributions,
      );
    } else {
      throw Exception('Failed to load contribution data: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentYearStart = DateTime(DateTime.now().year, 1, 1);

    return Card(
      elevation: 0,
      // color: const Color(0xFF24292e),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Material(
        color: Color(0xFF000C18),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Container(
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(24),
                      HackerTextEffect(text: 'Caffein and version-control!',),

                      Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: 
                                GithubButton(
                              text: "Visit Source",
                              url: "https://github.com/ankurt02",
                            ),
                          ),
                          Gap(60),
                        ],
                      ),

                      Gap(10),
                    ],
                  ),
                ),
                Gap(16),
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.pinkAccent, width: 2),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FutureBuilder<ContributionData>(
                      future: _contributionData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          final contributionData = snapshot.data!;
                  
                          // --- Dynamic Color Calculation Logic ---
                          final maxCount =
                              (contributionData.datasets.values.isNotEmpty)
                                  ? contributionData.datasets.values.reduce(
                                    (a, b) => a > b ? a : b,
                                  )
                                  : 0;
                  
                          // Dynamic colors based on contribution thresholds.
                          final Map<int, Color> dynamicColors = {
                            1: const Color(0xFF0E4429), 
                          };
                  
                          if (maxCount > 0) {
                            // print(maxCount);
                            dynamicColors[(maxCount * 0.25)
                                .ceil()] = const Color(0xFF006D32);
                            dynamicColors[(maxCount * 0.5)
                                .ceil()] = const Color(0xFF26A641);
                            dynamicColors[(maxCount * 0.75).ceil()] =
                                const Color(0xFF39D353); 
                          }
                  
                          return Column(
                            children: [
                              // --- User Profile Section ---
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      widget.profile.profilePicUrl,
                                    ),
                                    backgroundColor: const Color(0xFF24292e),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.profile.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '@${widget.profile.username}',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Gap(12),
                                      _buildStat(
                                        'Repositories',
                                        widget.profile.totalRepos.toString(),
                                      ),
                                      Gap(20),
                                      _buildStat(
                                        'Followers',
                                        widget.profile.followers.toString(),
                                      ),
                                      Gap(20),
                                      
                                      _buildStat(
                                        'Contributions',
                                        contributionData.totalContributions
                                            .toString(),
                                        isLive: true,
                                      ),
                                      Gap(12),
                                    ],
                                  ),
                                ],
                              ),
                              Gap(16),
                              const Divider(color: Colors.white24),
                              Gap(16),
                              // --- Contribution Heatmap Section ---
                              HeatMap(
                                datasets: contributionData.datasets,
                                startDate: currentYearStart,
                                endDate: DateTime.now(),
                                colorsets: dynamicColors,
                                colorMode: ColorMode.color,
                                defaultColor: Color(0xFF000C18),
                                scrollable: true,
                                size: 14,
                                textColor: Colors.white70,
                                showText: false,
                                showColorTip: true,
                                borderRadius: 4,
                                borderWidth: 1.0,
                                borderColor:
                                    Colors
                                        .grey
                                        .shade600, 
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'No contribution data found.',
                              style: TextStyle(color: Colors.white70),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),

                Spacer(),

                Container(
                  height: 60,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.transparent, width: 0),
                  // ),
                  child: CarouselScreen(),
                ),

                Gap(48),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, {bool isLive = false}) {
    return Row(
      children: [
        Text(
          value,
          style: TextStyle(
            color: isLive ? Colors.greenAccent : Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(6),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
