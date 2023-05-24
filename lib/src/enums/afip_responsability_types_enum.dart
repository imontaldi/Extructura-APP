enum AFIPResponsabilityTypeEnuum {
  ivaResponsableInscripto(1, "IVA Responsable Inscripto"),
  ivaResponsableNoInscripto(2, "IVA Responsable no Inscripto"),
  ivaNoResponsable(3, "IVA no Responsable"),
  ivaSujetoExento(4, "IVA Sujeto Exento"),
  consumidorFinal(5, "Consumidor Final"),
  responsableMonotributo(6, "Responsable Monotributo"),
  sujetoNoCategorizado(7, "Sujeto No Categorizado"),
  proveedorDelExterior(8, "Proveedor del Exterior"),
  clienteDelExterior(9, "Cliente del Exterior"),
  ivaLiberadoLey19640(10, "IVA Liberado - Ley Nº 19.640"),
  ivaResponsableInscriptoAgenteDePercepcion(
      11, "IVA Responsable Inscripto - Agente de Percepción"),
  pequenoContribuyenteEventual(12, "Pequeño Contribuyente Eventual"),
  monotributistaSocial(13, "Monotributista Social"),
  pequenoContribuyenteEventualSocial(
      14, "Pequeño Contribuyente Eventual Social");

  const AFIPResponsabilityTypeEnuum(
    this.value,
    this.name,
  );
  final int value;
  final String name;
}
