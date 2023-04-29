import 'package:flutter/material.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';

const BoxShadow kTopContainerBoxShadow =
    BoxShadow(color: KGrey_L3, blurRadius: 1.0, offset: Offset(0.0, 0.3));

const BoxShadow kTopContainerBoxShadowLarge =
    BoxShadow(color: KGrey_L4, blurRadius: 3.0, offset: Offset(0.0, 3));

const BoxShadow kInputShadow = BoxShadow(
    color: Color(0x40666666),
    spreadRadius: 1,
    blurRadius: 1,
    offset: Offset(0, 1));

const BoxDecoration dlvCardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(20)),
  boxShadow: [
    BoxShadow(
        color: Color(0x40666666),
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(0, 1)),
  ],
);

labelStyle() => const TextStyle(
      color: KGrey,
      fontWeight: FontWeight.normal,
      fontSize: KFontSizeMedium35,
    );

labelGreyLightStyle() => const TextStyle(
      color: KGrey_L3,
      fontWeight: FontWeight.normal,
      fontSize: KFontSizeXLarge45,
    );

labelErrorStyle() => const TextStyle(
      color: KPrimary_L1,
      fontWeight: FontWeight.normal,
      fontSize: KFontSizeLarge40,
    );

labelLightGreyStyle() => const TextStyle(
      color: KGrey_L2,
      fontWeight: FontWeight.normal,
      fontSize: KFontSizeLarge40,
    );

labelLightGreyErrorStyle() => const TextStyle(
      color: KPrimary_L1,
      fontWeight: FontWeight.normal,
      fontSize: KFontSizeMedium35,
    );

labelWhiteStyle() => const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: KFontSizeMedium35,
    );

labelBoldStyle() => const TextStyle(
      color: KGrey,
      fontWeight: FontWeight.bold,
      fontSize: KFontSizeMedium35,
    );

labelTitleStyle() => const TextStyle(
      color: KGrey,
      fontWeight: FontWeight.w400,
      fontSize: KFontSizeXXLarge50,
    );

labelLinkStyle() => const TextStyle(
      color: KPrimary_L1,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.underline,
      fontSize: KFontSizeMedium35,
    );

labelRedBoldStyle() => const TextStyle(
      color: KPrimary_L1,
      fontWeight: FontWeight.bold,
      fontSize: KFontSizeMedium35,
    );

labelRedRegularStyle() => const TextStyle(
      color: KPrimary_L1,
      fontWeight: FontWeight.normal,
      fontSize: KFontSizeXLarge45,
    );

labelPlaceholderStyle() => const TextStyle(
      color: KGrey_L2,
      fontWeight: FontWeight.normal,
      fontSize: KFontSizeSmall30,
    );

labelWhiteBoldStyle() => const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: KFontSizeMedium35,
    );
