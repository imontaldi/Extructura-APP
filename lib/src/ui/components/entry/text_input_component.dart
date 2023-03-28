// Flutter imports:
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class TextInputComponent extends StatefulWidget {
  bool isValid;
  late Color backgroundColor;
  late Color errorBackgroundColor;
  Function()? onPress;
  String errorPlaceHolder;
  String? placeholder;
  List<BoxShadow>? boxShadow;
  TextStyle? placeholderStyle;
  TextStyle? textStyle;
  TextStyle? errorTextStyle;
  BorderRadius? borderRadius;
  EdgeInsets? innerPadding;
  double? height;
  Alignment? alignment;
  Widget? leftIcon;
  Widget? rightIcon;
  bool isPassword = false;
  bool showPasswordInfo = false;
  bool isEnabled = true;
  int? maxLength;
  TextInputType? keyboardType;
  VoidCallback? onEditComplete;
  Color? errorBorderColor;
  Color? borderColor;
  TextInputAction? textInputAction;
  TextEditingController controller = TextEditingController();
  FocusNode? focusNode;
  Function(String text)? onTextChange;
  List<TextInputFormatter> inputFormatters = [];
  bool isPasswordEnabled = false;

  TextInputComponent({
    Key? key,
    required this.controller,
    this.alignment,
    this.backgroundColor = KBackground,
    this.errorBackgroundColor = KWhite,
    this.borderColor = KTransparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.boxShadow,
    this.errorBorderColor = KRed,
    this.errorPlaceHolder = "",
    this.errorTextStyle = const TextStyle(
      color: KRed,
      fontWeight: FontWeight.w400,
      fontSize: KFontSizeMedium35,
    ),
    this.focusNode,
    this.height = 38,
    this.innerPadding = const EdgeInsets.only(left: 15, right: 15),
    this.inputFormatters = const [],
    this.isEnabled = true,
    this.isPassword = false,
    this.isValid = true,
    this.keyboardType,
    this.leftIcon,
    this.maxLength,
    this.onEditComplete,
    this.onPress,
    this.placeholder,
    this.placeholderStyle = const TextStyle(
      color: KGrey,
      fontWeight: FontWeight.w400,
      fontSize: KFontSizeMedium35,
    ),
    this.rightIcon,
    this.showPasswordInfo = false,
    this.textInputAction,
    this.textStyle = const TextStyle(
      color: KGrey,
      fontWeight: FontWeight.w400,
      fontSize: KFontSizeMedium35,
    ),
    this.onTextChange,
  }) : super(key: key);
  @override
  TextInputComponentState createState() => TextInputComponentState();
}

class TextInputComponentState extends State<TextInputComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isValid
            ? widget.backgroundColor
            : widget.errorBackgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow,
        border: Border.all(
          color:
              widget.isValid ? widget.borderColor! : widget.errorBorderColor!,
        ),
      ),
      height: widget.height,
      alignment: widget.alignment,
      child: Padding(
        padding: widget.innerPadding ?? EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.leftIcon ?? const SizedBox.shrink(),
            Expanded(
              child: widget.isValid
                  ? TextFormField(
                      controller: widget.controller,
                      cursorColor: KGrey,
                      cursorHeight: 13,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: widget.placeholderStyle,
                        hintText: widget.placeholder ?? '',
                        isCollapsed: true,
                      ),
                      enabled: widget.isEnabled,
                      focusNode: widget.focusNode,
                      inputFormatters: [
                        ...widget.inputFormatters,
                        LengthLimitingTextInputFormatter(widget.maxLength),
                        if (widget.inputFormatters.isEmpty &&
                            widget.keyboardType == TextInputType.number)
                          FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: widget.keyboardType,
                      obscureText:
                          widget.isPassword && !widget.isPasswordEnabled,
                      obscuringCharacter: "*",
                      onChanged: (value) {
                        if (widget.onTextChange != null) {
                          widget.onTextChange!(value);
                        }
                      },
                      onEditingComplete: widget.onEditComplete,
                      onTap: widget.onPress,
                      style: widget.textStyle,
                      textInputAction:
                          widget.textInputAction ?? TextInputAction.next,
                    )
                  : GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        widget.isValid = true;
                        setState(() {});
                      },
                      child: Text(
                        widget.errorPlaceHolder,
                        style: widget.errorTextStyle,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
