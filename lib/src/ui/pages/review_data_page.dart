import 'package:extructura_app/src/enums/input_type_enum.dart';
import 'package:extructura_app/src/enums/invoice_type_enum.dart';
import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:extructura_app/src/ui/components/appbar/custom_navigation_bar_component.dart';
import 'package:extructura_app/src/ui/components/buttons/rounded_button_component.dart';
import 'package:extructura_app/src/ui/components/entry/text_input_component.dart';
import 'package:extructura_app/src/ui/page_controllers/review_data_page_controller.dart';
import 'package:extructura_app/utils/functions_util.dart';
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
          title: "Revisión de datos",
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
        ..._sectionTitle("Datos del Emisor"),
        const SizedBox(height: 10),
        ..._headerTransmitterSectionInputs(),
        const SizedBox(height: 20),
        ..._sectionTitle("Datos del Documento"),
        const SizedBox(height: 10),
        ..._headerDocInfoSectionInputs(),
        const SizedBox(height: 20),
        ..._sectionTitle("Datos del Receptor"),
        const SizedBox(height: 10),
        ..._headerReceiverSectionInputs(),
        const SizedBox(height: 20),
        ..._sectionTitle("Totales"),
        const SizedBox(height: 10),
        ..._headerFooterSectionInputs(),
      ],
    );
  }

  List<Widget> _sectionTitle(String title) {
    return [
      Text(
        title,
        style: const TextStyle(
          color: KGrey,
          fontSize: KFontSizeLarge40,
          fontWeight: FontWeight.w500,
        ),
      ),
      const Divider(
        thickness: 2,
      ),
    ];
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
        keyboardType: const TextInputType.numberWithOptions(decimal: false),
        isValid: _con.isCheckoutAisleNumberValid,
        title: "Punto de Venta",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.documentNumberTextController,
        keyboardType: const TextInputType.numberWithOptions(decimal: false),
        isValid: _con.isDocumentNumberValid,
        title: "Comp. Nro",
      ),
      const SizedBox(height: 10),
      _dateInput(
        "Fecha de Emisión",
        _con.issueDateTextController,
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.sellerCuitTextController,
        keyboardType: const TextInputType.numberWithOptions(decimal: false),
        isValid: _con.isSellerCuitNumberValid,
        title: "CUIT",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.grossIncomeTextController,
        title: "Ingresos Brutos",
      ),
      const SizedBox(height: 10),
      _dateInput("Fecha de Inicio de Actividades",
          _con.businessOpeningDateTextController),
    ];
  }

  List<Widget> _headerReceiverSectionInputs() {
    return [
      TextInputComponent(
        controller: _con.clientCuitTextController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        isValid: _con.isClientCuitNumberValid,
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

  List<Widget> _headerFooterSectionInputs() {
    return [
      TextInputComponent(
        controller: _con.currencyTextController,
        title: "Moneda",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.exchangeRateTextController,
        title: "Tipo de Cambio",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.netAmountTaxedTextController,
        title: "Importe Neto Grabado",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.vat27TextController,
        title: "IVA 27%",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.vat21TextController,
        title: "IVA 21%",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.vat10_5TextController,
        title: "IVA 10.5%",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.vat5TextController,
        title: "IVA 5%",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.vat2_5TextController,
        title: "IVA 2.5%",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.vat0TextController,
        title: "IVA 0%",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.otherTaxesAmountTextController,
        title: "Importe Otros Tributos",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.totalTextController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        isValid: _con.isTotalNumberValid,
        title: "Total",
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

  Widget _dateInput(String title, TextEditingController controller) {
    return TextInputComponent(
      controller: controller,
      title: title,
      inputType: InputTypeEnum.date,
      onPress: () async {
        controller.text =
            dateFormat(await _con.onPressCalendar(controller.text));
        setState(() {});
      },
      isEnabled: true,
      isValid: _con.isStringAValidDate(controller.text),
      errorPlaceHolder: controller.text,
      rightIcon: Image.asset(
        "images/icon_calendar.png",
        height: 20,
        width: 20,
        color: _con.isStringAValidDate(controller.text) ? KGrey : KRed,
      ),
    );
  }
}
