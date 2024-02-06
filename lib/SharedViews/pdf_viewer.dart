import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../src/app_root.dart';

class PDFScreen extends StatefulWidget {
  final String? path;

  PDFScreen({Key? key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: true,
            pageFling: true,

            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            fitEachPage: true,
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Container()
              : Center(
            child: Text(errorMessage),
          )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  minWidth: 100,
                  color: greenColor,
                  child: Text('Go to ${currentPage! - 1}',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (currentPage! > 0) {
                      await snapshot.data!.setPage(currentPage! - 1);
                    }
                  },
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  minWidth: 100,
                  color: greenColor,
                  child: Text('Go to ${currentPage! + 1}',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (currentPage! < pages! - 1) {
                      await snapshot.data!.setPage(currentPage! + 1);
                    }
                  },
                ),

              ],
            );
          }

          return Container();
        },
      ),    );
  }
}



class PdfPage extends StatefulWidget {
  final String? path;

  PdfPage({Key? key, this.path}) : super(key: key);
  @override
  _PdfPage createState() => _PdfPage();
}

class _PdfPage extends State<PdfPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController _pdfViewerController = PdfViewerController();

String? fileName='';
  @override
  void initState() {
    super.initState();
    Uri uri = Uri.parse(widget.path.toString());
     fileName = uri.pathSegments.last.split('/').last;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(fileName!),
        titleTextStyle: TextStyle(color: greenColor, fontSize: 20, fontWeight: FontWeight.bold),
        centerTitle: true,
        iconTheme: IconThemeData(color: greenColor),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(

        widget.path.toString(),
        controller: _pdfViewerController,
        canShowPageLoadingIndicator: true,
        canShowHyperlinkDialog: true,
        canShowPaginationDialog: true,
        canShowScrollStatus: true,
        onHyperlinkClicked: (hyperlink) async {
          if (!await launchUrl(hyperlink as Uri)) {
          throw Exception('Could not launch $hyperlink');
          }
          print('Hyperlink clicked $hyperlink');
        },
        canShowScrollHead: true,
        currentSearchTextHighlightColor: greenColor,
        enableHyperlinkNavigation: true,
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          Container(
            child: Text(
              'Document Load Failed: ${details.description}',
              style: TextStyle(color: Colors.red),
            ),
          );
          print('Document Load Failed: ${details.description}');
        },
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Document Loaded'),
            ),
          );
          print('Document Loaded');
        },


        onTap: ( details) {
          print('Tapped at page - ${details.pageNumber}');
        },
        enableTextSelection: true,
        enableDoubleTapZooming: true,

        onPageChanged: (details) {
          print('Page Changed: ${details.newPageNumber}');
        },


        key: _pdfViewerKey,
      ),
    );
  }
}

