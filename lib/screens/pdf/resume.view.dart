import 'package:ankur_portfolio/widgets/buttons/resume.download.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:web/web.dart' as web;

class ResumeView extends StatelessWidget {
  const ResumeView({super.key});

  Future<void> _downloadFile(String url) async {
    if (kIsWeb) {
      final anchor = web.HTMLAnchorElement()
        ..href = url
        ..target= '_new'
        ..download = 'Ankur_Tiwary_Resume.pdf'; // Suggested filename
    
      anchor.click();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? resumeUrl = dotenv.env['RESUME_URL'];

    if (resumeUrl == null || resumeUrl.isEmpty) {
      return const Center(
        child: Text(
          'Error: RESUME_URL not found in .env file.',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF000C18),
      body: PdfViewer.uri(
        Uri.parse(resumeUrl),
        params: const PdfViewerParams(
          minScale: 0.2
        ),
      ),
      floatingActionButton: ResumeDownloadButton(
        text: "Download",
        onTap: () => _downloadFile(resumeUrl),
      ),
    );
  }
}

