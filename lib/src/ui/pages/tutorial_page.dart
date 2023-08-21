import 'dart:io';

import 'package:extructura_app/src/ui/components/buttons/rounded_button_component.dart';
import 'package:extructura_app/values/k_values.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/src/ui/components/menu/menu_component.dart';
import 'package:extructura_app/utils/page_args.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import '../../managers/data_manager.dart';
import '../components/appbar/custom_navigation_bar_component.dart';
import '../page_controllers/tutorial_page_controller.dart';

class TutorialPage extends StatefulWidget {
  final PageArgs? args;
  const TutorialPage(this.args, {Key? key}) : super(key: key);

  @override
  TutorialPageState createState() => TutorialPageState();
}

class TutorialPageState extends StateMVC<TutorialPage> {
  late TutorialPageController _con;

  TutorialPageState() : super(TutorialPageController()) {
    _con = TutorialPageController.con;
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    _con.initPage(arguments: widget.args);
    super.initState();
  }

  @override
  void dispose() {
    _con.pageController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Platform.isWindows ? _desktopBody() : _mobileBody(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: KBackground,
        key: _key,
        drawer: MenuComponent(
          closeMenu: () => {_key.currentState!.openEndDrawer()},
        ),
        appBar: !DataManager().isFirstSession() && !Platform.isWindows
            ? simpleNavigationBar(
                title: "Tutorial",
                hideInfoButton: true,
                hideNotificationButton: true,
                onMenu: () => {_key.currentState!.openDrawer()},
              )
            : null,
        body: Platform.isWindows ? _desktopBody() : _mobileBody(),
      ),
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
                    height: MediaQuery.of(context).size.height - 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height -
                                (DataManager().isFirstSession() ? 142 : 197),
                            child: _pageView(isMobile: false),
                          ),
                          _desktopButtons(),
                          SizedBox(
                            height: DataManager().isFirstSession() ? 50 : 20,
                          ),
                          _pageViewIndicator(),
                        ],
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  _mobileBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Expanded(child: _pageView(isMobile: true)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _pageViewIndicator(),
          ),
        ],
      ),
    );
  }

  _desktopButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            _con.pageController.animateToPage(_con.currentPage - 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          },
          style: TextButton.styleFrom(
            backgroundColor: _con.currentPage != 0 ? KGrey : KGrey_L2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(0),
          ),
          child: Container(
            padding: const EdgeInsets.all(0),
            height: 40,
            width: 125,
            child: const Center(
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  "Atras",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: KWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: KFontSizeLarge40,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        RoundedButton(
          onPressed: () {
            _con.currentPage == 3
                ? _con.onStartTap()
                : _con.pageController.animateToPage(_con.currentPage + 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
          },
          width: 125,
          fontWeight: FontWeight.w700,
          text: _con.currentPage == 3 ? "¡Empezar!" : "Siguiente",
        ),
      ],
    );
  }

  _pageView({required bool isMobile}) {
    return PageView(
      controller: _con.pageController,
      onPageChanged: (int page) {
        setState(() {
          _con.currentPage = page;
        });
      },
      physics: isMobile
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      children: [
        const TutorialSinglePage(
          title: "Bienvenido a Extructura",
          imagePath: "images/tutorial/tuto_1.png",
          description:
              "Para comenzar toca en el recuadro blanco con el ícono de la cámara para ingresar una foto de tu factura.\n\nRecuerda que puedes traerla de una foto, una imágen de galería o de una página de un archivo pdf.",
        ),
        const TutorialSinglePage(
          imagePath: "images/tutorial/tuto_2.gif",
          description:
              "Automáticamente se selecionará el formáto de la imágen que cargaste pero puedes cambiarlo si consideras que no es el correcto\n\nLuego toca \"Analizar Factura\" en el botón de abajo para comenzar la extración de datos.",
        ),
        const TutorialSinglePage(
          imagePath: "images/tutorial/tuto_3.gif",
          description:
              "Una vez recuperados los datos verifica que estos sean correctos.\nNo olvides ir a la pestaña productos para verificar sus datos también.\n\nCuando esté todo en orden toca \"Generar CSVs\" en el botón de abajo para generar los archivos csv de la factura.",
        ),
        TutorialSinglePage(
          imagePath: "images/tutorial/tuto_4.png",
          description:
              "¡Listo! Los archivos generados se encuentran en la carpeta de descargas del dispositivo.\n\nSi aún tienes alguna duda consulta la sección FAQ del menú.",
          onTapButton: isMobile
              ? () {
                  _con.onStartTap();
                }
              : null,
          buttonText: "¡Empezar!",
        ),
      ],
    );
  }

  _pageViewIndicator() {
    return PageViewDotIndicator(
      currentItem: _con.currentPage,
      count: 4,
      unselectedColor: KGrey_L2,
      selectedColor: KPrimary,
      duration: const Duration(milliseconds: 200),
      unselectedSize: const Size(8, 8),
    );
  }
}

class TutorialSinglePage extends StatelessWidget {
  final String? title;
  final String imagePath;
  final String description;
  final Function? onTapButton;
  final String? buttonText;

  const TutorialSinglePage({
    super.key,
    this.title,
    required this.imagePath,
    required this.description,
    this.onTapButton,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (title != null) ...[
            Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: KFontSizeXXLarge70,
                color: KGrey,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
          Image.asset(
            imagePath,
            width: MediaQuery.of(context).size.width /
                (Platform.isWindows ? 6 : 2),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: KFontSizeLarge40, color: KGrey),
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: onTapButton != null,
            child: RoundedButton(
              onPressed: () => onTapButton!(),
              width: MediaQuery.of(context).size.width /
                  (Platform.isWindows ? 5 : 2),
              fontWeight: FontWeight.w700,
              text: buttonText,
            ),
          )
        ],
      ),
    );
  }
}
