class ItemModel {
  String? amount;
  String? cod;
  String? discountPerc;
  String? measure;
  String? subtotal;
  String? title;
  String? unitPrice;
  String? vatFee;
  String? subtotalIncFees;
  String? discountedSubtotal;

  ItemModel({
    this.cod,
    this.title,
    this.amount,
    this.measure,
    this.unitPrice,
    this.discountPerc,
    this.subtotal,
    this.vatFee,
    this.subtotalIncFees,
    this.discountedSubtotal,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    amount = json["amount"];
    cod = json["cod"];
    discountPerc = json["discount_perc"];
    measure = json["measure"];
    subtotal = json["subtotal"];
    title = json["title"];
    unitPrice = json["unit_price"];
    vatFee = json["vat_fee"];
    subtotalIncFees = json["subtotal_inc_fees"];
    discountedSubtotal = json["discounted_subtotal"];
  }
}
