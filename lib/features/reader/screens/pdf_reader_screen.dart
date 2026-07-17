import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfReaderScreen extends StatefulWidget {
  final String pdfUrl;
  final String title;

  const PdfReaderScreen({
    super.key,
    required this.pdfUrl,
    required this.title,
  });

  @override
  State<PdfReaderScreen> createState() => _PdfReaderScreenState();
}

class _PdfReaderScreenState extends State<PdfReaderScreen> {
  final PdfViewerController _controller = PdfViewerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),

        actions: [

          IconButton(
            icon: const Icon(Icons.first_page),
            onPressed: () {
              _controller.jumpToPage(1);
            },
          ),

          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed: () {
              _controller.jumpToPage(9999);
            },
          ),

        ],
      ),

      body: SfPdfViewer.network(
        widget.pdfUrl,
        controller: _controller,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        enableDoubleTapZooming: true,
      ),
    );
  }
}