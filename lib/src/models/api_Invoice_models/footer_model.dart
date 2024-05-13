import 'package:collection/collection.dart';
import 'package:extructura_app/src/enums/currency_type_enum.dart';

class FooterModel {
  String? _currency;
  String? otherTaxesAmount;
  String? total;
  String? exchangeRate;
  String? netAmountTaxed;
  String? netAmountUntaxed;
  String? subtotal;
  String? vat27;
  String? vat21;
  String? vat10_5;
  String? vat5;
  String? vat2_5;
  String? vat0;

  FooterModel({
    String? currency,
    this.otherTaxesAmount,
    this.total,
    this.netAmountTaxed,
    this.netAmountUntaxed,
    this.subtotal,
    this.vat27,
    this.vat21,
    this.vat10_5,
    this.vat5,
    this.vat2_5,
    this.vat0,
    this.exchangeRate,
  }) : _currency = currency;

  CurrencyTypeEnum? get currencyType => CurrencyTypeEnum.values
      .firstWhereOrNull((element) => element.code == _currency);
  set currencyType(CurrencyTypeEnum? currencyType) =>
      _currency = currencyType?.code;

  FooterModel.fromJson(Map<String, dynamic> json) {
    _currency = json["currency"];
    otherTaxesAmount = json["other_taxes_ammout"];
    total = json["total"];
    netAmountTaxed = json["net_amount_taxed"];
    netAmountUntaxed = json["net_amount_untaxed"];
    subtotal = json["subtotal"];
    vat27 = json["vat_27"];
    vat21 = json["vat_21"];
    vat10_5 = json["vat_10_5"];
    vat5 = json["vat_5"];
    vat2_5 = json["vat_2_5"];
    vat0 = json["vat_0"];
    exchangeRate = json["exchange_rate"];
  }
}
