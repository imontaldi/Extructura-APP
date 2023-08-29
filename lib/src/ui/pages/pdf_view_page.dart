import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path/path.dart';
import 'package:pdfx/pdfx.dart';
import 'package:extructura_app/src/ui/components/appbar/custom_navigation_bar_component.dart';
import 'package:extructura_app/src/ui/page_controllers/pdf_view_page_controller.dart';
import 'package:extructura_app/utils/page_args.dart';
import 'package:extructura_app/values/k_values.dart';

import '../../../values/k_colors.dart';
import '../components/menu/menu_component.dart';

class PdfViewPage extends StatefulWidget {
  final PageArgs? args;
  const PdfViewPage(this.args, {Key? key}) : super(key: key);

  @override
  PdfViewPageState createState() => PdfViewPageState();
}

// Ejemplo commit
class PdfViewPageState extends StateMVC<PdfViewPage> {
  late PdfViewPageController _con;

  PdfViewPageState() : super(PdfViewPageController()) {
    _con = PdfViewPageController.con;
  }

  @override
  void initState() {
    _con.initPage(arguments: widget.args);
    super.initState();
  }

  @override
  void dispose() {
    _con.pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Platform.isWindows ? _desktopBody(context) : _mobileBody(context),
    );
  }

  Widget _desktopBody(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackground,
      body: Row(
        children: [
          MenuComponent(
            closeMenu: () => {},
            width: MediaQuery.of(context).size.width * 0.22,
          ),
          Expanded(
            child: Column(
              children: [
                pdfReaderNavigationBar(
                  title: basename(_con.args!.pdfFileToShow!.path),
                  hideInfoButton: true,
                  hideNotificationButton: true,
                  onBack: () => _con.goBack(),
                  pdfController: _con.pdfController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: pdfView(),
                      )),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Página",
                                    style: TextStyle(
                                      fontSize: KFontSizeLarge40,
                                      fontWeight: FontWeight.w500,
                                      color: KGrey,
                                    ),
                                  ),
                                  backPageIcon(),
                                  pageNumberIndicator(),
                                  forwardPageIcon(),
                                ],
                              ),
                              const Spacer(),
                              footer(context)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget backPageIcon() {
    return InkWell(
      customBorder: const CircleBorder(),
      child: const Icon(
        Icons.navigate_before,
        size: 25,
        color: KPrimary,
      ),
      onTap: () {
        _con.pdfController.previousPage(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 100),
        );
      },
    );
  }

  Widget pageNumberIndicator() {
    return PdfPageNumber(
      controller: _con.pdfController,
      builder: (_, loadingState, page, pagesCount) => Container(
        alignment: Alignment.center,
        child: Text(
          '$page/${pagesCount ?? 0}',
          style: const TextStyle(
            fontSize: KFontSizeLarge40,
            color: KGrey,
          ),
        ),
      ),
    );
  }

  Widget forwardPageIcon() {
    return InkWell(
      customBorder: const CircleBorder(),
      child: const Icon(
        Icons.navigate_next,
        size: 25,
        color: KPrimary,
      ),
      onTap: () {
        _con.pdfController.nextPage(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 100),
        );
      },
    );
  }

  Widget _mobileBody(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackground,
      appBar: pdfReaderNavigationBar(
        title: basename(_con.args!.pdfFileToShow!.path),
        hideInfoButton: true,
        hideNotificationButton: true,
        onBack: () => _con.goBack(),
        pdfController: _con.pdfController,
        showPageIndicator: Platform.isAndroid,
      ),
      body: Column(
        children: [
          Expanded(child: pdfView()),
          footer(context),
        ],
      ),
    );
  }

  Widget pdfView() {
    return PdfView(
      backgroundDecoration: const BoxDecoration(color: KBackground),
      builders: PdfViewBuilders<DefaultBuilderOptions>(
        options: const DefaultBuilderOptions(),
        documentLoaderBuilder: (_) =>
            const Center(child: CircularProgressIndicator()),
        pageLoaderBuilder: (_) =>
            const Center(child: CircularProgressIndicator()),
        pageBuilder: _pageBuilder,
      ),
      onPageChanged: (page) => _con.currentPageIndex = page,
      controller: _con.pdfController,
    );
  }

  Widget footer(BuildContext context) {
    return InkWell(
      onTap: () async {
        _con.onTapSelectPage(context);
      },
      child: Container(
        height: 50,
        color: KPrimary,
        child: const Center(
          child: Text(
            'Seleccionar esta página para escanear',
            style: TextStyle(
              color: KWhite,
              fontSize: KFontSizeLarge40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _pageBuilder(
    BuildContext context,
    Future<PdfPageImage> pageImage,
    int index,
    PdfDocument document,
  ) {
    return PhotoViewGalleryPageOptions(
      imageProvider: PdfPageImageProvider(
        pageImage,
        index,
        document.id,
      ),
      minScale: PhotoViewComputedScale.contained * 1,
      maxScale: PhotoViewComputedScale.contained * 2,
      initialScale: PhotoViewComputedScale.contained * 1.0,
      heroAttributes: PhotoViewHeroAttributes(tag: '${document.id}-$index'),
    );
  }
}
