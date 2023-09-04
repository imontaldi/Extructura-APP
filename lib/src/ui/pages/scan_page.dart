import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/utils/page_args.dart';

import '../../../values/k_colors.dart';
import '../components/menu/menu_component.dart';
import 'package:flutter_twain_scanner/flutter_twain_scanner.dart';

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

  String _platformVersion = 'Unknown';
  final _flutterTwainScannerPlugin = FlutterTwainScanner();
  String? _documentPath;
  List<String> _scanners = []; // Option 2
  String? _selectedScanner;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterTwainScannerPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

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
                  SizedBox(
                    height: 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          MaterialButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              onPressed: () async {
                                List<String>? scanners =
                                    await _flutterTwainScannerPlugin
                                        .getDataSources();

                                if (scanners != null) {
                                  setState(() {
                                    _scanners = scanners;
                                  });
                                }
                              },
                              child: const Text('List Scanners')),
                          DropdownButton(
                            hint: const Text(
                                'Select a scanner'), // Not necessary for Option 1
                            value: _selectedScanner,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedScanner = newValue;
                              });
                            },
                            items: _scanners.map((location) {
                              return DropdownMenuItem(
                                value: location,
                                child: Text(location),
                              );
                            }).toList(),
                          ),
                          MaterialButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              onPressed: () async {
                                if (_selectedScanner != null) {
                                  int index =
                                      _scanners.indexOf(_selectedScanner!);
                                  String? documentPath =
                                      await _flutterTwainScannerPlugin
                                          .scanDocument(index);
                                  setState(() {
                                    _documentPath = documentPath;
                                  });
                                }
                              },
                              child: const Text('Scan Document')),
                        ]),
                  ),
                  SizedBox(
                      height: 600,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: _documentPath == null
                            ? Image.asset('images/icon_warning.png')
                            : Image.file(
                                File(_documentPath!),
                                fit: BoxFit.contain,
                                width: 600,
                                height: 600,
                              ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
