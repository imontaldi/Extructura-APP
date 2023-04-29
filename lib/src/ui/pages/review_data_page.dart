import 'package:extructura_app/src/enums/invoice_type_enum.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Datos del Emisor",
          style: TextStyle(
            color: KGrey,
            fontSize: KFontSizeLarge40,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Divider(
          thickness: 2,
        ),
        const SizedBox(height: 10),
        ..._headerTransmitterSectionInputs(),
        const SizedBox(height: 20),
        const Text(
          "Datos del Documento",
          style: TextStyle(
            color: KGrey,
            fontSize: KFontSizeLarge40,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Divider(
          thickness: 2,
        ),
        const SizedBox(height: 10),
        ..._headerDocInfoSectionInputs(),
        const SizedBox(height: 20),
        const Text(
          "Datos del Receptor",
          style: TextStyle(
            color: KGrey,
            fontSize: KFontSizeLarge40,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Divider(
          thickness: 2,
        ),
        const SizedBox(height: 10),
        ..._headerReceiverSectionInputs(),
      ],
    );
  }

  List<Widget> _headerTransmitterSectionInputs() {
    return [
      TextInputComponent(
        controller: _con.businessNameTextController,
        title: "Razón Social",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.businessAddressTextController,
        title: "Domicilio Comercial",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.vatConditionTextController,
        title: "Condición Frente al IVA",
      ),
    ];
  }

  List<Widget> _headerDocInfoSectionInputs() {
    return [
      TextInputComponent(
        controller: _con.documentTypeTextController,
        title: "Tipo de Documento",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.checkoutAisleNumberTextController,
        title: "Punto de Venta",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.documentNumberTextController,
        title: "Comp. Nro",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.issueDateTextController,
        title: "Fecha de Emisión",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.sellerCuitTextController,
        title: "CUIT",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.grossIncomeTextController,
        title: "Ingresos Brutos",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.businessOpeningDateTextController,
        title: "Fecha de Inicio de Actividades",
      ),
    ];
  }

  List<Widget> _headerReceiverSectionInputs() {
    return [
      TextInputComponent(
        controller: _con.clientCuitTextController,
        title: "CUIT",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.clientNameTextController,
        title: "Apellido y Nombre / Razón Social",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.clientVatConditionTextController,
        title: "Condición frente al IVA",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.clientAddressTextController,
        title: "Domicilio Comercial",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.saleMethodTextController,
        title: "Condición de venta",
      ),
    ];
  }

  Widget _detailBody() {
    return Column(
      children: [
        _itemNumberPagination(),
        const Divider(
          thickness: 2,
        ),
        const SizedBox(height: 10),
        ..._detailInputs(),
      ],
    );
  }

  Widget _itemNumberPagination() {
    int index = _con.currentlyDisplayedItemIndex;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Producto ${index + 1}",
          style: const TextStyle(
            color: KGrey,
            fontSize: KFontSizeLarge40,
            fontWeight: FontWeight.w500,
          ),
        ),
        Visibility(
          visible: (_con.invoice?.items?.length ?? 0) > 1,
          child: Row(
            children: [
              GestureDetector(
                onTap: _con.currentlyDisplayedItemIndex > 0
                    ? () {
                        setState(() {
                          _con.currentlyDisplayedItemIndex--;
                          _con.changeCurrentlyDisplayedItem();
                        });
                      }
                    : () {},
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "images/icon_page_arrow_left.png",
                    color: _con.currentlyDisplayedItemIndex > 0
                        ? KGrey_L1
                        : KGrey_L4,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: _con.currentlyDisplayedItemIndex <
                        (_con.invoice?.items?.length ?? 0) - 1
                    ? () {
                        setState(() {
                          _con.currentlyDisplayedItemIndex++;
                          _con.changeCurrentlyDisplayedItem();
                        });
                      }
                    : () {},
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "images/icon_page_arrow_right.png",
                    color: _con.currentlyDisplayedItemIndex <
                            (_con.invoice?.items?.length ?? 0) - 1
                        ? KGrey_L1
                        : KGrey_L4,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  List<Widget> _detailInputs() {
    return [
      TextInputComponent(
        controller: _con.codTextController,
        title: "Código",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.titleTextController,
        title: "Producto / Servicio",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.amountTextController,
        title: "Cantidad",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.measureTextController,
        title: "U. medida",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.unitPriceTextController,
        title: "Precio Unit.",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.discountPercTextController,
        title: "% Bonif",
      ),
      Visibility(
        visible: _con.invoice?.type == InvoiceTypeEnum.C,
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextInputComponent(
              controller: _con.discountPercTextController,
              title: "Imp. Bonif.",
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.subtotalTextController,
        title: "Subtotal",
      ),
      Visibility(
        visible: _con.invoice?.type == InvoiceTypeEnum.A,
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextInputComponent(
              controller: _con.ivaFeeTextController,
              title: "Alícuota IVA",
            ),
            const SizedBox(height: 10),
            TextInputComponent(
              controller: _con.subtotalIncFeesTextController,
              title: "Subtotal c/IVA",
            ),
          ],
        ),
      ),
    ];
  }
}
