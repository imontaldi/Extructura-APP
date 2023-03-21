import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:extructura_app/utils/app_localizations.dart';

extension BoolParsing on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}

extension IsNullOrEmpty on String? {
  bool isNullOrEmpty() {
    return (this == null || this!.isEmpty);
  }
}

extension HasValue on String? {
  bool hasValue() {
    return (this != null && this!.isNotEmpty);
  }
}

extension IsEmailFormatCorrect on String {
  bool isEmailFormatCorrect() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}

extension CapitalizeString on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension Translate on String {
  String translate() {
    return AppLocalizations.of(PageManager().navigatorKey.currentContext!)!
        .translate(this);
  }
}
