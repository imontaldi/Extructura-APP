part of '../page_manager.dart';

mixin PageManagerPopUp {
  openAuthenticationErrorAlert() {
    BuildContext context = PageManager().navigatorKey.currentContext!;

    return InformationAlertPopup(
      context: context,
      backgroundOpacity: 0.8,
      image: Image.asset(
        'images/icon_alert.png',
        height: 50,
        width: 50,
      ),
      title: AppLocalizations.of(context)?.translate('k_error') ?? '',
      titleStyle: const TextStyle(
        color: KGrey,
        fontWeight: FontWeight.w800,
        fontSize: KFontSizeLarge40,
      ),
      subtitle1: AppLocalizations.of(context)
              ?.translate('k_open_authentication_error_alert_popup_subtitle') ??
          '',
      subtitle1Style: const TextStyle(color: KGrey, fontSize: KFontSizeLarge40),
      labelButtonAccept:
          AppLocalizations.of(context)?.translate('k_accept') ?? '',
      onAccept: () {},
      onCancel: () {},
      isCancellable: true,
    ).show();
  }

  Future<bool?> openExitAppAlertPopup({Function? onAccept}) async {
    return await InformationAlertPopup(
      context: PageManager().navigatorKey.currentContext!,
      backgroundOpacity: 0.8,
      image: Image.asset(
        'images/icon_alert.png',
        height: 50,
        width: 50,
        fit: BoxFit.contain,
      ),
      title: 'Alerta',
      titleStyle: const TextStyle(
        color: KGrey,
        fontWeight: FontWeight.w800,
        fontSize: KFontSizeLarge40,
      ),
      subtitle1: '¿Estás seguro de querer salir de la aplicación?',
      subtitle1Style:
          const TextStyle(color: KGrey, fontSize: KFontSizeMedium35),
      labelButtonAccept: 'Salir',
      labelButtonCancel: 'Cancelar',
      onAccept: () {
        onAccept != null ? onAccept() : () {};
      },
      onCancel: () {},
      isCancellable: true,
    ).show();
  }

  openDefaultErrorAlert(String detail, {Function? onRetry}) {
    return InformationAlertPopup(
      context: PageManager().navigatorKey.currentContext!,
      backgroundOpacity: 0.8,
      image: Image.asset(
        'images/icon_alert.png',
        height: 50,
        width: 50,
      ),
      title: 'Error',
      titleStyle: const TextStyle(
        color: KGrey,
        fontWeight: FontWeight.w800,
        fontSize: KFontSizeLarge40,
      ),
      subtitle1: detail,
      subtitle1Style:
          const TextStyle(color: KGrey, fontSize: KFontSizeMedium35),
      labelButtonAccept: onRetry == null ? 'Aceptar' : 'Reintentar',
      labelButtonCancel: onRetry != null ? 'Cancelar' : null,
      onAccept: onRetry,
      onCancel: () {},
      isCancellable: true,
    ).show();
  }

  Future<void> openInformationPopup({
    String? imageURL = "",
    double? imageHeight = 0,
    double? imageWidth = 0,
    String? title = "",
    TextStyle? titleStyle,
    String? labelButtonAccept = "",
    String? labelButtonCancel = "",
    Function? onAccept,
    Function? onCancel,
    bool? isCancellable = true,
  }) async {
    BuildContext context = PageManager().navigatorKey.currentContext!;
    return await InformationAlertPopup(
      context: context,
      image: imageURL != null
          ? Image.asset(
              imageURL,
              height: imageHeight,
              width: imageWidth,
            )
          : null,
      title: title,
      titleStyle: titleStyle,
      labelButtonAccept: labelButtonAccept,
      labelButtonCancel: labelButtonCancel,
      onAccept: onAccept,
      onCancel: onCancel,
      isCancellable: isCancellable ?? false,
    ).show();
  }
}
