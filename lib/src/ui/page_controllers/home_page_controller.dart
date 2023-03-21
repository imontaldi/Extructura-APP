import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/src/interfaces/i_view_controller.dart';
import 'package:extructura_app/src/managers/data_manager/data_manager.dart';
import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:extructura_app/src/models/image_model.dart';
import 'package:extructura_app/src/models/sell_invoice_model.dart';
import 'package:extructura_app/src/support/network/error_message.dart';
import 'package:extructura_app/src/ui/popups/loading_popup.dart';
import 'package:extructura_app/utils/page_args.dart';

class HomePageController extends ControllerMVC implements IViewController {
  static late HomePageController _this;

  factory HomePageController() {
    _this = HomePageController._();
    return _this;
  }

  static HomePageController get con => _this;
  final formKey = GlobalKey<FormState>();

  PageArgs? args;

  String title = "Bienvenido a Extructura";

  SellInvoiceModel? sellInvoice;

  File? imgFile;

  //IMAGE PICKER
  File? image;
  // ----------------

  HomePageController._();

  @override
  void initPage({PageArgs? arguments}) {}

  @override
  disposePage() {}

  onSelectedPDF() {
    PageManager().goPdfViewPage();
  }

  void goTestPage() {
    PageManager().goTestPage();
  }

  Future<void> onCropImage() async {
    await LoadingPopup(
      context: PageManager().navigatorKey.currentContext!,
      onLoading: DataManager()
          .postSendImage(ImageModel(path: image!.path)), //getImageData(),
      onResult: (data) => {},
      onError: (error) => onErrorFunction(error: error, onRetry: () {}),
    ).show();
  }
}
