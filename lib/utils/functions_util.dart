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
