import 'http_method_enum.dart';

class NetworkRequest {
  String url;
  HttpMethodEnum httpMethod;
  bool enableCache;
  bool forceRefresh;
  bool enableRepeat;
  bool throwExceptions;
  int cacheDurationInMinutes;
  int timeOutInSeconds;
  int connectionTimeout;
  String mediaType;
  String? jsonBody;

  NetworkRequest({
    required this.url,
    required this.httpMethod,
    this.enableCache = true,
    this.forceRefresh = false,
    this.enableRepeat = false,
    this.throwExceptions = true,
    this.cacheDurationInMinutes = 15,
    this.timeOutInSeconds = 120,
    this.connectionTimeout = 120,
    this.mediaType = "application/json;",
    this.jsonBody,
  });
}
