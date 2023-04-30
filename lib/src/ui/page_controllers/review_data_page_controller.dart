import 'dart:core';

import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:extructura_app/src/models/api_Invoice_models/invoice_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/item_model.dart';
import 'package:extructura_app/utils/functions_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/src/interfaces/i_view_controller.dart';
import 'package:extructura_app/utils/page_args.dart';

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
  late TextEditingController documentNumberTextController =
      TextEditingController();
  late TextEditingController issueDateTextController = TextEditingController();
  late TextEditingController sellerCuitTextController = TextEditingController();
  late TextEditingController grossIncomeTextController =
      TextEditingController();
  late TextEditingController businessOpeningDateTextController =
      TextEditingController();
  late TextEditingController clientCuitTextController = TextEditingController();
  late TextEditingController clientNameTextController = TextEditingController();
  late TextEditingController clientVatConditionTextController =
      TextEditingController();
  late TextEditingController clientAddressTextController =
      TextEditingController();
  late TextEditingController saleMethodTextController = TextEditingController();

  late TextEditingController currencyTextController = TextEditingController();
  late TextEditingController otherTaxesAmountTextController =
      TextEditingController();
  late TextEditingController totalTextController = TextEditingController();
  late TextEditingController exchangeRateTextController =
      TextEditingController();
  late TextEditingController netAmountTaxedTextController =
      TextEditingController();
  late TextEditingController subtotalFooterTextController =
      TextEditingController();
  late TextEditingController vat27TextController = TextEditingController();
  late TextEditingController vat21TextController = TextEditingController();
  late TextEditingController vat10_5TextController = TextEditingController();
  late TextEditingController vat5TextController = TextEditingController();
  late TextEditingController vat2_5TextController = TextEditingController();
  late TextEditingController vat0TextController = TextEditingController();

  ///// Items /////
  late TextEditingController codTextController = TextEditingController();
  late TextEditingController titleTextController = TextEditingController();
  late TextEditingController amountTextController = TextEditingController();
  late TextEditingController measureTextController = TextEditingController();
  late TextEditingController unitPriceTextController = TextEditingController();
  late TextEditingController discountPercTextController =
      TextEditingController();
  late TextEditingController subtotalTextController = TextEditingController();
  late TextEditingController ivaFeeTextController = TextEditingController();
  late TextEditingController subtotalIncFeesTextController =
      TextEditingController();
  late TextEditingController discountedSubtotalTextController =
      TextEditingController();

  @override
  void initPage({PageArgs? arguments}) {
    args = arguments;
    ///// Encabezado y Pié /////
    businessNameTextController.addListener(
        () => invoice?.header?.businessName = businessNameTextController.text);
    businessAddressTextController.addListener(() =>
        invoice?.header?.businessAddress = businessNameTextController.text);
    vatConditionTextController.addListener(
        () => invoice?.header?.vatCondition = vatConditionTextController.text);
    documentTypeTextController.addListener(
        () => invoice?.header?.documentType = documentTypeTextController.text);
    checkoutAisleNumberTextController.addListener(() => invoice
        ?.header?.checkoutAisleNumber = checkoutAisleNumberTextController.text);
    documentNumberTextController.addListener(() =>
        invoice?.header?.documentNumber = documentNumberTextController.text);
    issueDateTextController.addListener(
        () => invoice?.header?.issueDate = issueDateTextController.text);
    sellerCuitTextController.addListener(
        () => invoice?.header?.sellerCuit = sellerCuitTextController.text);
    grossIncomeTextController.addListener(
        () => invoice?.header?.grossIncome = grossIncomeTextController.text);
    businessOpeningDateTextController.addListener(() => invoice
        ?.header?.businessOpeningDate = businessOpeningDateTextController.text);
    clientCuitTextController.addListener(
        () => invoice?.header?.clientCuit = clientCuitTextController.text);
    clientNameTextController.addListener(
        () => invoice?.header?.clientName = clientNameTextController.text);
    clientVatConditionTextController.addListener(() =>
        invoice?.header?.vatCondition = clientVatConditionTextController.text);
    clientAddressTextController.addListener(() =>
        invoice?.header?.clientAddress = clientAddressTextController.text);
    saleMethodTextController.addListener(
        () => invoice?.header?.saleMethod = saleMethodTextController.text);

    currencyTextController.addListener(
        () => invoice?.footer?.currency = currencyTextController.text);
    otherTaxesAmountTextController.addListener(() => invoice
        ?.footer?.otherTaxesAmount = otherTaxesAmountTextController.text);
    totalTextController
        .addListener(() => invoice?.footer?.total = totalTextController.text);
    exchangeRateTextController.addListener(
        () => invoice?.footer?.exchangeRate = exchangeRateTextController.text);
    netAmountTaxedTextController.addListener(() =>
        invoice?.footer?.netAmountTaxed = netAmountTaxedTextController.text);
    subtotalFooterTextController.addListener(
        () => invoice?.footer?.subtotal = subtotalFooterTextController.text);
    vat27TextController
        .addListener(() => invoice?.footer?.vat27 = vat27TextController.text);
    vat21TextController
        .addListener(() => invoice?.footer?.vat21 = vat21TextController.text);
    vat10_5TextController.addListener(
        () => invoice?.footer?.vat10_5 = vat10_5TextController.text);
    vat5TextController
        .addListener(() => invoice?.footer?.vat5 = vat5TextController.text);
    vat2_5TextController
        .addListener(() => invoice?.footer?.vat2_5 = vat2_5TextController.text);
    vat0TextController
        .addListener(() => invoice?.footer?.vat0 = vat0TextController.text);

    ///// Items /////
    // Ambos
    codTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex].cod = codTextController.text);
    titleTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex].title = titleTextController.text);
    amountTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex]
        .amount = amountTextController.text);
    measureTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex]
        .measure = measureTextController.text);
    unitPriceTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex]
        .unitPrice = unitPriceTextController.text);
    discountPercTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex]
        .discountPerc = discountPercTextController.text);
    subtotalTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex]
        .subtotal = subtotalTextController.text);
    // A
    ivaFeeTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex]
        .vatFee = ivaFeeTextController.text);
    subtotalIncFeesTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex]
        .subtotalIncFees = subtotalIncFeesTextController.text);
    // C
    discountedSubtotalTextController.addListener(() => invoice
        ?.items?[currentlyDisplayedItemIndex]
        .discountedSubtotal = discountedSubtotalTextController.text);

    if (args != null && args!.invoice != null) {
      invoice = args!.invoice!;
      ///// Encabezado y Pié /////
      businessNameTextController.text = invoice?.header?.businessName ?? "";
      businessAddressTextController.text =
          invoice?.header?.businessAddress ?? "";
      vatConditionTextController.text = invoice?.header?.vatCondition ?? "";
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
      clientVatConditionTextController.text =
          invoice?.header?.clientVatCondition ?? "";
      clientAddressTextController.text = invoice?.header?.clientAddress ?? "";
      saleMethodTextController.text = invoice?.header?.saleMethod ?? "";

      currencyTextController.text = invoice?.footer?.currency ?? "";
      otherTaxesAmountTextController.text =
          invoice?.footer?.otherTaxesAmount ?? "";
      totalTextController.text = invoice?.footer?.total ?? "";
      exchangeRateTextController.text = invoice?.footer?.exchangeRate ?? "";
      netAmountTaxedTextController.text = invoice?.footer?.netAmountTaxed ?? "";
      subtotalFooterTextController.text = invoice?.footer?.subtotal ?? "";
      vat27TextController.text = invoice?.footer?.vat27 ?? "";
      vat21TextController.text = invoice?.footer?.vat21 ?? "";
      vat10_5TextController.text = invoice?.footer?.vat10_5 ?? "";
      vat5TextController.text = invoice?.footer?.vat5 ?? "";
      vat2_5TextController.text = invoice?.footer?.vat2_5 ?? "";
      vat0TextController.text = invoice?.footer?.vat0 ?? "";

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
}
