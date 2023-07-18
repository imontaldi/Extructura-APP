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
        'images/icon_warning.png',
        color: KPrimary,
        height: 35,
        width: 35,
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
    String? subtitle = "",
    TextStyle? subtitleStyle,
  }) async {
    BuildContext context = PageManager().navigatorKey.currentContext!;
    return await InformationAlertPopup(
      context: context,
      image: imageURL != null
          ? Image.asset(
              imageURL,
              height: imageHeight,
              width: imageWidth,
              color: KPrimary,
            )
          : null,
      title: title,
      titleStyle: titleStyle,
      subtitle1: subtitle,
      subtitle1Style: subtitleStyle,
      labelButtonAccept: labelButtonAccept,
      labelButtonCancel: labelButtonCancel,
      onAccept: onAccept,
      onCancel: onCancel,
      isCancellable: isCancellable ?? false,
    ).show();
  }

  Future<void> openInvoiceProcessedSuccessfullyPopup({
    String? imageURL,
    double? imageHeight = 0,
    double? imageWidth = 0,
    String? title = "",
    TextStyle? titleStyle,
    String? labelButtonAccept = "",
    String? labelButtonCancel = "",
    Function? onAccept,
    Function? onCancel,
    bool? isCancellable = true,
    String? subtitle = "",
    TextStyle? subtitleStyle,
  }) async {
    BuildContext context = PageManager().navigatorKey.currentContext!;
    return await InformationAlertPopup(
      context: context,
      image: imageURL != null
          ? Image.asset(
              imageURL,
              height: imageHeight,
              width: imageWidth,
              color: KPrimary,
            )
          : null,
      title: title,
      titleStyle: titleStyle,
      subtitle1: subtitle,
      subtitle1Style: subtitleStyle,
      labelButtonAccept: labelButtonAccept,
      labelButtonCancel: labelButtonCancel,
      onAccept: onAccept,
      onCancel: onCancel,
      isCancellable: isCancellable ?? false,
    ).show();
  }

  Future<DateTime?> openCalendarPopUp(String date) async {
    Future showCalendarPopUp() {
      DateTime? dateTime;
      try {
        dateTime = DateFormat('dd/MM/yy').parse(date);
        if (!dateTime.isBefore(DateTime.now())) {
          throw Exception("Date is after today");
        }
      } catch (e) {
        dateTime = DateTime.now();
      }
      BuildContext context = PageManager().navigatorKey.currentContext!;
      return showDialog(
        context: context,
        builder: (_) {
          return CalendarPopup(
            minDate: null,
            maxDate: null,
            enableYearSelection: true,
            enableRange: false,
            selectDate: dateTime,
            titleYearSelect: 'Seleccionar Fecha',
            subTitleYearSelect: 'Año',
            titleCalendar: 'Seleccionar Fecha',
            buttonName: 'Aceptar',
          );
        },
      );
    }

    Map<String, DateTime>? result = await showCalendarPopUp();
    if (result != null) {
      return result['startDate'];
    }
    return null;
  }

  Future<void> openPermanentlyDeniedWarningPopUp(String subtitle1) async {
    await InformationAlertPopup(
      context: PageManager().navigatorKey.currentContext!,
      backgroundOpacity: 0.8,
      image: Image.asset(
        'images/common/icon_alert.png',
        color: KPrimary,
        height: 35,
        width: 35,
      ),
      title: 'Error',
      titleStyle: const TextStyle(
        color: KGrey,
        fontWeight: FontWeight.w800,
        fontSize: KFontSizeLarge40,
      ),
      subtitle1: subtitle1,
      subtitle1Style: const TextStyle(color: KGrey, fontSize: KFontSizeLarge40),
      labelButtonAccept: "Configuración",
      labelButtonCancel: 'Cancelar',
      onAccept: () => permission_handler.openAppSettings(),
      onCancel: null,
      isCancellable: true,
    ).show();
  }
}
