import 'package:collection/collection.dart';
import 'package:extructura_app/src/enums/afip_responsability_types_enum.dart';

class HeaderModel {
  String? businessName;
  String? businessAddress;
  int? _vatConditionId;
  String? documentType;
  String? checkoutAisleNumber;
  String? documentNumber;
  String? issueDate;
  String? sellerCuit;
  String? grossIncome;
  String? businessOpeningDate;
  String? clientCuit;
  String? clientName;
  int? _clientVatConditionId;
  String? clientAddress;
  String? saleMethod;

  HeaderModel({
    this.businessName,
    this.businessAddress,
    int? vatConditionId,
    this.documentType,
    this.checkoutAisleNumber,
    this.documentNumber,
    this.issueDate,
    this.sellerCuit,
    this.grossIncome,
    this.businessOpeningDate,
    this.clientCuit,
    this.clientName,
    int? clientVatConditionId,
    this.clientAddress,
    this.saleMethod,
  })  : _vatConditionId = vatConditionId,
        _clientVatConditionId = clientVatConditionId;

  AFIPResponsabilityTypeEnuum? get vatCondition =>
      AFIPResponsabilityTypeEnuum.values
          .firstWhereOrNull((element) => element.value == _vatConditionId);
  set vatCondition(AFIPResponsabilityTypeEnuum? value) =>
      _vatConditionId = value?.value;

  AFIPResponsabilityTypeEnuum? get clientVatCondition =>
      AFIPResponsabilityTypeEnuum.values.firstWhereOrNull(
          (element) => element.value == _clientVatConditionId);
  set clientVatCondition(AFIPResponsabilityTypeEnuum? value) =>
      _clientVatConditionId = value?.value;

  HeaderModel.fromJson(Map<String, dynamic> json) {
    businessName = json["business_name"];
    businessAddress = json["business_address"];
    _vatConditionId = json["vat_condition"];
    documentType = json["document_type"];
    checkoutAisleNumber = json["checkout_aisle_number"];
    documentNumber = json["document_number"];
    issueDate = json["issue_date"];
    sellerCuit = json["seller_cuit"];
    grossIncome = json["gross_income"];
    businessOpeningDate = json["business_opening_date"];
    clientCuit = json["client_cuit"];
    clientName = json["client_name"];
    _clientVatConditionId = json["client_vat_condition"];
    clientAddress = json["client_address"];
    saleMethod = json["sale_method"];
  }
}
