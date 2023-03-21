import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
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
}
