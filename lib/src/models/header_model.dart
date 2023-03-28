class HeaderModel {
  String? businessName;
  String? businessAddress;
  String? vatCondition;
  String? documentType;
  String? checkoutAisleNumber;
  String? documentNumber;
  String? issueDate;
  String? sellerCuit;
  String? grossIncome;
  String? businessOpeningDate;
  String? clientCuit;
  String? clientName;
  String? clientVatCondition;
  String? clientAddress;
  String? saleMethod;

  HeaderModel({
    this.businessName,
    this.businessAddress,
    this.vatCondition,
    this.documentType,
    this.checkoutAisleNumber,
    this.documentNumber,
    this.issueDate,
    this.sellerCuit,
    this.grossIncome,
    this.businessOpeningDate,
    this.clientCuit,
    this.clientName,
    this.clientVatCondition,
    this.clientAddress,
    this.saleMethod,
  });

  HeaderModel.fromJson(Map<String, dynamic> json) {
    businessName = json["business_name"];
    businessAddress = json["business_address"];
    vatCondition = json["vat_condition"];
    documentType = json["document_type"];
    checkoutAisleNumber = json["checkout_aisle_number"];
    documentNumber = json["document_number"];
    issueDate = json["issue_date"];
    sellerCuit = json["seller_cuit"];
    grossIncome = json["gross_income"];
    businessOpeningDate = json["business_opening_date"];
    clientCuit = json["client_cuit"];
    clientName = json["client_name"];
    clientVatCondition = json["client_vat_condition"];
    clientAddress = json["client_address"];
    saleMethod = json["sale_method"];
  }
}
