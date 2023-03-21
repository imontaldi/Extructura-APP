import 'package:flutter/material.dart';
import 'package:extructura_app/values/k_colors.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton(
      {Key? key,
      this.text,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.icon,
      this.height = 40,
      this.width = 100,
      this.borderRadius = 20,
      this.backgroundColor = KPrimary,
      this.borderColor = KPrimary,
      this.textColor = const Color(0xFFFFFFFF),
      this.disableBackgroundColor = const Color(0xFFF5F5F5),
      this.disableBorderColor = const Color(0xFFF5F5F5),
      this.disableTextColor = const Color(0xFFC4C4C4),
      this.disableShadowColor = const Color(0x40666666),
      this.isEnabled = true,
      this.hasShadow = false,
      this.richText,
      this.textAlign,
      @required this.onPressed})
      : super(key: key);

  final String? text;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget? icon;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color disableBackgroundColor;
  final Color disableBorderColor;
  final Color disableTextColor;
  final Color disableShadowColor;
  final double borderRadius;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool hasShadow;
  final RichText? richText;
  final TextAlign? textAlign;

  @override
  RoundedButtonState createState() => RoundedButtonState();
}

class RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isEnabled ? widget.onPressed : () {},
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
          height: widget.height,
          width: widget.width,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: widget.isEnabled
                ? widget.backgroundColor
                : widget.disableBackgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
                color: widget.isEnabled
                    ? widget.borderColor
                    : widget.disableBorderColor),
            boxShadow: [
              BoxShadow(
                color: widget.hasShadow
                    ? (!widget.isEnabled
                        ? widget.disableShadowColor.withOpacity(0.1)
                        : widget.disableShadowColor)
                    : Colors.transparent,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Center(child: _content())),
    );
  }

  _content() {
    if (widget.icon != null &&
        ((widget.text != null && widget.text!.isNotEmpty) ||
            widget.richText != null)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(flex: 1, child: widget.icon!),
          const SizedBox(width: 10),
          Flexible(
            flex: 3,
            child: widget.richText ??
                Text(
                    widget.text != null && widget.text!.isNotEmpty
                        ? widget.text!
                        : "",
                    textAlign: widget.textAlign,
                    style: TextStyle(
                        color: widget.isEnabled
                            ? widget.textColor
                            : widget.disableTextColor,
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight)),
          )
        ],
      );
    } else if (widget.icon == null &&
        (((widget.text != null && widget.text!.isNotEmpty) ||
            widget.richText != null))) {
      return widget.richText ??
          Text(
              widget.text != null && widget.text!.isNotEmpty
                  ? widget.text!
                  : "",
              style: TextStyle(
                  color: widget.isEnabled
                      ? widget.textColor
                      : widget.disableTextColor,
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight));
    } else if (widget.icon != null) {
      return widget.icon;
    }
    return const SizedBox.shrink();
  }
}
