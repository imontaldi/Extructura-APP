import 'package:extructura_app/src/interfaces/i_item_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/invoice_model.dart';
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
  IItemModel? item;
  int currentlyDisplayedItemIndex = 0;

  late TextEditingController codTextController;
  late TextEditingController titleTextController;

  @override
  void initPage({PageArgs? arguments}) {
    args = arguments;
    codTextController = TextEditingController();
    titleTextController = TextEditingController();

    if (args != null && args!.invoice != null) {
      invoice = args!.invoice!;
      codTextController.text = invoice?.items?.first.cod ?? "";
      titleTextController.text = invoice?.items?.first.title ?? "";
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
  }
}
