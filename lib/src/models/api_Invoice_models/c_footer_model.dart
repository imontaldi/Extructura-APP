import 'package:extructura_app/src/interfaces/i_footer_model.dart';

class CFooterModel implements IFooterModel {
  @override
  String? currency;
  @override
  String? otherTaxesAmount;
  @override
  String? total;
  @override
  String? exchangeRate;
  String? subtotal;

  CFooterModel({
    this.currency,
    this.otherTaxesAmount,
    this.total,
    this.subtotal,
    this.exchangeRate,
  });

  CFooterModel.fromJson(Map<String, dynamic> json) {
    currency = json["currency"];
    otherTaxesAmount = json["other_taxes_ammout"];
    total = json["total"];
    subtotal = json["subtotal"];
    exchangeRate = json["exchange_rate"];
  }
}
