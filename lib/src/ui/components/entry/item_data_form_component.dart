// ignore_for_file: unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:extructura_app/src/ui/components/entry/checkbox_component.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/utils/extensions.dart';
import 'package:extructura_app/values/k_values.dart';

enum ItemDataFormType { text, number, date, dropDown, signature, checkBoxLabel }

enum CheckBoxLabelType {
  left,
  right,
}

typedef ValidateFunction = String Function(String value);

// ignore: must_be_immutable
class ItemDataFormComponent extends StatefulWidget {
  //COMMONS
  final ValidateFunction? validate;
  late ItemDataFormType type;
  bool isValid;
  String label;
  late Color backgroundColor;
  bool hasDividerLine;
  String? placeholder;
  List<BoxShadow>? boxShadow;
  TextStyle? placeholderStyle;
  TextStyle? textStyle;
  TextStyle? errorTextStyle;
  BorderRadius? borderRadius;
  EdgeInsets? innerPadding;
  double? height;
  Alignment? alignment;
  BoxBorder? errorBorder;
  BoxBorder? border;
  Widget? leftIcon;
  Widget? rightIcon;
  TextAlign? inputTextAlign;
  bool isPassword = false;
  bool isRequired = false;
  bool isEnabled = true;
  int? maxLength;
  TextInputType? keyboardType;
  VoidCallback? onEditComplete;

  //TEXT
  TextEditingController? controller;
  //NUMBER
  FocusNode? focusNode;
  //DATE
  DateTime? selectedDate;
  //DROPDOWN
  late List<dynamic> items;
  late dynamic selectedItem;
  late Function onChange;
  late bool isDense;
  int? dropdownItemMaxLines;
  int? dropdownValueMaxLines;
  //CHECKBOX
  late bool autoCheckOnClick;
  String? checkBoxLabel;
  Widget? checkBoxWidget;
  CheckBoxLabelType? checkBoxType;
  late bool isSelected;
  String? iconLeftPath;
  Function(bool isCheck)? onTap;
  //SIGNATURE
  late Color colorSignature;

  ItemDataFormComponent.text({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.controller,
    this.placeholder,
    this.backgroundColor = Colors.white,
    this.hasDividerLine = false,
    this.boxShadow,
    this.placeholderStyle,
    this.innerPadding,
    this.borderRadius,
    this.height,
    this.alignment,
    this.errorBorder,
    this.errorTextStyle,
    this.leftIcon,
    this.rightIcon,
    this.inputTextAlign,
    this.isRequired = false,
    this.isPassword = false,
    this.isEnabled = true,
    this.validate,
    this.maxLength,
    this.keyboardType,
    this.onEditComplete,
  }) : super(key: key) {
    type = ItemDataFormType.text;
  }

  ItemDataFormComponent.number({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.controller,
    this.placeholder,
    this.backgroundColor = Colors.white,
    this.hasDividerLine = false,
    this.boxShadow,
    this.placeholderStyle,
    this.innerPadding,
    this.borderRadius,
    this.height,
    this.alignment,
    this.errorBorder,
    this.errorTextStyle,
    this.leftIcon,
    this.rightIcon,
    this.inputTextAlign,
    this.isRequired = false,
    this.isPassword = false,
    this.validate,
    this.maxLength,
    this.onEditComplete,
    this.focusNode,
  }) : super(key: key) {
    type = ItemDataFormType.number;
  }

  ItemDataFormComponent.date({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.backgroundColor = Colors.white,
    this.selectedDate,
    this.hasDividerLine = false,
    this.validate,
  }) : super(key: key) {
    type = ItemDataFormType.date;
  }

  ItemDataFormComponent.dropDown({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.backgroundColor = Colors.white,
    required this.items,
    this.selectedItem,
    required this.onChange,
    this.placeholder = '',
    this.isDense = true,
    this.hasDividerLine = false,
    this.validate,
    this.borderRadius,
    this.boxShadow,
    this.innerPadding,
    this.dropdownItemMaxLines,
    this.dropdownValueMaxLines,
  }) : super(key: key) {
    type = ItemDataFormType.dropDown;
  }

  ItemDataFormComponent.checkBoxLabel({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.autoCheckOnClick = true,
    this.checkBoxType,
    this.checkBoxLabel,
    this.checkBoxWidget,
    this.isSelected = false,
    this.iconLeftPath = '',
    this.onTap,
    this.hasDividerLine = false,
    this.validate,
  }) : super(key: key) {
    type = ItemDataFormType.checkBoxLabel;
  }

