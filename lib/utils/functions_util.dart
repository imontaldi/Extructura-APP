import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String timeFormatHHMM24Hours(DateTime time) {
  return DateFormat("HH:mm").format(time);
}

String numberFormatXX(int number) {
  return number.toString().padLeft(2, "0");
}

void showToast({
  required BuildContext context,
  required String message,
  Duration duration = const Duration(seconds: 2),
  EdgeInsets padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  Color? color,
  BorderRadius? borderRadius,
  double fontSize = 14,
}) {
  SnackBar snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    padding: const EdgeInsets.only(bottom: 70),
    duration: duration,
    backgroundColor: Colors.transparent,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color ??
                  const Color.fromARGB(255, 126, 126, 126).withOpacity(0.7),
              borderRadius: borderRadius ?? BorderRadius.circular(25),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize),
              maxLines: null,
            ),
          ),
        ),
      ],
    ),
  );
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

String dateFormat(DateTime? date) {
  return date != null ? DateFormat("dd/MM/yyyy").format(date) : "";
}

bool isDateValid(String date) {
  try {
    DateFormat('dd/MM/yy').parse(date);
    return true;
  } catch (e) {
    return false;
  }
}

bool isDouble(String? text) {
  const pattern = r"^(\d+(?:[\.\,]\d{1,2})?)$";
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(text ?? "")) {
    return false;
  }
  return true;
}

bool isInt(String? text) {
  int? output = text != null ? int.tryParse(text) : null;
  return output != null;
}

String currencyFormat(String? price) {
  return price != null ? NumberFormat("#,##0.0", "es-AR").format(price) : "";
}

getBase64(File image) {
  List<int> imageBytes = image.readAsBytesSync();
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}
