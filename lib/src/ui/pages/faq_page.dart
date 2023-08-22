import 'dart:io';

import 'package:extructura_app/values/k_values.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/src/ui/components/menu/menu_component.dart';
import 'package:extructura_app/utils/page_args.dart';
import 'package:extructura_app/values/k_colors.dart';
import '../../support/futuristic.dart';
import '../components/appbar/custom_navigation_bar_component.dart';
import '../components/buttons/rounded_button_component.dart';
import '../components/common/faq_card_component.dart';
import '../components/common/loading_component.dart';
import '../page_controllers/faq_page_controller.dart';

class FAQPage extends StatefulWidget {
  final PageArgs? args;
  const FAQPage(this.args, {Key? key}) : super(key: key);

  @override
  FAQPageState createState() => FAQPageState();
}

class FAQPageState extends StateMVC<FAQPage> {
  late FAQPageController _con;

  FAQPageState() : super(FAQPageController()) {
    _con = FAQPageController.con;
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    _con.initPage(arguments: widget.args);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Platform.isWindows ? _desktopBody() : _mobileBody(),
    );
  }

  _desktopBody() {
    return Scaffold(
      body: Row(
        children: [
          MenuComponent(
            closeMenu: () => {},
            width: MediaQuery.of(context).size.width * 0.22,
          ),
          Expanded(
            child: Column(
              children: [
                simpleNavigationBar(
                  title: "Preguntas frecuentes",
                  hideInfoButton: true,
                  hideNotificationButton: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 60,
                  child: _content(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _mobileBody() {
    return Scaffold(
      backgroundColor: KBackground,
      key: _key,
      drawer: MenuComponent(
        closeMenu: () => {_key.currentState!.openEndDrawer()},
      ),
      appBar: simpleNavigationBar(
        title: "Preguntas frecuentes",
        hideInfoButton: true,
        hideNotificationButton: true,
        onMenu: () => {_key.currentState!.openDrawer()},
      ),
      body: _content(),
    );
  }

  _content() {
    return Futuristic<void>(
      autoStart: true,
      forceUpdate: _con.forceUpdate,
      futureBuilder: () => _con.getFAQList(),
      busyBuilder: (context) => SizedBox(
          height: (MediaQuery.of(context).size.height - 60) / 2,
          child: loadingComponent(true, backgroundColor: KBackground)),
      dataBuilder: (context, data) => _faqList(),
      errorBuilder: (context, error, retry) => _error(),
      //onError: (error, retry) => onErrorFunction(error: error as HttpResult, onRetry: retry),
    );
  }

  _faqList() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.separated(
        itemBuilder: (context, index) => FaqCardComponent(
          title: _con.listFaqModel?[index].question ?? "Pregunta",
          description: _con.listFaqModel?[index].answer ?? "Respuesta",
        ),
        itemCount: _con.listFaqModel?.length ?? 0,
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
      ),
    );
  }

  _error() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "images/icon_error.png",
            color: KGrey_T2,
            height: 28,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: const Text(
            "Ha ocurrido un error. \n Por favor intente nuevamente más tarde",
            style: TextStyle(
              fontSize: KFontSizeMedium35,
              color: KGrey_T2,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        RoundedButton(
          onPressed: _con.retryButton,
          text: "Reintentar",
          backgroundColor: KPrimary,
          width: MediaQuery.of(context).size.width / 1.75,
        ),
      ],
    );
  }
}
