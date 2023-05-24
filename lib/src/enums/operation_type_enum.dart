// ignore_for_file: constant_identifier_names

enum OperationTypeEnum {
  Sell(1, "Venta"),
  Purchase(2, "Compra"),
  ;

  const OperationTypeEnum(this.id, this.name);
  final int id;
  final String name;
}
