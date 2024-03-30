import 'dart:io';

import 'package:extructura_app/src/ui/pages/tutorial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:extructura_app/src/enums/culture.dart';
import 'package:extructura_app/src/managers/data_manager.dart';
import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:extructura_app/src/support/futuristic.dart';
import 'package:extructura_app/src/ui/components/common/loading_component.dart';
import 'package:extructura_app/src/ui/pages/home_page.dart';
import 'package:extructura_app/utils/app_localizations.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:window_manager/window_manager.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    setWindowTitle("Extructura");
    await windowManager.ensureInitialized();

    WindowManager.instance.setMinimumSize(const Size(1368, 760));
    WindowManager.instance.setMaximumSize(const Size(1368, 760));
  }

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    MyHomePageState? state = context.findAncestorStateOfType<MyHomePageState>();
    state!.changeLanguage(newLocale);
  }

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyApp> {
  Locale? _locale;

  @override
  Widget build(BuildContext context) {
    //_initApp(context);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: KPrimary));
    _locale = Locale(getCode(DataManager().selectedCulture), '');
    return MaterialApp(
      supportedLocales: const [
        Locale('es', 'es-AR'),
      ],
      navigatorKey: PageManager().navigatorKey,
      locale: _locale,
      onGenerateRoute: (settings) {
        return PageManager().getRoute(settings);
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Extructura',
      theme: ThemeData(
        fontFamily: 'Sans',
        scrollbarTheme: ScrollbarThemeData(
          trackColor: MaterialStateProperty.all(Colors.grey),
          thumbColor: MaterialStateProperty.all(KGrey_L3),
          trackBorderColor: MaterialStateProperty.all(Colors.grey),
          trackVisibility: MaterialStateProperty.all(true),
        ),
        //primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _home(),
    );
  }

  _home() {
    return Futuristic<void>(
      autoStart: true,
      futureBuilder: () => _initApp(),
      busyBuilder: (context) => Container(
        height: MediaQuery.of(context).size.height,
        color: KWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [loadingComponent(true, backgroundColor: Colors.white)],
        ),
      ),
      dataBuilder: (context, data) => _initPage(),
      errorBuilder: (context, error, retry) => _initPage(),
    );
  }

  _initPage() {
    if (DataManager().isFirstSession()) {
      return const TutorialPage(null);
    }

    return const HomePage(null);
  }

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  getCode(Culture code) {
    switch (code) {
      case Culture.es:
        return 'es';
      case Culture.en:
        return 'en';
    }
  }

  _initApp() async {
    //AppSettings.init(context);
    await DataManager().init();
  }
}
