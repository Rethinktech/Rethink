// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class UserManual extends StatefulWidget {
  const UserManual({ Key? key }) : super(key: key);

  @override
  _UserManualState createState() => _UserManualState();
}

class _UserManualState extends State<UserManual> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController controller = PdfViewerController();
  bool isZoom = false;
  String pdfURL = 'https://www.medicines.org.uk/emc/files/pil.2519.pdf';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Manual'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                launch(pdfURL);
              }, 
              child: const Text('Download User Manual (PDF)')
            ),
          ),
          Expanded(
            child: SfPdfViewer.network(
              pdfURL,
              key: _pdfViewerKey,
              controller: controller,
              enableDoubleTapZooming: true,
              initialZoomLevel: 1,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: isZoom
        ? const Icon(Icons.zoom_out_rounded)
        : const Icon(Icons.zoom_in_rounded),
        onPressed: () {
          if (isZoom == true)
          {
            controller.zoomLevel = 1;
          }
          else {
            controller.zoomLevel = 2;
          }
          setState(() {
            if (isZoom == true)
            {
              isZoom = false;
            }
            else {
              isZoom = true;
            }
          });
        }
      ),
    );
  }
}