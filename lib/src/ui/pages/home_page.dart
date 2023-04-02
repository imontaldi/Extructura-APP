import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/src/ui/components/appbar/custom_navigation_bar_component.dart';
import 'package:extructura_app/src/ui/components/buttons/rounded_button_component.dart';
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
      child: Scaffold(
        backgroundColor: KBackground,
        key: _key,
        drawer: MenuComponent(
          closeMenu: () => {_key.currentState!.openEndDrawer()},
        ),
        appBar: simpleNavigationBar(
          title: "Página Principal",
          hideInfoButton: true,
          hideNotificationButton: true,
          onMenu: () => {_key.currentState!.openDrawer()},
        ),
        body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _con.title,
                      style: const TextStyle(
                        fontSize: KFontSizeXXLarge50,
                        fontWeight: FontWeight.w700,
                        color: KGrey,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ImageUploadComponent(
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
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RoundedButton(
                      onPressed: () async {
                        await _con.onAnalizeInvoice();
                      },
                      text: "Analizar",
                      width: double.infinity,
                      fontSize: KFontSizeLarge40,
                      fontWeight: FontWeight.bold,
                      isEnabled: _con.image != null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
