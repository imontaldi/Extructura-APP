import 'package:collection/collection.dart';
import 'package:extructura_app/src/enums/invoice_type_enum.dart';
import 'package:extructura_app/src/models/api_Invoice_models/footer_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/header_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/item_model.dart';

class InvoiceModel {
  String? _typeCharacter;
  HeaderModel? header;
  List<ItemModel>? items;
  FooterModel? footer;

  InvoiceModel({
    String? typeCharacter,
    this.header,
    this.items,
    this.footer,
  }) : _typeCharacter = typeCharacter;

  InvoiceTypeEnum? get type => InvoiceTypeEnum.values
      .firstWhereOrNull((element) => element.value == _typeCharacter);
  set orderType(InvoiceTypeEnum? value) => _typeCharacter = value?.value;

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    _typeCharacter = json["type"];
    header = json["header"] != null
        ? HeaderModel.fromJson(
            json["header"],
          )
        : null;
    items = json["items"] != null
        ? List<ItemModel>.from(json["items"].map((x) => ItemModel.fromJson(x)))
        : [];
    footer = json["footer"] != null
        ? FooterModel.fromJson(
            json["footer"],
          )
        : null;
  }

  InvoiceTypeEnum? getInvoiceType(String invoiceType) {
    switch (invoiceType) {
      case "A":
        return InvoiceTypeEnum.A;
      case "B":
        return InvoiceTypeEnum.B;
      case "C":
        return InvoiceTypeEnum.C;
      default:
        return InvoiceTypeEnum.A;
    }
  }
}
