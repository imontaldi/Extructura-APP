import 'dart:io';
import 'package:extructura_app/src/enums/image_type_enum.dart';
import 'package:extructura_app/src/managers/data_manager.dart';
import 'package:extructura_app/src/models/api_Invoice_models/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/src/interfaces/i_view_controller.dart';
import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
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

  //IMAGE PICKER
  File? image;
  // ----------------
  ImageTypeEnum? imageType;

  HomePageController._();

  @override
  void initPage({PageArgs? arguments}) {}

  @override
  disposePage() {}

  void setSelectedRadio(Object? radioOptionSelected) {
    setState(() {
      imageType = ImageTypeEnum.values
          .firstWhere((element) => element.value == radioOptionSelected);
    });
  }

  // Future<void> onAnalizeInvoice() async {
  //   // String invoice = await rootBundle.loadString('assets/invoice.json');
  //   await LoadingPopup(
  //     context: PageManager().navigatorKey.currentContext!,
  //     onLoading: rootBundle.loadString('assets/invoice.json'),
  //     loadingText: "Pruebita",
  //     onResult: (data) => PageManager().goReviewDataPage(
  //         args: PageArgs(invoice: InvoiceModel.fromJson(jsonDecode(data)))),
  //     onError: (error) => onErrorFunction(
  //       error: error,
  //       onRetry: () {},
  //     ),
  //   ).show();
  // }

  Future<void> onAnalizeInvoice() async {
    await LoadingPopup(
      context: PageManager().navigatorKey.currentContext!,
      onLoading: DataManager().postSendImage(image!, getImageTypeId()),
      loadingText: "Enviando imágen...",
      onResult: (data) => {postRequestHeaderProcessing()},
      onError: (error) => onErrorFunction(
        error: error,
        onRetry: () {},
      ),
    ).show();
  }

  Future<void> postRequestHeaderProcessing() async {
    await LoadingPopup(
      context: PageManager().navigatorKey.currentContext!,
      onLoading: DataManager().postRequestHeaderProcessing(),
      loadingText: "Procesando encabezado de factura...",
      onResult: (data) => {postRequestItemsProcessing()},
      onError: (error) => onErrorFunction(
        error: error,
        onRetry: () {},
      ),
    ).show();
  }

  Future<void> postRequestItemsProcessing() async {
    await LoadingPopup(
      context: PageManager().navigatorKey.currentContext!,
      onLoading: DataManager().postRequestItemsProcessing(),
      loadingText: "Procesando productos...",
      onResult: (data) => {postRequestFooterProcessing()},
      onError: (error) => onErrorFunction(
        error: error,
        onRetry: () {},
      ),
    ).show();
  }

  Future<void> postRequestFooterProcessing() async {
    await LoadingPopup(
      context: PageManager().navigatorKey.currentContext!,
      onLoading: DataManager().postRequestFooterProcessing(),
      loadingText: "Procesando pie de factura...",
      onResult: (data) => {getInvoice()},
      onError: (error) => onErrorFunction(
        error: error,
        onRetry: () {},
      ),
    ).show();
  }

  Future<void> getInvoice() async {
    await LoadingPopup(
      context: PageManager().navigatorKey.currentContext!,
      onLoading: DataManager().getInvoice(),
      loadingText: "Obteniendo datos de factura...",
      onResult: (data) => {onGetInvoiceResult(data)},
      onError: (error) => onErrorFunction(
        error: error,
        onRetry: () {},
      ),
    ).show();
  }

  int getImageTypeId() {
    return imageType?.value ?? 2;
  }

  onGetInvoiceResult(InvoiceModel? invoice) async {
    await PageManager().openInvoiceProcessedSuccessfullyPopup(
      onAccept: () =>
          PageManager().goReviewDataPage(args: PageArgs(invoice: invoice)),
      title: "¡Se analizó correctamente el contenido de su factura!",
      subtitle:
          "Por favor revisa que los datos mostrados a continuación sean correctos",
      labelButtonAccept: "Continuar",
      imageURL: "images/icon_checkbox.png",
      imageHeight: 50,
      imageWidth: 50,
      isCancellable: false,
    );
  }
}
