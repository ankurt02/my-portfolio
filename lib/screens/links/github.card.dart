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
  final GitHubProfile? profile; // Made optional
  const GitHubCard({super.key, this.profile});

  @override
  State<GitHubCard> createState() => _GitHubCardState();
}

class _GitHubCardState extends State<GitHubCard> {
  late Future<Map<String, dynamic>> _githubData;
  // final String githubToken = const String.fromEnvironment('TOKEN_GITHUB');
// 
  @override
  void initState() {
    super.initState();
    _githubData = _fetchAllGitHubData();
  }

  /// Fetches both profile and contribution data together from GitHub GraphQL API
  /// Fetches both profile and contribution data from Vercel proxy API
Future<Map<String, dynamic>> _fetchAllGitHubData() async {
  final now = DateTime.now();
  final startDate = DateTime(now.year, 1, 1);
  final endDate = DateTime(now.year, 12, 31);

  final String query = """
    query(\$from: DateTime!, \$to: DateTime!) {
      viewer {
        login
        name
        avatarUrl
        repositories {
          totalCount
        }
        followers {
          totalCount
        }
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

  // Changed: Use Vercel API instead of GitHub directly
  final response = await http.post(
    Uri.parse('https://git-hub-proxy-mu.vercel.app/api/github'),
    headers: {
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
    
    // Check if there's an error in the response
    if (data['errors'] != null) {
      throw Exception('GraphQL Error: ${data['errors']}');
    }
    
    final viewer = data['data']['viewer'];
    final calendar = viewer['contributionsCollection']['contributionCalendar'];
    final weeks = calendar['weeks'];
    
    // Parse contribution data
    final Map<DateTime, int> datasets = {};
    for (var week in weeks) {
      for (var day in week['contributionDays']) {
        final date = DateTime.parse(day['date']);
        final count = day['contributionCount'];
        datasets[date] = count;
      }
    }

    // Create profile object
    final profile = GitHubProfile(
      username: viewer['login'] ?? 'user',
      name: viewer['name'] ?? 'User',
      profilePicUrl: viewer['avatarUrl'] ?? '',
      totalRepos: viewer['repositories']['totalCount'] ?? 0,
      followers: viewer['followers']['totalCount'] ?? 0,
      totalContributions: null,
    );

    // Create contribution data object
    final contributionData = ContributionData(
      datasets: datasets,
      totalContributions: calendar['totalContributions'] ?? 0,
    );

    return {
      'profile': profile,
      'contributionData': contributionData,
    };
  } else {
    throw Exception('Failed to load GitHub data: ${response.statusCode} - ${response.body}');
  }
}

  @override
  Widget build(BuildContext context) {
    final currentYearStart = DateTime(DateTime.now().year, 1, 1);
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Material(
        color: Color(0xFF000C18),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _githubData,
          builder: (context, snapshot) {
            // Loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: screenHeight,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            }
            
            // Error state
            if (snapshot.hasError) {
              return Container(
                height: screenHeight,
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      Gap(16),
                      Text(
                        'Error loading GitHub data',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(8),
                      Text(
                        '${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
            
            // No data state
            if (!snapshot.hasData) {
              return Container(
                height: screenHeight,
                child: const Center(
                  child: Text(
                    'No GitHub data available',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              );
            }

            // Success state - extract data
            final profile = snapshot.data!['profile'] as GitHubProfile;
            final contributionData = snapshot.data!['contributionData'] as ContributionData;

            return _buildContent(
              context,
              profile,
              contributionData,
              currentYearStart,
              screenHeight,
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    GitHubProfile profile,
    ContributionData contributionData,
    DateTime currentYearStart,
    double screenHeight,
  ) {
    // Dynamic Color Calculation Logic 
    final maxCount = (contributionData.datasets.values.isNotEmpty)
        ? contributionData.datasets.values.reduce((a, b) => a > b ? a : b)
        : 0;

    // Dynamic colors based on contribution thresholds
    final Map<int, Color> dynamicColors = {
      1: const Color(0xFF0E4429),
    };

    if (maxCount > 0) {
      dynamicColors[(maxCount * 0.25).ceil()] = const Color(0xFF006D32);
      dynamicColors[(maxCount * 0.5).ceil()] = const Color(0xFF26A641);
      dynamicColors[(maxCount * 0.75).ceil()] = const Color(0xFF39D353);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // Header Section
            Container(
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(24),
                  HackerTextEffect(text: 'Caffeine and version-control!'),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: GithubButton(
                          text: "Visit Source",
                          url: "https://github.com/${profile.username}",
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
            
            // Profile and Heatmap Section
            Container(
              height: screenHeight / 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // Profile Row
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundImage: profile.profilePicUrl.isNotEmpty
                              ? NetworkImage(profile.profilePicUrl)
                              : null,
                          backgroundColor: const Color(0xFF24292e),
                          child: profile.profilePicUrl.isEmpty
                              ? Icon(Icons.person, size: 36, color: Colors.white54)
                              : null,
                        ),
                        Gap(18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '@${profile.username}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        
                        // Stats Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Gap(12),
                            _buildStat(
                              'Repositories',
                              profile.totalRepos.toString(),
                            ),
                            Gap(20),
                            _buildStat(
                              'Followers',
                              profile.followers.toString(),
                            ),
                            Gap(20),
                            _buildStat(
                              'Contributions',
                              contributionData.totalContributions.toString(),
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
                    
                    // Contribution Heatmap
                    HeatMap(
                      datasets: contributionData.datasets,
                      startDate: currentYearStart,
                      endDate: DateTime.now(),
                      colorsets: dynamicColors,
                      colorMode: ColorMode.color,
                      defaultColor: Color(0xFF000C18),
                      scrollable: true,
                      size: 16,
                      textColor: Colors.white70,
                      showText: false,
                      showColorTip: true,
                      borderRadius: 4,
                      borderWidth: 1.0,
                      borderColor: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            // Carousel Section
            Container(
              height: 60,
              child: CarouselScreen(),
            ),

            Gap(48),
          ],
        );
      },
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