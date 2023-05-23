enum CurrencyTypeEnum {
  ars(1, "Pesos Argentinos", "ARS", "\$"),
  usd(2, "Dólares Estadounidenses", "USD", "\$");

  const CurrencyTypeEnum(this.value, this.name, this.code, this.symbol);
  final int value;
  final String name;
  final String code;
  final String symbol;
}
