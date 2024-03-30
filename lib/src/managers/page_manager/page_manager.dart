import 'package:extructura_app/src/ui/pages/faq_page.dart';
import 'package:extructura_app/src/ui/pages/review_data_page.dart';
import 'package:extructura_app/src/ui/pages/tutorial_page.dart';
import 'package:extructura_app/src/ui/popups/calendar_popup.dart';
import 'package:flutter/material.dart';
import 'package:extructura_app/src/enums/page_names.dart';
import 'package:extructura_app/src/managers/data_manager.dart';
import 'package:extructura_app/src/ui/pages/home_page.dart';
import 'package:extructura_app/src/ui/pages/pdf_view_page.dart';
import 'package:extructura_app/src/ui/popups/information_alert_popup.dart';
import 'package:extructura_app/utils/app_localizations.dart';
import 'package:extructura_app/utils/page_args.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

part 'popups/page_manager.popup.dart';

class PageManager with PageManagerPopUp {
  static final PageManager _instance = PageManager._constructor();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  PageNames? currentPage;
  List<PageNames> stackPages = [];

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
      case PageNames.tutorial:
        return MaterialPageRoute(builder: (context) => TutorialPage(arguments));
      case PageNames.faq:
        return MaterialPageRoute(builder: (context) => FAQPage(arguments));

      default:
    }
    return null;
  }

  _goPage(PageNames pageName,
      {PageArgs? args,
      Function(PageArgs? args)? actionBack,
      bool makeRootPage = false}) {
    if (currentPage != pageName) {
      if (stackPages.isEmpty || pageName != stackPages.last) {
        if (!makeRootPage) {
          stackPages.add(pageName);
          return navigatorKey.currentState!
              .pushNamed(pageName.toString(), arguments: args)
              .then((value) {
            if (actionBack != null) {
              actionBack(value != null ? (value as PageArgs) : null);
            }
          });
        } else {
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
              pageName.toString(), (route) => false,
              arguments: args);
          stackPages.clear();
          stackPages.add(pageName);
        }
      }
    }
  }

  ///Quita paginas de la pila de navegacion hasta llegar a la vista especificada. Lanza una excepcion si esta vista no se encuentra en la pila de navegacion actual.
  ///[specificPage] indica la vista a la que se quiere volver.
  ///Adicionalmente, [thenGo] da la posibilidad de navegar a una nueva vista luego de hacer el goBack.
  void goBackToSpecificPage({
    required PageNames specificPage,
    PageArgs? args,
    PageNames? thenGo,
    Function(PageArgs?)? actionBack,
  }) {
    if (!stackPages.contains(specificPage)) {
      throw Exception(
          "La vista especificada no existe en la pila de navegación actual");
    }
    Navigator.popUntil(
      navigatorKey.currentContext!,
      (route) {
        if (stackPages.last == specificPage || stackPages.length == 1) {
          return true;
        } else {
          stackPages.removeLast();
          return false;
        }
      },
    );
    if (thenGo != null) {
      _goPage(
        thenGo,
        args: args,
        actionBack: actionBack,
      );
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
    DataManager().cleanData();
    //goLoginPage();
  }

  goHomePage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.home,
        makeRootPage: true, args: args, actionBack: actionBack);
  }

  goPdfViewPage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.pdfView, args: args, actionBack: actionBack);
  }

  goReviewDataPage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.reviewData, args: args, actionBack: actionBack);
  }

  goTutorialPage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.tutorial, args: args, actionBack: actionBack);
  }

  goFAQPage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.faq, args: args, actionBack: actionBack);
  }

  goTestPage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(PageNames.test, args: args, actionBack: actionBack);
  }
}