  ItemDataFormComponent.signature({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.backgroundColor = Colors.white,
    this.colorSignature = KPrimary,
    this.hasDividerLine = false,
    this.validate,
  }) : super(key: key) {
    type = ItemDataFormType.signature;
  }

  @override
  ItemDataFormComponentState createState() => ItemDataFormComponentState();
}

class ItemDataFormComponentState extends State<ItemDataFormComponent> {
  bool isValid = true;
  String textError = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !widget.label.isNullOrEmpty(),
          child: const SizedBox(
            height: 15,
          ),
        ),
        _label(),
        const SizedBox(
          height: 5,
        ),
        _content(),
        const SizedBox(
          height: 5,
        ),
        Visibility(
          visible: widget.hasDividerLine,
          child: Divider(
            color: widget.isValid ? KGrey_L4 : KPrimary_L1,
            thickness: 1.5,
          ),
        ),
      ],
    );
  }

  _label() {
    return Visibility(
      visible: !widget.label.isNullOrEmpty(),
      child: Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.label,
              softWrap: true,
              style: TextStyle(
                  color: widget.isValid ? KGrey : KPrimary_L1,
                  fontWeight:
                      widget.isValid ? FontWeight.normal : FontWeight.bold,
                  fontSize: KFontSizeMedium35),
            ),
          )),
    );
  }

  _content() {
    switch (widget.type) {
      case ItemDataFormType.text:
        return _text();
      case ItemDataFormType.number:
        return _number();
      case ItemDataFormType.date:
        return _date();
      case ItemDataFormType.dropDown:
        return _dropDown();
      case ItemDataFormType.checkBoxLabel:
        return _checkBoxLabel();
      default:
        return _text();
    }
  }

  _text() {
    return Material(
      borderRadius: widget.borderRadius,
      color: widget.backgroundColor,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          boxShadow: widget.boxShadow,
          border: widget.isValid
              ? widget.border
              : widget.errorBorder ?? Border.all(color: KPrimary, width: 1),
        ),
        height: widget.height,
        alignment: widget.alignment,
        child: Padding(
          padding: widget.innerPadding ?? EdgeInsets.zero,
          child: Row(
            children: [
              widget.leftIcon ?? const SizedBox.shrink(),
              Expanded(
                child: TextFormField(
                  enabled: widget.isEnabled,
                  keyboardType: widget.keyboardType,
                  onEditingComplete: widget.onEditComplete,
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(widget.maxLength),
                  ],
                  validator: (value) => validate(value),
                  controller: widget.controller,
                  cursorColor: Colors.grey,
                  obscureText: widget.isPassword,
                  obscuringCharacter: "*",
                  style: widget.isValid
                      ? widget.textStyle ??
                          const TextStyle(
                              color: KGrey, fontSize: KFontSizeMedium35)
                      : widget.errorTextStyle ??
                          const TextStyle(
                              color: KPrimary, fontSize: KFontSizeMedium35),
                  textAlign: widget.inputTextAlign ?? TextAlign.start,
                  decoration: InputDecoration(
                    hintText:
                        widget.placeholder.hasValue() ? widget.placeholder : '',
                    hintStyle: widget.placeholderStyle ??
                        const TextStyle(
                            color: KGrey_L2, fontSize: KFontSizeMedium35),
                    border: InputBorder.none,
                    isCollapsed: true,
                  ),
                ),
              ),
              widget.rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  _number() {
    return Material(
      borderRadius: widget.borderRadius,
      color: widget.backgroundColor,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          boxShadow: widget.boxShadow,
          border: widget.isValid
              ? widget.border
              : widget.errorBorder ?? Border.all(color: KPrimary, width: 1),
        ),
        height: widget.height,
        alignment: widget.alignment,
        child: Padding(
          padding: widget.innerPadding ?? EdgeInsets.zero,
          child: Row(
            children: [
              widget.leftIcon ?? const SizedBox.shrink(),
              Expanded(
                child: TextFormField(
                  onEditingComplete: widget.onEditComplete,
                  focusNode: widget.focusNode,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(widget.maxLength),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  validator: (value) => validate(value),
                  controller: widget.controller,
                  cursorColor: Colors.grey,
                  style: widget.isValid
                      ? widget.textStyle ??
                          const TextStyle(
                              color: KGrey, fontSize: KFontSizeMedium35)
                      : widget.errorTextStyle ??
                          const TextStyle(
                              color: KPrimary, fontSize: KFontSizeMedium35),
                  textAlign: widget.inputTextAlign ?? TextAlign.start,
                  decoration: InputDecoration(
                    hintText:
                        widget.placeholder.hasValue() ? widget.placeholder : '',
                    hintStyle: widget.placeholderStyle ??
                        const TextStyle(
                            color: KGrey_L2, fontSize: KFontSizeMedium35),
                    border: InputBorder.none,
                    isCollapsed: true,
                  ),
                ),
              ),
              widget.rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  _date() {
    return GestureDetector(
      onTap: () => selectDate(context),
      child: Material(
        color: widget.backgroundColor,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.selectedDate != null
                ? DateFormat('dd/MM/yyyy').format(widget.selectedDate!)
                : "DD/MM/YYYY",
            style: TextStyle(
                color: widget.selectedDate != null ? Colors.black : KGrey_L2),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:
            widget.selectedDate != null ? widget.selectedDate! : DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: KPrimary,
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: KGrey_L2), //selection color
            ),
            child: child!,
          );
        });
    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate = picked;
      });
    }
  }

  _dropDown() {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            boxShadow: widget.boxShadow,
            borderRadius: widget.borderRadius,
          ),
          padding: widget.innerPadding,
          child: DropdownButton(
            hint: Text(
                widget.selectedItem != null
                    ? widget.selectedItem.toString()
                    : widget.placeholder ?? "",
                maxLines: widget.dropdownValueMaxLines,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: KGrey,
                  fontWeight: FontWeight.normal,
                  fontSize: KFontSizeMedium35,
                )),
            isExpanded: true,
            isDense: widget.isDense,
            style: const TextStyle(
              color: KGrey,
              fontWeight: FontWeight.normal,
              fontSize: KFontSizeMedium35,
            ),
            underline: const SizedBox.shrink(),
            icon: const Icon(Icons.keyboard_arrow_down,
                size: 35, color: KPrimary_L1),
            items: widget.items.map((dynamic value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(
                  value,
                  maxLines: widget.dropdownItemMaxLines,
                  overflow: TextOverflow.ellipsis,
                  key: Key(value.toString()),
                  style: const TextStyle(
                    color: KGrey,
                    fontWeight: FontWeight.normal,
                    fontSize: KFontSizeMedium35,
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                widget.selectedItem = newValue;
                widget.onChange(newValue);
              });
            },
          ),
        ));
  }

  _checkBoxLabel() {
    return Row(
      children: [
        Visibility(
          visible: !widget.iconLeftPath.isNullOrEmpty(),
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            height: 27,
            width: 27,
            child: Image.asset(
              widget.iconLeftPath!,
              color: KGrey,
            ),
          ),
        ),
        Expanded(
          child: CheckboxComponent(
            autoCheckOnClick: widget.autoCheckOnClick,
            isLabelOnTheLeft: widget.checkBoxType == CheckBoxLabelType.left,
            mainAxisAlignment: widget.checkBoxType == CheckBoxLabelType.left
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            icon: const ImageIcon(
              AssetImage("images/icon_checkbox.png"),
              color: Colors.white,
            ),
            onTap: widget.onTap,
            label: Flexible(
              child: Material(
                type: MaterialType.transparency,
                child: !widget.checkBoxLabel.isNullOrEmpty()
                    ? Text(
                        widget.checkBoxLabel!,
                        style: const TextStyle(
                          color: KGrey,
                          fontWeight: FontWeight.normal,
                          fontSize: KFontSizeMedium35,
                        ),
                      )
                    : widget.checkBoxWidget,
              ),
            ),
            isSelected: widget.isSelected,
          ),
        ),
      ],
    );
  }

  validate(String? value) {
    setState(() {
      String? validatorData =
          widget.validate != null ? widget.validate!(value!) : null;
      textError = validatorData ?? "";
      isValid = (widget.validate == null ||
              validatorData == null ||
              validatorData.isEmpty) &&
          (!widget.isRequired || (widget.isRequired && value!.isNotEmpty));
    });
    //  textError=validatorData!;
  }
}
