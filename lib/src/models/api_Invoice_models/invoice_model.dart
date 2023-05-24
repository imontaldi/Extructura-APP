import 'package:collection/collection.dart';
import 'package:extructura_app/src/enums/invoice_type_enum.dart';
import 'package:extructura_app/src/enums/operation_type_enum.dart';
import 'package:extructura_app/src/models/api_Invoice_models/footer_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/header_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/item_model.dart';

class InvoiceModel {
  String? _invoiceTypeCharacter;
  HeaderModel? header;
  List<ItemModel>? items;
  FooterModel? footer;

  //Uso interno
  int? _operationType;

  InvoiceModel({
    String? typeCharacter,
    this.header,
    this.items,
    this.footer,
  }) : _invoiceTypeCharacter = typeCharacter;

  InvoiceTypeEnum? get type => InvoiceTypeEnum.values
      .firstWhereOrNull((element) => element.value == _invoiceTypeCharacter);
  set orderType(InvoiceTypeEnum? value) => _invoiceTypeCharacter = value?.value;

  OperationTypeEnum? get operationType => OperationTypeEnum.values
      .firstWhereOrNull((element) => element.id == _operationType);
  set operationType(OperationTypeEnum? value) => _operationType = value?.id;

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    _invoiceTypeCharacter = json["type"];
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
    setOperationType(header?.sellerCuit);
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

  void setOperationType(String? sellerCuit) {
    //Si se usan cuentas por usuario se puede personalizar este campo
    sellerCuit == "30654303254" //Cuit de DON DANTE SRL
        ? _operationType = 1
        : _operationType = 2;
  }
}
