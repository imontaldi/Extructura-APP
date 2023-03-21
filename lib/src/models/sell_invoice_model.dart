class SellInvoiceModel {
  int? id;
  DateTime? fechaFac;
  String? tipoComp;
  String? letComp;
  String? num1Comp;
  String? num2Comp;
  String? idProv;
  String? mesDDJJ;
  String? anioDDJJ;
  int? moneda;
  double? totFac;

  SellInvoiceModel({
    this.id,
    this.fechaFac,
    this.tipoComp,
    this.letComp,
    this.num1Comp,
    this.num2Comp,
    this.idProv,
    this.mesDDJJ,
    this.anioDDJJ,
    this.moneda,
    this.totFac,
  });

  String getFieldFromId(int id) {
    switch (id) {
      case 0:
        return "fechaFac";
      case 1:
        return "tipoComp";
      case 2:
        return "letComp";
      case 3:
        return "num1Comp";
      case 4:
        return "num2Comp";
      case 5:
        return "idProv";
      case 6:
        return "mesDDJJ";
      case 7:
        return "anioDDJJ";
      case 8:
        return "moneda";
      case 9:
        return "totFac";
      default:
        return "";
    }
  }

  int? getMoneda(String symbol) {
    switch (symbol) {
      case "\$":
        return 0;
      case "USD":
        return 1;
      default:
        return 0;
    }
  }
}
