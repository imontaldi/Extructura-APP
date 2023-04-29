import 'package:extructura_app/src/models/api_Invoice_models/invoice_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/item_model.dart';
import 'package:flutter/widgets.dart';
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
  late TextEditingController businessNameTextController;
  late TextEditingController businessAddressTextController;
  late TextEditingController vatConditionTextController;
  late TextEditingController documentTypeTextController;
  late TextEditingController checkoutAisleNumberTextController;
  late TextEditingController documentNumberTextController;
  late TextEditingController issueDateTextController;
  late TextEditingController sellerCuitTextController;
  late TextEditingController grossIncomeTextController;
  late TextEditingController businessOpeningDateTextController;
  late TextEditingController clientCuitTextController;
  late TextEditingController clientNameTextController;
  late TextEditingController clientVatConditionTextController;
  late TextEditingController clientAddressTextController;
  late TextEditingController saleMethodTextController;

  ///// Items /////
  late TextEditingController codTextController;
  late TextEditingController titleTextController;
  late TextEditingController amountTextController;
  late TextEditingController measureTextController;
  late TextEditingController unitPriceTextController;
  late TextEditingController discountPercTextController;
  late TextEditingController subtotalTextController;
  late TextEditingController ivaFeeTextController;
  late TextEditingController subtotalIncFeesTextController;
  late TextEditingController discountedSubtotalTextController;

  @override
  void initPage({PageArgs? arguments}) {
    args = arguments;
    ///// Encabezado y Pié /////
    businessNameTextController = TextEditingController();
    businessAddressTextController = TextEditingController();
    vatConditionTextController = TextEditingController();
    documentTypeTextController = TextEditingController();
    checkoutAisleNumberTextController = TextEditingController();
    documentNumberTextController = TextEditingController();
    issueDateTextController = TextEditingController();
    sellerCuitTextController = TextEditingController();
    grossIncomeTextController = TextEditingController();
    businessOpeningDateTextController = TextEditingController();
    clientCuitTextController = TextEditingController();
    clientNameTextController = TextEditingController();
    clientVatConditionTextController = TextEditingController();
    clientAddressTextController = TextEditingController();
    saleMethodTextController = TextEditingController();

    ///// Items /////
    // Ambos
    codTextController = TextEditingController();
    titleTextController = TextEditingController();
    amountTextController = TextEditingController();
    measureTextController = TextEditingController();
    unitPriceTextController = TextEditingController();
    discountPercTextController = TextEditingController();
    subtotalTextController = TextEditingController();
    // A
    ivaFeeTextController = TextEditingController();
    subtotalIncFeesTextController = TextEditingController();
    // C
    discountedSubtotalTextController = TextEditingController();

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

      ///// Items /////

      codTextController.text = invoice?.items?.first.cod ?? "";
      titleTextController.text = invoice?.items?.first.title ?? "";
      amountTextController.text = invoice?.items?.first.amount ?? "";
      measureTextController.text = invoice?.items?.first.measure ?? "";
      unitPriceTextController.text = invoice?.items?.first.unitPrice ?? "";
      discountPercTextController.text =
          invoice?.items?.first.discountPerc ?? "";
      subtotalTextController.text = invoice?.items?.first.subtotal ?? "";
      ivaFeeTextController.text = invoice?.items?.first.ivaFee ?? "";
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
    ivaFeeTextController.text = item?.ivaFee ?? "";
    subtotalIncFeesTextController.text = item?.subtotalIncFees ?? "";
    discountedSubtotalTextController.text = item?.discountedSubtotal ?? "";
  }
}
