import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/utils/page_args.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quick_scanner/quick_scanner.dart';

import '../../../values/k_colors.dart';
import '../components/appbar/custom_navigation_bar_component.dart';
import '../components/menu/menu_component.dart';

import '../page_controllers/scan_page_controller.dart';

class ScanPage extends StatefulWidget {
  final PageArgs? args;
  const ScanPage(this.args, {Key? key}) : super(key: key);

  @override
  ScanPageState createState() => ScanPageState();
}

class ScanPageState extends StateMVC<ScanPage> {
  late ScanPageController _con;

  ScanPageState() : super(ScanPageController()) {
    _con = ScanPageController.con;
  }

  @override
  void initState() {
    _con.initPage(arguments: widget.args);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final List<String> _scanners = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: KBackground,
        body: Row(
          children: [
            MenuComponent(
              closeMenu: () => {},
              width: MediaQuery.of(context).size.width * 0.22,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  simpleNavigationBar(
                    title: "Escaneo de imágen",
                    hideInfoButton: true,
                    hideNotificationButton: true,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 60,
                    child: body(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('startWatch'),
              onPressed: () async {
                QuickScanner.startWatch();
              },
            ),
            ElevatedButton(
              child: const Text('stopWatch'),
              onPressed: () async {
                QuickScanner.stopWatch();
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('getScanners'),
              onPressed: () async {
                var list = await QuickScanner.getScanners();
                _scanners.addAll(list);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('scan'),
              onPressed: () async {
                var directory = await getApplicationDocumentsDirectory();
                var scannedFile = await QuickScanner.scanFile(
                    _scanners.first, directory.path);
                // print('scannedFile $scannedFile');
                setState(() {
                  _con.scannedImage = File(scannedFile);
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        // if (_con.scannedImage != null) ...[
        //   Image.file(
        //     _con.scannedImage!,
        //     height: 450,
        //   ),
        // ]
      ],
    );
  }
}
