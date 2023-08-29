import 'package:flutter/material.dart';
import 'package:extructura_app/utils/extensions.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';

class InformationAlertPopup {
  final BuildContext context;
  final Image? image;
  final double backgroundOpacity;
  final String? title;
  final TextStyle? titleStyle;
  final ImageIcon? iconSubtitle1;
  final String? subtitle1;
  final TextStyle? subtitle1Style;
  final RichText? subtitleRich1;
  final String? subtitle2;
  final RichText? subtitleRich2;
  final TextStyle? subtitle2Style;
  final String? subtitle3;
  final RichText? subtitleRich3;
  final TextStyle? subtitle3Style;
  final String? footerText;
  final TextStyle? footerTextStyle;
  final String? labelButtonAccept;
  final Function? onAccept;
  final String? labelButtonCancel;
  final Function? onCancel;
  final bool isCancellable;

  InformationAlertPopup(
      {required this.context,
      this.image,
      this.backgroundOpacity = 0.8,
      this.title,
      this.titleStyle,
      this.iconSubtitle1,
      this.subtitle1,
      this.subtitle1Style,
      this.subtitleRich1,
      this.subtitle2,
      this.subtitleRich2,
      this.subtitle2Style,
      this.subtitle3,
      this.subtitleRich3,
      this.subtitle3Style,
      this.footerText,
      this.footerTextStyle,
      this.labelButtonAccept,
      this.onAccept,
      this.labelButtonCancel,
      this.onCancel,
      this.isCancellable = true});

  final double radius = 20;

  Future show() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return _dialog();
        });
  }

  _dialog() {
    return Stack(
      children: <Widget>[
        _background(),
        _card(),
      ],
    );
  }

  _background() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        "images/background_popup.png",
        fit: BoxFit.fill,
        height: height,
        width: width,
      ),
    );
  }

  _card() {
    return Center(
      child: Container(
        child: _body(),
        margin: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  _body() {
    return Stack(
      children: <Widget>[
        _content(),
        _buttonExit(),
      ],
    );
  }

  _content() {
    return SingleChildScrollView(
        child: Container(
      width: 350,
      key: const Key('informationAlertPopupContent'),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start, children: _getChildren()),
    ));
  }

  _getChildren() {
    List<Widget> children = [];
    if (image != null) {
      children.addAll([_image(), const SizedBox(height: 15)]);
    }

    if (title.hasValue()) {
      children.addAll([_title(), const SizedBox(height: 15)]);
    }

    if (subtitle1.hasValue() || subtitleRich1 != null) {
      children.addAll([_subtitle1(), const SizedBox(height: 10)]);
    }

    if (subtitle2.hasValue() || subtitleRich2 != null) {
      children.addAll([_subtitle2(), const SizedBox(height: 10)]);
    }

    if (subtitle3.hasValue() || subtitleRich3 != null) {
      children.addAll([_subtitle3(), const SizedBox(height: 10)]);
    }

    if (footerText.hasValue()) {
      children.addAll([
        const SizedBox(height: 10),
        _footerText(),
        const SizedBox(height: 15)
      ]);
    }

    children.addAll([const SizedBox(height: 15), _buttons()]);
    return children;
  }

  _image() {
    return image;
  }

  _title() {
    return Material(
        type: MaterialType.transparency,
        child: Text(
          title.hasValue() ? title! : "",
          softWrap: true,
          textAlign: TextAlign.center,
          style: titleStyle ??
              const TextStyle(
                color: KGrey,
                fontWeight: FontWeight.w400,
                fontSize: KFontSizeXLarge45,
              ),
        ));
  }

  _subtitle1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconSubtitle1 ?? const SizedBox.shrink(),
        iconSubtitle1 != null
            ? const SizedBox(width: 10)
            : const SizedBox.shrink(),
        Flexible(
          child: subtitleRich1 ??
              Material(
                  type: MaterialType.transparency,
                  child: Text(
                    subtitle1.hasValue() ? subtitle1! : " ",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: subtitle1Style ??
                        const TextStyle(
                          color: KGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: KFontSizeMedium35,
                        ),
                  )),
        ),
      ],
    );
  }

  _subtitle2() {
    return Material(
        type: MaterialType.transparency,
        child: subtitleRich2 ??
            Text(
              subtitle2.hasValue() ? subtitle2! : "",
              textAlign: TextAlign.center,
              softWrap: true,
              style: subtitle2Style ??
                  const TextStyle(
                    color: KGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: KFontSizeMedium35,
                  ),
            ));
  }

  _subtitle3() {
    return Material(
        type: MaterialType.transparency,
        child: subtitleRich3 ??
            Text(
              subtitle3.hasValue() ? subtitle3! : "",
              textAlign: TextAlign.center,
              softWrap: true,
              style: subtitle3Style ??
                  const TextStyle(
                    color: KGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: KFontSizeMedium35,
                  ),
            ));
  }

  _footerText() {
    return Material(
        type: MaterialType.transparency,
        child: Text(
          footerText.hasValue() ? footerText! : "",
          textAlign: TextAlign.center,
          softWrap: true,
          style: footerTextStyle ??
              const TextStyle(
                color: KGrey,
                fontWeight: FontWeight.w400,
                fontSize: KFontSizeMedium35,
              ),
        ));
  }

  _buttons() {
    return Row(
      children: [
        _buttonCancel(),
        Visibility(
          visible: labelButtonCancel.hasValue(),
          child: const SizedBox(
            width: 15,
          ),
        ),
        _buttonAccept(),
      ],
    );
  }

  _buttonExit() {
    return Visibility(
      visible: isCancellable,
      child: Positioned.fill(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: GestureDetector(
              key: const Key('informationAlertPopupExitButton'),
              onTap: () {
                Navigator.pop(context, false);
              },
              child: Image.asset(
                "images/icon_close.png",
                fit: BoxFit.cover,
                alignment: Alignment.center,
                color: KPrimary,
                height: 15,
                width: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buttonAccept() {
    return Flexible(
      child: TextButton(
        key: const Key('informationAlertPopupAcceptButton'),
        onPressed: () {
          Navigator.pop(context, true);
          if (onAccept != null) {
            onAccept!();
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: KPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(0),
        ),
        child: Container(
          padding: const EdgeInsets.all(0),
          height: 40,
          child: Center(
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                labelButtonAccept.hasValue() ? labelButtonAccept! : "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: KFontSizeLarge40,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buttonCancel() {
    return Visibility(
      visible: labelButtonCancel.hasValue(),
      child: Flexible(
        child: TextButton(
          key: const Key('informationAlertPopupCancelButton'),
          onPressed: () {
            Navigator.pop(context, false);

            if (onCancel != null) {
              onCancel!();
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: KGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(0),
          ),
          child: Container(
            padding: const EdgeInsets.all(0),
            height: 40,
            child: Center(
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  labelButtonCancel.hasValue() ? labelButtonCancel! : "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: KFontSizeLarge40,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
