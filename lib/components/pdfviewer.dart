import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

// class PdfViewerPage extends StatelessWidget {
//   final String pdfUrl;

//   const PdfViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//       ),
//       body: PDF().cachedFromUrl(
//         pdfUrl,
//         placeholder: (double progress) =>
//             Center(child: CircularProgressIndicator(value: progress)),
//         errorWidget: (dynamic error) =>
//             Center(child: Text('Error loading PDF: $error')),
//       ),
//     );
//   }
// }

class PdfViewerPage extends StatelessWidget {
  final String pdfAssetPath;

  const PdfViewerPage({Key? key, required this.pdfAssetPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDF().fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) =>
            Center(child: Text('Error loading PDF: $error')),
      ),
    );
  }
}
