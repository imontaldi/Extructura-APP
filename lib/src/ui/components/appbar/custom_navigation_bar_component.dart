import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:extructura_app/src/ui/components/appbar/navigation_bar_component.dart';
import 'package:extructura_app/src/ui/components/appbar/pdf_reader_navigation_bar_component.dart';

NavigationBarComponent simpleNavigationBar({
  String title = "",
  Function? onMenu,
  VoidCallback? onBack,
  VoidCallback? onCancel,
  Function? onInfo,
  Function? onNotification,
  bool hideNotificationButton = false,
  bool hideInfoButton = false,
}) {
  return NavigationBarComponent(
    title: title,
    hasBack: onBack != null && onMenu == null,
    hasCancel: onCancel != null,
    onMenuClick: onMenu,
    onBackClick: onBack,
  );
}

PdfReaderNavigationBarComponent pdfReaderNavigationBar({
  String title = "",
  Function? onMenu,
  VoidCallback? onBack,
  VoidCallback? onCancel,
  Function? onInfo,
  Function? onNotification,
  bool hideNotificationButton = false,
  bool hideInfoButton = false,
  bool showPageIndicator = false,
  required PdfController pdfController,
}) {
  return PdfReaderNavigationBarComponent(
    title: title,
    hasBack: onBack != null && onMenu == null,
    onBackClick: onBack,
    pdfController: pdfController,
    showPageIndicator: showPageIndicator,
  );
}
