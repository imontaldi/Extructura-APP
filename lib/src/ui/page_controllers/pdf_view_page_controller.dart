import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:extructura_app/src/interfaces/i_view_controller.dart';
import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:extructura_app/utils/page_args.dart';

class PdfViewPageController extends ControllerMVC implements IViewController {
  static late PdfViewPageController _this;

  factory PdfViewPageController() {
    _this = PdfViewPageController._();
    return _this;
  }

  static PdfViewPageController get con => _this;
  final formKey = GlobalKey<FormState>();

  PageArgs? args;

  Future<PdfPageImage>? currentPage;

  late PdfController pdfController;
  static const int initialPage = 1;
  int? currentPageIndex;

  PdfViewPageController._();

  @override
  void initPage({PageArgs? arguments}) {
    args = arguments;
    pdfController = PdfController(
      document: PdfDocument.openFile(args!.pdfFileToShow!.path),
      initialPage: initialPage,
    );
  }

  void goBack() {
    PageManager().goBack();
  }

  @override
  disposePage() {}

  Future<void> onTapSelectPage(BuildContext context) async {
    final document = await PdfDocument.openFile(args!.pdfFileToShow!.path);
    final pageImage = await renderPage(document, currentPageIndex ?? 1);

    String? saveDirectory = await getImageSavePath();
    String path = "/page$currentPageIndex.png";
    String filePath = saveDirectory! + path;
    File imgFile = File(filePath);
    File image = await File(imgFile.path).writeAsBytes(pageImage.bytes);
    // ignore: use_build_context_synchronously
    Navigator.pop(context, image.path);
  }

  Future<PdfPageImage> renderPage(PdfDocument document, int pageNumber) async {
    final page = await document.getPage(pageNumber);
    final pageImage = await page.render(
      width: page.width * 2,
      height: page.height * 2,
      format: PdfPageImageFormat.jpeg,
      backgroundColor: '#ffffff',
    );
    await page.close();
    return pageImage!;
  }

  Future<String?> getImageSavePath() async {
    Directory? directory;
    try {
      if (Platform.isWindows) {
        directory = await getApplicationSupportDirectory();
      } else {
        directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      debugPrint("No se pudo encontrar la carpeta de descargas");
    }
    return directory?.path;
  }
}
