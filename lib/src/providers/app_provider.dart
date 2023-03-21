import 'dart:async';

import 'package:flutter/material.dart';
import 'package:extructura_app/src/enums/culture.dart';
import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:extructura_app/src/models/culture_model.dart';

class AppProvider with ChangeNotifier {
  static final AppProvider _instance = AppProvider._constructor();

  factory AppProvider() {
    return _instance;
  }

  AppProvider._constructor();

  List<CultureModel> languageList = [
    CultureModel(id: 1, language: "Español", code: Culture.es),
    CultureModel(id: 2, language: "Inglés", code: Culture.en),
  ];

  Timer? _timer;
  Timer? get timer => _timer;

  Timer? _timerInit;
  Timer? get timerInit => _timerInit;

  init() {}

  closeAlert() {
    _timerInit?.cancel();
    ScaffoldMessenger.of(PageManager().navigatorKey.currentContext!)
        .hideCurrentMaterialBanner();
  }
}
