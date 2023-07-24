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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: KBackground,
        key: _key,
        drawer: MenuComponent(
          closeMenu: () => {_key.currentState!.openEndDrawer()},
        ),
        appBar: !DataManager().isFirstSession()
            ? simpleNavigationBar(
                title: "Tutorial",
                hideInfoButton: true,
                hideNotificationButton: true,
                onMenu: () => {_key.currentState!.openDrawer()},
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _con.pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _con.currentPage = page;
                    });
                  },
                  physics: const BouncingScrollPhysics(),
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
                      onTapButton: () {
                        _con.onStartTap();
                      },
                      buttonText: "¡Empezar!",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PageViewDotIndicator(
                  currentItem: _con.currentPage,
                  count: 4,
                  unselectedColor: KGrey_L2,
                  selectedColor: KPrimary,
                  duration: const Duration(milliseconds: 200),
                  unselectedSize: const Size(8, 8),
                ),
              ),
            ],
          ),
        ),
      ),
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
            width: MediaQuery.of(context).size.width / 2,
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
              width: MediaQuery.of(context).size.width / 2,
              fontWeight: FontWeight.w700,
              text: buttonText,
            ),
          )
        ],
      ),
    );
  }
}
