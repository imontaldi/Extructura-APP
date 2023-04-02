import 'package:extructura_app/src/enums/invoice_type_enum.dart';
import 'package:extructura_app/src/interfaces/i_footer_model.dart';
import 'package:extructura_app/src/interfaces/i_item_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/a_footer_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/a_item_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/c_footer_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/c_item_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/header_model.dart';

class InvoiceModel {
  InvoiceTypeEnum? type;
  HeaderModel? header;
  List<IItemModel>? items;
  IFooterModel? footer;

  InvoiceModel({
    this.type,
    this.header,
    this.items,
    this.footer,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    type = getInvoiceType(json["type"]);
    header = json["header"] != null
        ? HeaderModel.fromJson(
            json["header"],
          )
        : null;
    items = type == InvoiceTypeEnum.A
        ? json["items"] != null
            ? List<AItemModel>.from(
                json["items"].map((x) => AItemModel.fromJson(x)))
            : []
        : json["items"] != null
            ? List<CItemModel>.from(
                json["items"].map((x) => CItemModel.fromJson(x)))
            : [];
    footer = type == InvoiceTypeEnum.A
        ? json["footer"] != null
            ? AFooterModel.fromJson(
                json["footer"],
              )
            : null
        : json["footer"] != null
            ? CFooterModel.fromJson(
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
