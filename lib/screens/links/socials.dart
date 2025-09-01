import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';


class SocialProfile {
  final String platform;
  final String name;
  final String username;
  final String profilePicUrl;
  final String profileUrl;

  SocialProfile({
    required this.platform,
    required this.name,
    required this.username,
    required this.profilePicUrl,
    required this.profileUrl,
  });
}

class XProfile extends SocialProfile {
  final String bannerUrl;

  XProfile({
    required String name,
    required String username,
    required String profilePicUrl,
    required this.bannerUrl,
  }) : super(
          platform: 'X',
          name: name,
          username: username,
          profilePicUrl: profilePicUrl,
          profileUrl: 'https://x.com/$username',
        );
}

class LinkedInProfile extends SocialProfile {
  final String connections;

  LinkedInProfile({
    required String name,
    required String username,
    required String profilePicUrl,
    required this.connections,
  }) : super(
          platform: 'LinkedIn',
          name: name,
          username: username,
          profilePicUrl: profilePicUrl,
          profileUrl: 'https://linkedin.com/in/$username',
        );
}

// Model updated to use totalRepos
class GitHubProfile extends SocialProfile {
  final String? location;
  final int totalRepos;
  final int followers;
  final int totalContributions;

  GitHubProfile({
    required String name,
    required String username,
    required String profilePicUrl,
    required this.totalRepos,
    required this.followers,
    required this.totalContributions,
    this.location,
  }) : super(
          platform: 'GitHub',
          name: name,
          username: username,
          profilePicUrl: profilePicUrl,
          profileUrl: 'https://github.com/$username',
        );
}


class SocialsService {
  static final String? _githubToken = dotenv.env['TOKEN_GITHUB'];

  static Future<List<SocialProfile>> fetchProfiles() async {
    if (_githubToken == null || _githubToken!.isEmpty) {
      throw Exception('TOKEN_GITHUB not found in .env file.');
    }

    final String jsonString = await rootBundle.loadString('assets/socials.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    final List<SocialProfile> profiles = [];

    
    try {
      final ghProfile = await _fetchGitHubData();
      profiles.add(ghProfile);
    } catch (e) {
      var logger = Logger();
logger.e('Failed to load GitHub profile', error: e);
    }

    // Parse static profiles from JSON
    for (var item in jsonData['socials']) {
      if (item['platform'] == 'X') {
        profiles.add(XProfile(
          name: item['name'],
          username: item['username'],
          profilePicUrl: item['profile_pic_url'],
          bannerUrl: item['banner_url'],
        ));
      } else if (item['platform'] == 'LinkedIn') {
        profiles.add(LinkedInProfile(
          name: item['name'],
          username: item['username'],
          profilePicUrl: item['profile_pic_url'],
          connections: item['connections'],
        ));
      }
    }
    return profiles;
  }

 
  static Future<GitHubProfile> _fetchGitHubData() async {
    final DateTime now = DateTime.now();
    final String startDate = DateTime(now.year, 1, 1).toIso8601String();
    final String endDate = now.toIso8601String();

    final String query = """
      query(\$from: DateTime!, \$to: DateTime!) {
        viewer {
          name
          login
          avatarUrl
          location
          # CORRECTED: This now only counts repositories you own and are not forks.
          repositories(ownerAffiliations: OWNER) {
            totalCount
          }
          followers {
            totalCount
          }
          contributionsCollection(from: \$from, to: \$to) {
            contributionCalendar {
              totalContributions
            }
          }
        }
      }
    """;

    final response = await http.post(
      Uri.parse('https://api.github.com/graphql'),
      headers: {
        'Authorization': 'Bearer $_githubToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'query': query,
        'variables': {
          'from': startDate,
          'to': endDate,
        },
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data']['viewer'];
      
      return GitHubProfile(
        name: data['name'] ?? 'No Name',
        username: data['login'],
        profilePicUrl: data['avatarUrl'],
        totalRepos: data['repositories']['totalCount'] ?? 0,
        followers: data['followers']['totalCount'] ?? 0,
        location: data['location'],
        totalContributions: data['contributionsCollection']['contributionCalendar']['totalContributions'] ?? 0,
      );
    } else {
      throw Exception('Failed to load GitHub profile data: ${response.body}');
    }
  }
}
