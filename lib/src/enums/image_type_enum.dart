enum ImageTypeEnum {
  pdf(1, "Captura de factura digital"),
  photo(2, "Fotografía de la factura"),
  scan(3, "Imágen obtenida por Scanner");

  const ImageTypeEnum(this.value, this.name);
  final int value;
  final String name;
}
