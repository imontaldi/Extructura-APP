import 'dart:math';

import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:extructura_app/src/ui/components/appbar/custom_navigation_bar_component.dart';
import 'package:extructura_app/src/ui/components/buttons/rounded_button_component.dart';
import 'package:extructura_app/src/ui/components/entry/text_input_component.dart';
import 'package:extructura_app/src/ui/page_controllers/review_data_page_controller.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/utils/page_args.dart';

class ReviewDataPage extends StatefulWidget {
  final PageArgs? args;
  const ReviewDataPage(this.args, {Key? key}) : super(key: key);

  @override
  ReviewDataPageState createState() => ReviewDataPageState();
}

class ReviewDataPageState extends StateMVC<ReviewDataPage> {
  late ReviewDataPageController _con;

  ReviewDataPageState() : super(ReviewDataPageController()) {
    _con = ReviewDataPageController.con;
  }

  @override
  void initState() {
    _con.initPage(arguments: widget.args);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: KBackground,
        appBar: simpleNavigationBar(
          title: "Carga de imágen",
          hideInfoButton: true,
          hideNotificationButton: true,
          onBack: PageManager().goBack,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(),
                const SizedBox(
                  height: 15,
                ),
                _tabs(),
                const SizedBox(
                  height: 15,
                ),
                _body(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Factura Venta",
      style: TextStyle(
        fontSize: KFontSizeXXLarge50,
        fontWeight: FontWeight.w700,
        color: KGrey,
      ),
    );
  }

  Widget _tabs() {
    return Container(
      decoration: BoxDecoration(
        color: KWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: _con.tabs.entries
            .toList()
            .map(
              (entry) => Expanded(
                child: RoundedButton(
                  onPressed: () {
                    _con.onPressTab();
                  },
                  width: double.infinity,
                  borderRadius: 12,
                  text: entry.key,
                  fontSize: KFontSizeLarge40,
                  fontWeight: FontWeight.w500,
                  borderColor: KTransparent,
                  backgroundColor: entry.value ? KPrimary : KWhite,
                  textColor: entry.value ? KWhite : KPrimary,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _body() {
    if (_con.tabs.entries.firstWhere((element) => element.value == true).key ==
        "Encabezado") {
      return _headerBody();
    }
    return _detailBody();
  }

  Widget _headerBody() {
    return Container();
  }

  Widget _detailBody() {
    return Column(
      children: [
        TextInputComponent(
          controller: TextEditingController(),
          backgroundColor: KWhite,
          title: "Cod.",
        ),
        // const SizedBox(height: 10),
        // TextInputComponent(controller: TextEditingController()),
        // const SizedBox(height: 10),
        // TextInputComponent(controller: TextEditingController()),
        // const SizedBox(height: 10),
        // TextInputComponent(controller: TextEditingController()),
        // const SizedBox(height: 10),
        // TextInputComponent(controller: TextEditingController()),
        // const SizedBox(height: 10),
        // TextInputComponent(controller: TextEditingController()),
        // const SizedBox(height: 10),
        // TextInputComponent(controller: TextEditingController()),
        // const SizedBox(height: 10),
        // TextInputComponent(controller: TextEditingController()),
      ],
    );
  }
}
