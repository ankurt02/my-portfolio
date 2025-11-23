import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoonWidget extends StatefulWidget {
  final double width;
  const MoonWidget({super.key, required this.width});

  @override
  State<MoonWidget> createState() => _MoonWidgetState();
}

class _MoonWidgetState extends State<MoonWidget> {
  String? _moonUrl;
  bool _isLoading = true;
  bool _hasError = false;

  // -----------------------------------------------------------
  // TODO: PASTE YOUR ASTRONOMYAPI.COM CREDENTIALS HERE
  // DO NOT USE YOUR NASA KEY HERE. IT WILL NOT WORK.
  final String applicationId = "bdeb0b68-d736-4743-9286-87cedc48f889";
  final String applicationSecret = "190909f4d48b82c6365f1672304343535b4e58781f0cbce7255fc824121bcd97f5c97c948d5f05397a86b04fd5271d037fbd40f40e8bc6f62a2f12f84c098610c443984871063a3dc07801224152bfa873d794c4b5735bbf71027ece0b348cf9797bc88e61039da74abadb003076e8eb";
  // -----------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _fetchMoonPhase();
  }

  Future<void> _fetchMoonPhase() async {
    final url = Uri.parse("https://api.astronomyapi.com/api/v2/studio/moon-phase");
    
    // Create the correct Basic Auth String
    // Basic Auth format is: "Basic " + Base64(ID:Secret)
    final String authString = base64Encode(utf8.encode('$applicationId:$applicationSecret'));

    final date = DateTime.now().toIso8601String().split("T")[0];

    final requestBody = jsonEncode({
      "format": "png",
      "style": {
        "moonStyle": "default",
        // "backgroundStyle": "stars",
        "backgroundStyle": "solid", // 1. Must be 'solid' to use a custom color
        "backgroundColor": "rgba(0,0,0,1)",
        // "headingColor": "#FFFFFF",
        // "textColor": "#FFFFFF"
      },
      "observer": {
        "latitude": 22.567083, // Example: Kolkata Latitude
        "longitude": 88.514278, // Example: Kolkata Longitude 22°34'01.5"N 88°30'51.4"E
        "date": date
      },
      "view": {
        "type": "portrait-simple",
        "orientation": "south-up"
      }
    });

    try {
      print("Fetching Moon Data..."); 
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic $authString", 
        },
        body: requestBody,
      );

      print("Response Status: ${response.statusCode}");
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print("Success! Image URL: ${json["data"]["imageUrl"]}");
        if (mounted) {
          setState(() {
            _moonUrl = json["data"]["imageUrl"];
            _isLoading = false;
          });
        }
      } else {
        // Print the error from the server to the console
        print("Server Error: ${response.body}");
        if (mounted) {
          setState(() {
            _isLoading = false;
            _hasError = true;
          });
        }
      }
    } catch (e) {
      print("App Error: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(color: Colors.pink, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.transparent))
            : _hasError
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 30),
                      const SizedBox(height: 8),
                      const Text(
                        "Auth Failed", 
                        style: TextStyle(color: Colors.white)
                      ),
                      Text(
                        "Check Debug Console", 
                        style: TextStyle(color: Colors.grey[400], fontSize: 10)
                      ),
                    ],
                  )
                : Image.network(
                    _moonUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (ctx, child, progress) =>
                        progress == null
                            ? child
                            : const Center(child: CircularProgressIndicator(color: Colors.pink)),
                  ),
      ),
    );
  }
}