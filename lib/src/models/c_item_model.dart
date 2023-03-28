import 'package:extructura_app/src/interfaces/i_item_model.dart';

class CItemModel implements IItemModel {
  @override
  String? amount;
  @override
  String? cod;
  String? discountedSubtotal;
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

  CItemModel({
    this.amount,
    this.cod,
    this.discountedSubtotal,
    this.discountPerc,
    this.measure,
    this.subtotal,
    this.title,
    this.unitPrice,
  });

  CItemModel.fromJson(Map<String, dynamic> json) {
    amount = json["amount"];
    cod = json["cod"];
    discountedSubtotal = json["discounted_subtotal"];
    discountPerc = json["discount_perc"];
    measure = json["measure"];
    subtotal = json["subtotal"];
    title = json["title"];
    unitPrice = json["unit_price"];
  }
}
