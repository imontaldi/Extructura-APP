enum PermissionStatusEnum {
  granted("granted"),
  denied("denied"),
  permanentlyDenied("permanentlyDenied");

  const PermissionStatusEnum(this.name);
  final String name;
}
