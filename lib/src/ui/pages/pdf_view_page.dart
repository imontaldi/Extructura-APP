import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:extructura_app/src/ui/components/appbar/custom_navigation_bar_component.dart';
import 'package:extructura_app/src/ui/components/buttons/rounded_button_component.dart';
import 'package:extructura_app/src/ui/page_controllers/pdf_view_page_controller.dart';
import 'package:extructura_app/utils/page_args.dart';
import 'package:extructura_app/values/k_values.dart';

class PdfViewPage extends StatefulWidget {
  final PageArgs? args;
  const PdfViewPage(this.args, {Key? key}) : super(key: key);

  @override
  PdfViewPageState createState() => PdfViewPageState();
}

//Ejemplo commit

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
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: pdfReaderNavigationBar(
          title: basename(_con.args!.pdfFileToShow!.path),
          hideInfoButton: true,
          hideNotificationButton: true,
          onBack: () => _con.goBack(),
          pdfController: _con.pdfController,
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PdfView(
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: RoundedButton(
                width: double.infinity,
                fontSize: KFontSizeLarge40,
                fontWeight: FontWeight.bold,
                isEnabled: true,
                disableTextColor: const Color(0xFFE4E4E4),
                text: 'Seleccionar esta página para escanear',
                onPressed: () async {
                  final document = await PdfDocument.openFile(
                      _con.args!.pdfFileToShow!.path);
                  final pageImage =
                      await _renderPage(document, _con.currentPageIndex ?? 1);
                  String? downloadsDirectory = await getDownloadPath();
                  String path = "/page${_con.currentPageIndex}.png";
                  String filePath = downloadsDirectory! + path;
                  File imgFile = File(filePath);
                  File image =
                      await File(imgFile.path).writeAsBytes(pageImage.bytes);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, image.path);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<PdfPageImage> _renderPage(PdfDocument document, int pageNumber) async {
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

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      debugPrint("No se pudo encontrar la carpeta de descargas");
    }
    return directory?.path;
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
