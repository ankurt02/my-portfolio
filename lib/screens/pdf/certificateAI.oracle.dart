import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class CertificateOracleAI extends StatelessWidget {
  const CertificateOracleAI({super.key});

  @override
  Widget build(BuildContext context) {
    final String? certificateUrl = "https://resume-hosting-f1c9d.web.app/oci_certificate_ai.pdf";

    if (certificateUrl == null || certificateUrl.isEmpty) {
      return const Center(
        child: Text(
          'Error: URL not found',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF000C18),
      body: PdfViewer.uri(
        Uri.parse(certificateUrl),
        params: const PdfViewerParams(
          minScale: 0.2
        ),
      ),
    );
  }
}

