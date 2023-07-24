import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/src/interfaces/i_view_controller.dart';
import 'package:extructura_app/utils/page_args.dart';

import '../../managers/data_manager.dart';
import '../../models/faq_model.dart';

class FAQPageController extends ControllerMVC implements IViewController {
  static late FAQPageController _this;

  factory FAQPageController() {
    _this = FAQPageController._();
    return _this;
  }

  static FAQPageController get con => _this;
  FAQPageController._();
  PageArgs? args;

  bool forceUpdate = false;
  List<FAQModel>? listFaqModel = [];

  @override
  void initPage({PageArgs? arguments}) {}

  @override
  disposePage() {}

  Future<void> getFAQList() async {
    forceUpdate = false;
    listFaqModel = await DataManager().getFaqList();
  }

  retryButton() {
    setState(() {
      forceUpdate = true;
    });
  }
}
