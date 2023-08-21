import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/src/interfaces/i_view_controller.dart';
import 'package:extructura_app/utils/page_args.dart';

import '../../managers/data_manager.dart';
import '../../managers/page_manager/page_manager.dart';

class TutorialPageController extends ControllerMVC implements IViewController {
  static late TutorialPageController _this;

  factory TutorialPageController() {
    _this = TutorialPageController._();
    return _this;
  }

  static TutorialPageController get con => _this;
  TutorialPageController._();
  PageArgs? args;

  late PageController pageController;
  int currentPage = 0;

  @override
  void initPage({PageArgs? arguments}) {
    pageController = PageController();
  }

  @override
  disposePage() {}

  void onStartTap() {
    if (DataManager().isFirstSession()) {
      DataManager().saveFirstSession(false);
      PageManager().goHomePage();
    } else {
      PageManager().goBack();
    }
  }
}
