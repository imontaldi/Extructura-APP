import 'dart:core';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:extructura_app/src/enums/afip_responsability_types_enum.dart';
import 'package:extructura_app/src/enums/currency_type_enum.dart';
import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:extructura_app/src/models/api_Invoice_models/invoice_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/item_model.dart';
import 'package:extructura_app/src/ui/popups/loading_popup.dart';
import 'package:extructura_app/utils/functions_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/src/interfaces/i_view_controller.dart';
import 'package:extructura_app/utils/page_args.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../enums/permission_status_enum.dart';

import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

class ReviewDataPageController extends ControllerMVC
    implements IViewController {
  static late ReviewDataPageController _this;

  factory ReviewDataPageController() {
    _this = ReviewDataPageController._();
    return _this;
  }

  static ReviewDataPageController get con => _this;

  PageArgs? args;

  ReviewDataPageController._();

  Map<String, bool> tabs = {"Encabezado": true, "Detalle": false};
  InvoiceModel? invoice;
  ItemModel? item;
  int currentlyDisplayedItemIndex = 0;
  late String operationType;
  ///// Encabezado y Pié /////
  late TextEditingController businessNameTextController =
      TextEditingController();
  late TextEditingController businessAddressTextController =
      TextEditingController();
  late TextEditingController vatConditionTextController =
      TextEditingController();
  late TextEditingController documentTypeTextController =
      TextEditingController();
  late TextEditingController checkoutAisleNumberTextController =
      TextEditingController();
  bool isCheckoutAisleNumberValid = true;
  late TextEditingController documentNumberTextController =
      TextEditingController();
  bool isDocumentNumberValid = true;
  late TextEditingController issueDateTextController = TextEditingController();
  bool isIssueDateValid = true;
  late TextEditingController sellerCuitTextController = TextEditingController();
  bool isSellerCuitNumberValid = true;
  late TextEditingController grossIncomeTextController =
      TextEditingController();
  late TextEditingController businessOpeningDateTextController =
      TextEditingController();
  bool isBusinessOpeningDateValid = true;
  late TextEditingController clientCuitTextController = TextEditingController();
  bool isClientCuitNumberValid = true;
  late TextEditingController clientNameTextController = TextEditingController();
  late TextEditingController clientVatConditionTextController =
      TextEditingController();
  late TextEditingController clientAddressTextController =
      TextEditingController();
  late TextEditingController saleMethodTextController = TextEditingController();

  // late TextEditingController currencyTextController = TextEditingController();
  late TextEditingController exchangeRateTextController =
      TextEditingController();
  bool isExchangeRateNumberValid = true;
  late TextEditingController netAmountTaxedTextController =
      TextEditingController();
  bool isNetAmountTaxedNumberValid = true;
  late TextEditingController subtotalFooterTextController =
      TextEditingController();
  late TextEditingController vat27TextController = TextEditingController();
  bool isvat27NumberValid = true;
  late TextEditingController vat21TextController = TextEditingController();
  bool isvat21NumberValid = true;
  late TextEditingController vat10_5TextController = TextEditingController();
  bool isvat10_5NumberValid = true;
  late TextEditingController vat5TextController = TextEditingController();
  bool isvat5NumberValid = true;
  late TextEditingController vat2_5TextController = TextEditingController();
  bool isvat2_5NumberValid = true;
  late TextEditingController vat0TextController = TextEditingController();
  bool isvat0NumberValid = true;
  late TextEditingController otherTaxesAmountTextController =
      TextEditingController();
  bool isOtherTaxesAmountNumberValid = true;
  late TextEditingController totalTextController = TextEditingController();
  bool isTotalNumberValid = true;

  ///// Items /////
  late TextEditingController codTextController = TextEditingController();
  late TextEditingController titleTextController = TextEditingController();
  late TextEditingController amountTextController = TextEditingController();
  bool isAmountNumberValid = true;
  late TextEditingController measureTextController = TextEditingController();
  late TextEditingController unitPriceTextController = TextEditingController();
  bool isUnitPriceNumberValid = true;
  late TextEditingController discountPercTextController =
      TextEditingController();
  bool isDiscountPercNumberValid = true;
  late TextEditingController subtotalTextController = TextEditingController();
  bool isSubtotalPercNumberValid = true;
  late TextEditingController ivaFeeTextController = TextEditingController();
  late TextEditingController subtotalIncFeesTextController =
      TextEditingController();
  bool isSubtotalIncFeesNumberValid = true;
  late TextEditingController discountedSubtotalTextController =
      TextEditingController();
  bool isDiscountedSubtotalPercNumberValid = true;

  @override
  void initPage({PageArgs? arguments}) {
    args = arguments;
    ///// Encabezado y Pié /////
    businessNameTextController.addListener(
        () => invoice?.header?.businessName = businessNameTextController.text);
    businessAddressTextController.addListener(() =>
        invoice?.header?.businessAddress = businessNameTextController.text);
    // vatConditionTextController.addListener(
    //     () => invoice?.header?.vatCondition = vatConditionTextController.text);
    documentTypeTextController.addListener(
        () => invoice?.header?.documentType = documentTypeTextController.text);
    checkoutAisleNumberTextController.addListener(() {
      invoice?.header?.checkoutAisleNumber =
          checkoutAisleNumberTextController.text;
      isCheckoutAisleNumberValid = isInt(
        checkoutAisleNumberTextController.text,
      );
      setState(() {});
    });
    documentNumberTextController.addListener(() {
      invoice?.header?.documentNumber = documentNumberTextController.text;
      isDocumentNumberValid = isInt(documentNumberTextController.text);
      setState(() {});
    });
    issueDateTextController.addListener(() {
      invoice?.header?.issueDate = issueDateTextController.text;
      isIssueDateValid = isStringAValidDate(issueDateTextController.text);
      setState(() {});
    });
    sellerCuitTextController.addListener(() {
      invoice?.header?.sellerCuit = sellerCuitTextController.text;
      isSellerCuitNumberValid = isInt(sellerCuitTextController.text);
      invoice?.setOperationType(sellerCuitTextController.text);
      operationType = invoice?.operationType?.name ?? "Compra";
      setState(() {});
    });
    grossIncomeTextController.addListener(
        () => invoice?.header?.grossIncome = grossIncomeTextController.text);
    businessOpeningDateTextController.addListener(() {
      invoice?.header?.businessOpeningDate =
          businessOpeningDateTextController.text;
      isBusinessOpeningDateValid =
          isStringAValidDate(businessOpeningDateTextController.text);
      setState(() {});
    });
    clientCuitTextController.addListener(() {
      invoice?.header?.clientCuit = clientCuitTextController.text;
      isClientCuitNumberValid = isInt(
        clientCuitTextController.text,
      );
      setState(() {});
    });
    clientNameTextController.addListener(
        () => invoice?.header?.clientName = clientNameTextController.text);
    // clientVatConditionTextController.addListener(() =>
    //     invoice?.header?.vatCondition = clientVatConditionTextController.text);
    clientAddressTextController.addListener(() =>
        invoice?.header?.clientAddress = clientAddressTextController.text);
    saleMethodTextController.addListener(
        () => invoice?.header?.saleMethod = saleMethodTextController.text);

    // currencyTextController.addListener(
    //     () => invoice?.footer?.currency = currencyTextController.text);
    exchangeRateTextController.addListener(() {
      invoice?.footer?.exchangeRate = exchangeRateTextController.text;
      isExchangeRateNumberValid = isDouble(exchangeRateTextController.text);
      setState(() {});
    });
    netAmountTaxedTextController.addListener(() {
      invoice?.footer?.netAmountTaxed = netAmountTaxedTextController.text;
      isNetAmountTaxedNumberValid = isDouble(netAmountTaxedTextController.text);
      setState(() {});
    });
    subtotalFooterTextController.addListener(() {
      invoice?.footer?.subtotal = subtotalFooterTextController.text;
    });
    vat27TextController.addListener(() {
      invoice?.footer?.vat27 = vat27TextController.text;
      isvat27NumberValid = isDouble(vat27TextController.text);
      setState(() {});
    });
    vat21TextController.addListener(() {
      invoice?.footer?.vat21 = vat21TextController.text;
      isvat21NumberValid = isDouble(vat21TextController.text);
      setState(() {});
    });
    vat10_5TextController.addListener(() {
      invoice?.footer?.vat10_5 = vat10_5TextController.text;
      isvat10_5NumberValid = isDouble(vat10_5TextController.text);
      setState(() {});
    });
    vat5TextController.addListener(() {
      invoice?.footer?.vat5 = vat5TextController.text;
      isvat5NumberValid = isDouble(vat5TextController.text);
      setState(() {});
    });
    vat2_5TextController.addListener(() {
      invoice?.footer?.vat2_5 = vat2_5TextController.text;
      isvat2_5NumberValid = isDouble(vat2_5TextController.text);
      setState(() {});
    });
    vat0TextController.addListener(() {
      invoice?.footer?.vat0 = vat0TextController.text;
      isvat0NumberValid = isDouble(vat0TextController.text);
      setState(() {});
    });
    otherTaxesAmountTextController.addListener(() {
      invoice?.footer?.otherTaxesAmount = otherTaxesAmountTextController.text;
      isOtherTaxesAmountNumberValid =
          isDouble(otherTaxesAmountTextController.text);
      setState(() {});
    });
    totalTextController.addListener(() {
      invoice?.footer?.total = totalTextController.text;
      isTotalNumberValid = isDouble(totalTextController.text);
      setState(() {});
    });

    ///// Items /////
    // Ambos
    codTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex].cod = codTextController.text);
    titleTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex].title = titleTextController.text);
    amountTextController.addListener(() {
      invoice?.items?[currentlyDisplayedItemIndex].amount =
          amountTextController.text;
      isAmountNumberValid = isDouble(amountTextController.text);
      setState(() {});
    });
    measureTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex]
        .measure = measureTextController.text);
    unitPriceTextController.addListener(() {
      invoice?.items?[currentlyDisplayedItemIndex].unitPrice =
          unitPriceTextController.text;
      isUnitPriceNumberValid = isDouble(unitPriceTextController.text);
      setState(() {});
    });
    discountPercTextController.addListener(() {
      invoice?.items?[currentlyDisplayedItemIndex].discountPerc =
          discountPercTextController.text;
      isDiscountPercNumberValid = isDouble(discountPercTextController.text);
      setState(() {});
    });
    subtotalTextController.addListener(() {
      invoice?.items?[currentlyDisplayedItemIndex].subtotal =
          subtotalTextController.text;
      isSubtotalPercNumberValid = isDouble(subtotalTextController.text);
      setState(() {});
    });
    // A
    ivaFeeTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex]
        .vatFee = ivaFeeTextController.text);
    subtotalIncFeesTextController.addListener(() {
      invoice?.items?[currentlyDisplayedItemIndex].subtotalIncFees =
          subtotalIncFeesTextController.text;
      isSubtotalIncFeesNumberValid =
          isDouble(subtotalIncFeesTextController.text);
      setState(() {});
    });
    // C
    discountedSubtotalTextController.addListener(() {
      invoice?.items?[currentlyDisplayedItemIndex].discountedSubtotal =
          discountedSubtotalTextController.text;
      isDiscountedSubtotalPercNumberValid =
          isDouble(discountedSubtotalTextController.text);
      setState(() {});
    });

    if (args != null && args!.invoice != null) {
      invoice = args!.invoice!;
      operationType = invoice?.operationType?.name ?? "Compra";
      ///// Encabezado y Pié /////
      businessNameTextController.text = invoice?.header?.businessName ?? "";
      businessAddressTextController.text =
          invoice?.header?.businessAddress ?? "";
      // vatConditionTextController.text = invoice?.header?.vatCondition ?? "";
      documentTypeTextController.text = invoice?.header?.documentType ?? "";
      checkoutAisleNumberTextController.text =
          invoice?.header?.checkoutAisleNumber ?? "";
      documentNumberTextController.text = invoice?.header?.documentNumber ?? "";
      issueDateTextController.text = invoice?.header?.issueDate ?? "";
      sellerCuitTextController.text = invoice?.header?.sellerCuit ?? "";
      grossIncomeTextController.text = invoice?.header?.grossIncome ?? "";
      businessOpeningDateTextController.text =
          invoice?.header?.businessOpeningDate ?? "";
      clientCuitTextController.text = invoice?.header?.clientCuit ?? "";
      clientNameTextController.text = invoice?.header?.clientName ?? "";
      // clientVatConditionTextController.text =
      //     invoice?.header?.clientVatCondition ?? "";
      clientAddressTextController.text = invoice?.header?.clientAddress ?? "";
      saleMethodTextController.text = invoice?.header?.saleMethod ?? "";

      // currencyTextController.text = invoice?.footer?.currency ?? "";
      exchangeRateTextController.text = invoice?.footer?.exchangeRate ?? "";
      netAmountTaxedTextController.text = invoice?.footer?.netAmountTaxed ?? "";
      subtotalFooterTextController.text = invoice?.footer?.subtotal ?? "";
      vat27TextController.text = invoice?.footer?.vat27 ?? "";
      vat21TextController.text = invoice?.footer?.vat21 ?? "";
      vat10_5TextController.text = invoice?.footer?.vat10_5 ?? "";
      vat5TextController.text = invoice?.footer?.vat5 ?? "";
      vat2_5TextController.text = invoice?.footer?.vat2_5 ?? "";
      vat0TextController.text = invoice?.footer?.vat0 ?? "";
      otherTaxesAmountTextController.text =
          invoice?.footer?.otherTaxesAmount ?? "";
      totalTextController.text = invoice?.footer?.total ?? "";

      ///// Items /////

      codTextController.text = invoice?.items?.first.cod ?? "";
      titleTextController.text = invoice?.items?.first.title ?? "";
      amountTextController.text = invoice?.items?.first.amount ?? "";
      measureTextController.text = invoice?.items?.first.measure ?? "";
      unitPriceTextController.text = invoice?.items?.first.unitPrice ?? "";
      discountPercTextController.text =
          invoice?.items?.first.discountPerc ?? "";
      subtotalTextController.text = invoice?.items?.first.subtotal ?? "";
      ivaFeeTextController.text = invoice?.items?.first.vatFee ?? "";
      subtotalIncFeesTextController.text =
          invoice?.items?.first.subtotalIncFees ?? "";
      discountedSubtotalTextController.text =
          invoice?.items?.first.discountedSubtotal ?? "";
    }
  }

  @override
  disposePage() {}

  void onPressTab() {
    tabs.updateAll((name, value) => value = !value);
    setState(() {});
  }

  void changeCurrentlyDisplayedItem() {
    item = invoice!.items![currentlyDisplayedItemIndex];
    codTextController.text = item?.cod ?? "";
    titleTextController.text = item?.title ?? "";
    amountTextController.text = item?.amount ?? "";
    measureTextController.text = item?.measure ?? "";
    unitPriceTextController.text = item?.unitPrice ?? "";
    discountPercTextController.text = item?.discountPerc ?? "";
    subtotalTextController.text = item?.subtotal ?? "";
    ivaFeeTextController.text = item?.vatFee ?? "";
    subtotalIncFeesTextController.text = item?.subtotalIncFees ?? "";
    discountedSubtotalTextController.text = item?.discountedSubtotal ?? "";
  }

  Future<DateTime?> onPressCalendar(String date) async {
    DateTime? newDate = await PageManager().openCalendarPopUp(date);
    return newDate;
  }

  bool isStringAValidDate(String textToValidate) {
    return isDateValid(textToValidate) &&
        DateFormat('dd/MM/yy').parse(textToValidate).isBefore(DateTime.now());
  }

  void changeCurrency(String? currencySelected) {
    invoice?.footer?.currencyType = CurrencyTypeEnum.values
        .firstWhereOrNull((element) => element.code == currencySelected);
    setState(() {});
  }

  void changeVatCondition(String? vatConditionSelected) {
    invoice?.header?.vatCondition = AFIPResponsabilityTypeEnuum.values
        .firstWhereOrNull((element) => element.name == vatConditionSelected);
    setState(() {});
  }

  void changeClientVatCondition(String? clientVatConditionSelected) {
    invoice?.header?.clientVatCondition = AFIPResponsabilityTypeEnuum.values
        .firstWhereOrNull(
            (element) => element.name == clientVatConditionSelected);
    setState(() {});
  }

  bool formValid() {
    return isCheckoutAisleNumberValid &&
        isDocumentNumberValid &&
        isSellerCuitNumberValid &&
        isClientCuitNumberValid &&
        isExchangeRateNumberValid &&
        isNetAmountTaxedNumberValid &&
        isvat27NumberValid &&
        isvat21NumberValid &&
        isvat10_5NumberValid &&
        isvat5NumberValid &&
        isvat2_5NumberValid &&
        isvat0NumberValid &&
        isOtherTaxesAmountNumberValid &&
        isTotalNumberValid &&
        isAmountNumberValid &&
        isUnitPriceNumberValid &&
        isDiscountPercNumberValid &&
        isSubtotalPercNumberValid &&
        isSubtotalIncFeesNumberValid &&
        isDiscountedSubtotalPercNumberValid &&
        isIssueDateValid &&
        isBusinessOpeningDateValid;
  }

  void generateCsvFiles() async {
    List<List<dynamic>> data = buildCsvBody();
    await LoadingPopup(
      context: PageManager().navigatorKey.currentContext!,
      onLoading: saveCsv(data),
      onResult: (data) {},
      onError: (error) => showErrorPopUp(error.toString()),
    ).show();
  }

  List<List<dynamic>> buildCsvBody() {
    List<List<dynamic>> data = [];
    List<dynamic> row = [];
    row = [
      "Razón Social",
      "Domicilio Comercial",
      "Condición frente al IVA",
      "Tipo de Documento",
      "Punto de Venta",
      "Comp. Nro",
      "Fecha de Emisión",
      "CUIT",
      "Ingresos Brutos",
      "Fecha de Inicio de Actividades",
      "CUIT",
      "Apellido y Nombre / Razón Social",
      "Condición frente al IVA",
      "Domicilio Comercial",
      "Condición de venta",
      "Moneda",
      "Tipo de Cambio",
      "Importe Neto Grabado",
      "IVA 27%",
      "IVA 21%",
      "IVA 10.5%",
      "IVA 5%",
      "IVA 2.5%",
      "IVA 0%",
      "Importe Otros Tributos",
      "Total",
    ];
    data.add(row);
    row = [
      invoice?.header?.businessName,
      invoice?.header?.businessAddress,
      invoice?.header?.vatCondition?.name,
      invoice?.header?.documentType,
      invoice?.header?.checkoutAisleNumber,
      invoice?.header?.documentNumber,
      invoice?.header?.issueDate,
      invoice?.header?.sellerCuit,
      invoice?.header?.grossIncome,
      invoice?.header?.businessOpeningDate,
      invoice?.header?.clientCuit,
      invoice?.header?.clientName,
      invoice?.header?.clientVatCondition?.name,
      invoice?.header?.clientAddress,
      invoice?.header?.saleMethod,
      invoice?.footer?.currencyType?.code,
      invoice?.footer?.exchangeRate,
      invoice?.footer?.netAmountTaxed,
      invoice?.footer?.vat27,
      invoice?.footer?.vat21,
      invoice?.footer?.vat10_5,
      invoice?.footer?.vat5,
      invoice?.footer?.vat2_5,
      invoice?.footer?.vat0,
      invoice?.footer?.otherTaxesAmount,
      invoice?.footer?.total,
    ];
    data.add(row);
    return data;
  }

  saveCsv(List<List<dynamic>> data) async {
    PermissionStatusEnum? permission = await checkStoragePermission();
    switch (permission) {
      case PermissionStatusEnum.granted:
        String path =
            "${invoice?.header?.documentType}_${invoice?.header?.documentNumber}_encabezado.csv";

        String? downloadsDirectory = await getDownloadPath();
        String filePath = downloadsDirectory! + path;
        File f = File(filePath);
        // convert rows to String and write as csv file
        String csv = const ListToCsvConverter().convert(data);
        f.writeAsString(csv);

        //Open file
        path = f.path;
        if (path.isEmpty) {
          throw "Archivo no encontrado";
        }
        OpenResult result = await OpenFile.open(path, type: "text/csv");
        switch (result.type) {
          case ResultType.done:
            return result;
          case ResultType.noAppToOpen:
            throw "El archivo se ha descargado correctamente en el dispositivo pero no tienes una aplicación para abrir este archivo";
          case ResultType.permissionDenied:
            throw "La aplicación no recibió los permisos necesarios para abrir el archivo";
          default:
            break;
        }
        break;
      case PermissionStatusEnum.permanentlyDenied:
        PageManager().openPermanentlyDeniedWarningPopUp(
            "El permiso de la cámara se denegó permanentemente, si desea puede modificarlo en las configuraciones de la aplicación");
        break;
      case PermissionStatusEnum.denied:
      default:
    }
  }

  checkStoragePermission() async {
    Map<permission_handler.Permission, permission_handler.PermissionStatus>
        statuses = await [
      permission_handler.Permission.storage,
    ].request();

    return PermissionStatusEnum.values.firstWhereOrNull((element) =>
        element.name == statuses[permission_handler.Permission.storage]!.name);
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download/');

        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      debugPrint("No se pudo encontrar la carpeta de descargas");
    }
    return directory?.path;
  }

  void showErrorPopUp(String error) {
    PageManager().openDefaultErrorAlert(error);
  }
}
