import 'dart:io';

import 'package:extructura_app/src/enums/image_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/src/ui/components/appbar/custom_navigation_bar_component.dart';
import 'package:extructura_app/src/ui/components/entry/images/image_upload_component.dart';
import 'package:extructura_app/src/ui/components/menu/menu_component.dart';
import 'package:extructura_app/src/ui/page_controllers/home_page_controller.dart';
import 'package:extructura_app/utils/page_args.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';

class HomePage extends StatefulWidget {
  final PageArgs? args;
  const HomePage(this.args, {Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends StateMVC<HomePage> {
  late HomePageController _con;

  HomePageState() : super(HomePageController()) {
    _con = HomePageController.con;
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    _con.initPage(arguments: widget.args);
    super.initState();
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
                  title: "Carga de imágen",
                  hideInfoButton: true,
                  hideNotificationButton: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 63,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: LayoutBuilder(
                          builder: (context, constraints) =>
                              ImageUploadComponent(
                            getFile: (file) {
                              setState(() {
                                _con.image = file;
                              });
                            },
                            deleteFile: () => setState(() {
                              _con.image = null;
                            }),
                            file: _con.image,
                            editImageAfterPick: false,
                            cropRatio: 210 / 297,
                            height: double.maxFinite,
                            width: constraints.maxHeight * (210 / 297),
                            imageTypePicked: (imageType) {
                              _con.setSelectedRadio(imageType.value);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _con.image != null,
                        child: Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Tipo de imágen subida",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: KFontSizeLarge40,
                                    fontWeight: FontWeight.w500,
                                    color: KGrey,
                                  ),
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  layoutBehavior:
                                      ButtonBarLayoutBehavior.constrained,
                                  children: getImageTypeOptionsByPlatform(),
                                ),
                                Flexible(
                                  child: Container(
                                    height: double.infinity,
                                  ),
                                ),
                                footer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
        title: "Carga de imágen",
        hideInfoButton: true,
        hideNotificationButton: true,
        onMenu: () => {_key.currentState!.openDrawer()},
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _content(),
              ),
            ),
          ),
          footer(),
        ],
      ),
    );
  }

  _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageUploadComponent(
          getFile: (file) {
            setState(() {
              _con.image = file;
            });
          },
          deleteFile: () => setState(() {
            _con.image = null;
          }),
          file: _con.image,
          editImageAfterPick: true,
          cropRatio: 210 / 297,
          height: (MediaQuery.of(context).size.width - 40) * (297 / 210),
          width: MediaQuery.of(context).size.width - 40,
          imageTypePicked: (imageType) {
            _con.setSelectedRadio(imageType.value);
          },
        ),
        Visibility(
          visible: _con.image != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Tipo de imágen subida",
                style: TextStyle(
                  fontSize: KFontSizeLarge40,
                  fontWeight: FontWeight.w500,
                  color: KGrey,
                ),
              ),
              ButtonBar(
                children: getImageTypeOptionsByPlatform(),
              )
            ],
          ),
        )
      ],
    );
  }

  List<Widget> getImageTypeOptionsByPlatform() {
    List<Widget> outList = [];
    outList.add(radioOption(ImageTypeEnum.values[0]));
    if (!Platform.isWindows) {
      outList.add(radioOption(ImageTypeEnum.values[1]));
    }
    if (Platform.isWindows) {
      outList.add(radioOption(ImageTypeEnum.values[2]));
    }
    return outList;
  }

  Widget radioOption(ImageTypeEnum imageType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          activeColor: KPrimary,
          value: imageType.value,
          groupValue: _con.imageType?.value,
          onChanged: (value) => _con.setSelectedRadio(value),
        ),
        Text(imageType.name),
      ],
    );
  }

  Widget footer() {
    return InkWell(
      onTap: () async {
        _con.image != null ? await _con.onAnalizeInvoice() : null;
      },
      child: Container(
        height: 50,
        color: _con.image != null ? KPrimary : KGrey_L3,
        child: Center(
          child: Text(
            "Analizar factura",
            style: TextStyle(
              color: _con.image != null ? KWhite : KWhite,
              fontSize: KFontSizeLarge40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
