import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:note_it/config/palette.dart';

class DownloadPDF extends StatefulWidget {
  final path;
  final pathdir;
  DownloadPDF(this.path, this.pathdir);

  @override
  _DownloadPDFState createState() => _DownloadPDFState(path, pathdir);
}

class _DownloadPDFState extends State<DownloadPDF> {
  final path;
  final pathdir;
  _DownloadPDFState(this.path, this.pathdir);

  @override
  Widget build(BuildContext context) {
    final Completer<PDFViewController> _pdfViewController =
        Completer<PDFViewController>();
    // ignore: close_sinks
    final StreamController<String> _pageCountController =
        StreamController<String>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pathdir,
          style: TextStyle(
            color: Palette.darkblue,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Palette.scaffold,
        iconTheme: IconThemeData(color: Palette.darkblue),
        actions: <Widget>[
          StreamBuilder<String>(
            stream: _pageCountController.stream,
            builder: (_, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 16, 10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        // color: Colors.red
                        ),
                    child: Text(
                      snapshot.data,
                      style: TextStyle(
                          color: Palette.darkblue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
              return SizedBox();
            },
          )
        ],
      ),
      body: Container(
        child: PDF(
          enableSwipe: true,
          fitPolicy: FitPolicy.BOTH,
          swipeHorizontal: true,
          fitEachPage: true,
          onPageChanged: (int current, int total) =>
              _pageCountController.add('${current + 1} - $total'),
          onViewCreated: (PDFViewController pdfViewController) async {
            _pdfViewController.complete(pdfViewController);
            final int currentPage = await pdfViewController.getCurrentPage();
            final int pageCount = await pdfViewController.getPageCount();
            _pageCountController.add('${currentPage + 1} - $pageCount');
          },
          preventLinkNavigation: true,
        ).fromPath(path),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: '-',
                  child: const Text(
                    '<',
                    style: TextStyle(
                        color: Palette.darkblue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.white,
                  hoverColor: Palette.darkblue,
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data;
                    final int currentPage =
                        await pdfController.getCurrentPage() - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  heroTag: '+',
                  child: const Text(
                    '>',
                    style: TextStyle(
                        color: Palette.darkblue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data;
                    final int currentPage =
                        await pdfController.getCurrentPage() + 1;
                    final int numberOfPages =
                        await pdfController.getPageCount();
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
