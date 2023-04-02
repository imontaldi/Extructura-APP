import 'package:extructura_app/src/interfaces/i_footer_model.dart';

class AFooterModel implements IFooterModel {
  @override
  String? currency;
  @override
  String? otherTaxesAmount;
  @override
  String? total;
  @override
  String? exchangeRate;
  String? netAmountTaxed;
  String? vat27;
  String? vat21;
  String? vat10_5;
  String? vat5;
  String? vat2_5;
  String? vat0;

  AFooterModel(
      {this.currency,
      this.otherTaxesAmount,
      this.total,
      this.netAmountTaxed,
      this.vat27,
      this.vat21,
      this.vat10_5,
      this.vat5,
      this.vat2_5,
      this.vat0,
      this.exchangeRate});

  AFooterModel.fromJson(Map<String, dynamic> json) {
    currency = json["currency"];
    otherTaxesAmount = json["other_taxes_ammout"];
    total = json["total"];
    netAmountTaxed = json["net_amount_taxed"];
    vat27 = json["vat_27"];
    vat21 = json["vat_21"];
    vat10_5 = json["vat_10_5"];
    vat5 = json["vat_5"];
    vat2_5 = json["vat_2_5"];
    vat0 = json["vat_0"];
    exchangeRate = json["exchange_rate"];
  }
}
