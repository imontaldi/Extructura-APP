import 'package:extructura_app/src/ui/pages/review_data_page.dart';
import 'package:flutter/material.dart';
import 'package:extructura_app/src/enums/page_names.dart';
import 'package:extructura_app/src/managers/data_manager.dart';
import 'package:extructura_app/src/providers/app_provider.dart';
import 'package:extructura_app/src/ui/pages/home_page.dart';
import 'package:extructura_app/src/ui/pages/pdf_view_page.dart';
import 'package:extructura_app/src/ui/popups/information_alert_popup.dart';
import 'package:extructura_app/utils/app_localizations.dart';
import 'package:extructura_app/utils/page_args.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';

part 'popups/page_manager.popup.dart';

class PageManager with PageManagerPopUp {
  static final PageManager _instance = PageManager._constructor();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  PageNames? currentPage;

  factory PageManager() {
    return _instance;
  }

  PageNames? getPageNameEnum(String? pageName) {
    try {
      return PageNames.values.where((x) => x.toString() == pageName).single;
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return null;
  }

  PageManager._constructor();

  MaterialPageRoute? getRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    PageArgs? arguments;

    if (settings.arguments != null) {
      arguments = settings.arguments as PageArgs;
    }

    PageNames? page = getPageNameEnum(settings.name);
    currentPage = page;

    switch (page) {
      // --------- COMMONS ---------
      case PageNames.home:
        return MaterialPageRoute(builder: (context) => HomePage(arguments));
      case PageNames.pdfView:
        return MaterialPageRoute(builder: (context) => PdfViewPage(arguments));
      case PageNames.reviewData:
        return MaterialPageRoute(
            builder: (context) => ReviewDataPage(arguments));

      default:
    }
    return null;
  }

  // ignore: unused_element
  _goPage(String pageName,
      {PageArgs? args,
      Function(PageArgs? args)? actionBack,
      bool makeRootPage = false}) {
    if (!makeRootPage) {
      return navigatorKey.currentState
          ?.pushNamed(pageName, arguments: args)
          .then((value) {
        if (actionBack != null) actionBack(value as PageArgs?);
      });
    } else {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
          pageName, (route) => false,
          arguments: args);
    }
  }

  goBack({PageArgs? args, PageNames? specificPage}) {
    if (specificPage != null) {
      navigatorKey.currentState!
          .popAndPushNamed(specificPage.toString(), arguments: args);
    } else {
      Navigator.pop(navigatorKey.currentState!.overlay!.context, args);
    }
  }

  goRootPage() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  goDoLogout() {
    AppProvider().closeAlert();
    DataManager().cleanData();
    //goLoginPage();
  }

  goHomePage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.home.toString(),
        makeRootPage: true, args: args, actionBack: actionBack);
  }

  goPdfViewPage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.pdfView.toString(), args: args, actionBack: actionBack);
  }

  goReviewDataPage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.reviewData.toString(),
        args: args, actionBack: actionBack);
  }

  goTestPage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.test.toString(), args: args, actionBack: actionBack);
  }
}
