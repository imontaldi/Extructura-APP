class Error401 implements Exception {
  final String msg;
  const Error401({this.msg = ""});
  @override
  String toString() => 'Error401: $msg';
}
