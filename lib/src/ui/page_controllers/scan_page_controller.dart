import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/src/interfaces/i_view_controller.dart';
import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:extructura_app/utils/page_args.dart';

class ScanPageController extends ControllerMVC implements IViewController {
  static late ScanPageController _this;

  factory ScanPageController() {
    _this = ScanPageController._();
    return _this;
  }

  static ScanPageController get con => _this;
  final formKey = GlobalKey<FormState>();

  PageArgs? args;
  ScanPageController._();

  @override
  void initPage({PageArgs? arguments}) {
    args = arguments;
  }

  void goBack() {
    PageManager().goBack();
  }

  @override
  disposePage() {}

  File? scannedImage;
}
