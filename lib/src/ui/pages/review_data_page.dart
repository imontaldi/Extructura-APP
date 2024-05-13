import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:extructura_app/src/enums/afip_responsability_types_enum.dart';
import 'package:extructura_app/src/enums/currency_type_enum.dart';
import 'package:extructura_app/src/enums/input_type_enum.dart';
import 'package:extructura_app/src/enums/invoice_type_enum.dart';
import 'package:extructura_app/src/ui/components/appbar/custom_navigation_bar_component.dart';
import 'package:extructura_app/src/ui/components/buttons/rounded_button_component.dart';
import 'package:extructura_app/src/ui/components/entry/text_input_component.dart';
import 'package:extructura_app/src/ui/page_controllers/review_data_page_controller.dart';
import 'package:extructura_app/utils/functions_util.dart';
import 'package:extructura_app/utils/scroll_behaviour.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/utils/page_args.dart';

import '../components/common/tooltip_shape_border_component.dart';
import '../components/menu/menu_component.dart';

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
    return WillPopScope(
      onWillPop: () => _con.onBack(),
      child: SafeArea(
        child: Platform.isWindows ? _desktopBody() : _mobileBody(),
      ),
    );
  }

  Widget _desktopBody() {
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
                appbar(),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 110,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        _title(),
                        const SizedBox(height: 5),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _desktopSection("Encabezado", _headerBody()),
                              const SizedBox(width: 5),
                              const VerticalDivider(
                                thickness: 3,
                                color: KGrey_L2,
                              ),
                              const SizedBox(width: 5),
                              _desktopSection("Detalle", _detailBody())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _footer(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _desktopSection(String title, Widget body) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _desktopSectionTitle(title),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: body,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _desktopSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: KFontSizeLarge40,
        fontWeight: FontWeight.w500,
        color: KGrey,
      ),
    );
  }

  Widget _mobileBody() {
    return Scaffold(
      backgroundColor: KBackground,
      appBar: appbar(),
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: CustomScrollBehaviour(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: _footer(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget appbar() {
    return simpleNavigationBar(
      title: "Revisión de datos",
      hideInfoButton: true,
      hideNotificationButton: true,
      onBack: () => _con.onBack(),
    );
  }

  Widget _title() {
    return Row(
      children: [
        Text(
          "Factura ${_con.operationType}",
          style: const TextStyle(
            fontSize: KFontSizeXXLarge50,
            fontWeight: FontWeight.w700,
            color: KGrey,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Tooltip(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          textAlign: TextAlign.center,
          showDuration: Duration(seconds: 10),
          margin: EdgeInsets.symmetric(horizontal: 80),
          richMessage: TextSpan(
            style: TextStyle(
              color: KWhite,
              fontSize: KFontSizeSmall30,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text:
                    "El tipo de operacion que representa la factura depende del CUIT del emisor. Si este título no corresponde al tipo de operación, verifique que el CUIT sea el correcto",
              ),
            ],
          ),
          decoration: ShapeDecoration(
            shape: TooltipShapeBorder(),
            color: KGrey,
          ),
          triggerMode: TooltipTriggerMode.tap,
          child: Icon(
            CupertinoIcons.question_circle,
            size: 20,
          ),
        ),
      ],
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
      _dropDownNew(
        title: "Condición frente al IVA",
        list: AFIPResponsabilityTypeEnuum.values.map((e) => e.name).toList(),
        currentValue: _con.invoice?.header?.vatCondition?.name,
        onValueChanged: (newValue) {
          _con.changeVatCondition(newValue);
        },
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
        _con.isIssueDateValid,
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
      _dateInput(
        "Fecha de Inicio de Actividades",
        _con.businessOpeningDateTextController,
        _con.isBusinessOpeningDateValid,
      ),
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
      _dropDownNew(
        title: "Condición frente al IVA",
        list: AFIPResponsabilityTypeEnuum.values.map((e) => e.name).toList(),
        currentValue: _con.invoice?.header?.clientVatCondition?.name,
        onValueChanged: (newValue) {
          _con.changeClientVatCondition(newValue);
        },
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
      _dropDownNew(
        title: "Moneda",
        list: CurrencyTypeEnum.values.map((e) => e.code).toList(),
        currentValue: _con.invoice?.footer?.currencyType?.code,
        onValueChanged: (newValue) {
          _con.changeCurrency(newValue);
        },
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.exchangeRateTextController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        isValid: _con.isExchangeRateNumberValid,
        title: "Tipo de Cambio",
      ),
      Visibility(
        visible: _con.invoice?.type == InvoiceTypeEnum.A,
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextInputComponent(
              controller: _con.netAmountTaxedTextController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              isValid: _con.isNetAmountTaxedNumberValid,
              title: "Importe Neto Grabado",
            ),
            if (_con.invoice?.footer?.netAmountUntaxed != null) ...[
              const SizedBox(height: 10),
              TextInputComponent(
                controller: _con.netAmountUntaxedTextController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                isValid: _con.isNetAmountUntaxedNumberValid,
                title: "Importe Neto No Grabado",
              ),
            ],
            const SizedBox(height: 10),
            TextInputComponent(
              controller: _con.vat27TextController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              isValid: _con.isvat27NumberValid,
              title: "IVA 27%",
            ),
            const SizedBox(height: 10),
            TextInputComponent(
              controller: _con.vat21TextController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              isValid: _con.isvat21NumberValid,
              title: "IVA 21%",
            ),
            const SizedBox(height: 10),
            TextInputComponent(
              controller: _con.vat10_5TextController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              isValid: _con.isvat10_5NumberValid,
              title: "IVA 10.5%",
            ),
            const SizedBox(height: 10),
            TextInputComponent(
              controller: _con.vat5TextController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              isValid: _con.isvat5NumberValid,
              title: "IVA 5%",
            ),
            const SizedBox(height: 10),
            TextInputComponent(
              controller: _con.vat2_5TextController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              isValid: _con.isvat2_5NumberValid,
              title: "IVA 2.5%",
            ),
            const SizedBox(height: 10),
            TextInputComponent(
              controller: _con.vat0TextController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              isValid: _con.isvat0NumberValid,
              title: "IVA 0%",
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.otherTaxesAmountTextController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        isValid: _con.isOtherTaxesAmountNumberValid,
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
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        isValid: _con.isAmountNumberValid,
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
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        isValid: _con.isUnitPriceNumberValid,
        title: "Precio Unit.",
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.discountPercTextController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        isValid: _con.isDiscountPercNumberValid,
        title: "% Bonif",
      ),
      Visibility(
        visible: _con.invoice?.type == InvoiceTypeEnum.C,
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextInputComponent(
              controller: _con.discountedSubtotalTextController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              isValid: _con.isDiscountedSubtotalPercNumberValid,
              title: "Imp. Bonif.",
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      TextInputComponent(
        controller: _con.subtotalTextController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        isValid: _con.isSubtotalPercNumberValid,
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              isValid: _con.isSubtotalIncFeesNumberValid,
              title: "Subtotal c/IVA",
            ),
          ],
        ),
      ),
    ];
  }

  Widget _dateInput(
      String title, TextEditingController controller, bool isValid) {
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
      isValid: isValid,
      errorPlaceHolder: controller.text,
      rightIcon: Image.asset(
        "images/icon_calendar.png",
        height: 20,
        width: 20,
        color: _con.isStringAValidDate(controller.text) ? KGrey : KRed,
      ),
    );
  }

  Widget _dropDownNew(
      {bool isEnabled = true,
      required List<String> list,
      String? title,
      String? currentValue,
      required Function(String?) onValueChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: const TextStyle(
            color: KGrey,
            fontSize: KFontSizeMedium35,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Container(
          alignment: Alignment.center,
          height: 38,
          decoration: BoxDecoration(
            color: KWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton2(
            underline: const SizedBox.shrink(),
            isExpanded: true,
            iconStyleData: const IconStyleData(
              icon: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 25,
                ),
              ),
            ),
            buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1)))),
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: currentValue,
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 1,
            ),
            onChanged: isEnabled
                ? (String? newValue) {
                    onValueChanged(newValue);
                  }
                : null,
            style: const TextStyle(
              color: KGrey,
              fontFamily: 'Sans',
              fontWeight: FontWeight.w400,
              fontSize: KFontSizeMedium35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _footer() {
    return InkWell(
      onTap: () {
        _con.generateCsvFiles();
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        color: _con.formValid() ? KPrimary : KGrey_L3,
        child: const Center(
          child: Text(
            "Generar CSVs",
            style: TextStyle(
              color: KWhite,
              fontSize: KFontSizeLarge40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
