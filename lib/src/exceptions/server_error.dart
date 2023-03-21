class ServerError implements Exception {
  final String message;
  const ServerError({this.message = ""});
  @override
  String toString() => message;
}
