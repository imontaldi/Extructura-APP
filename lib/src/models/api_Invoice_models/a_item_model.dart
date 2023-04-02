import 'package:extructura_app/src/interfaces/i_item_model.dart';

class AItemModel implements IItemModel {
  @override
  String? amount;
  @override
  String? cod;
  @override
  String? discountPerc;
  @override
  String? measure;
  @override
  String? subtotal;
  @override
  String? title;
  @override
  String? unitPrice;
  String? ivaFee;
  String? subtotalIncFees;

  AItemModel({
    this.cod,
    this.title,
    this.amount,
    this.measure,
    this.unitPrice,
    this.discountPerc,
    this.subtotal,
    this.ivaFee,
    this.subtotalIncFees,
  });

  AItemModel.fromJson(Map<String, dynamic> json) {
    amount = json["amount"];
    cod = json["cod"];
    discountPerc = json["discount_perc"];
    measure = json["measure"];
    subtotal = json["subtotal"];
    title = json["title"];
    unitPrice = json["unit_price"];
    ivaFee = json["iva_fee"];
    subtotalIncFees = json["subtotal_inc_fees"];
  }
}
