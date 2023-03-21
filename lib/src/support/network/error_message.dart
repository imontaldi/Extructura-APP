import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:extructura_app/src/support/network/network.dart';
import 'package:extructura_app/utils/extensions.dart';

onResultErrorDefault(HttpResult error, {Function? onRetry}) {
  switch (error.type) {
    case HttpCodesEnum.e401_Unauthorized:
      return PageManager().goDoLogout();
    case HttpCodesEnum.s204_NoContent:
      return PageManager().openDefaultErrorAlert(
          'k_default_error_message'.translate(),
          onRetry: onRetry);
    case HttpCodesEnum.e500_InternalServerError:
      return PageManager().openDefaultErrorAlert(
          'k_default_error_message_server_connection'.translate(),
          onRetry: onRetry);
    case HttpCodesEnum.NoInternetConnection:
      return PageManager().openDefaultErrorAlert(
          'k_default_error_message_no_internet_connection'.translate(),
          onRetry: onRetry);
    default:
      return PageManager().openDefaultErrorAlert(
          'k_default_error_message'.translate(),
          onRetry: onRetry);
  }
}

onErrorFunction({required HttpResult? error, onRetry}) {
  switch (error!.type) {
    case HttpCodesEnum.e401_Unauthorized:
      return PageManager().goDoLogout();
    case HttpCodesEnum.s204_NoContent:
      return PageManager().openDefaultErrorAlert(
          'k_default_error_message'.translate(),
          onRetry: () => onRetry());
    case HttpCodesEnum.e500_InternalServerError:
      return PageManager().openDefaultErrorAlert(
          'k_default_error_message_server_connection'.translate(),
          onRetry: () => onRetry());
    case HttpCodesEnum.NoInternetConnection:
      return PageManager().openDefaultErrorAlert(
          'k_default_error_message_no_internet_connection'.translate(),
          onRetry: () => onRetry());
    default:
      return PageManager().openDefaultErrorAlert(
          'k_default_error_message'.translate(),
          onRetry: () => onRetry());
  }
}
