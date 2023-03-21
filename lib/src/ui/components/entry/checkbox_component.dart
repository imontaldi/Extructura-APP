import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckboxComponent extends StatefulWidget {
  final Widget? label;
  final ImageIcon? icon;
  Function(bool isCheck)? onTap;
  final Color selectedColor;
  bool isSelected;
  final bool isLabelOnTheLeft;
  final double spacing;
  final double height;
  final double width;
  bool autoCheckOnClick;
  final MainAxisAlignment mainAxisAlignment;
  bool checkhasShadow = false;

  CheckboxComponent(
      {Key? key,
      this.label,
      this.icon,
      this.onTap,
      this.selectedColor = const Color(0xFFE12E31),
      this.isSelected = false,
      this.isLabelOnTheLeft = false,
      this.spacing = 10,
      this.height = 25,
      this.width = 25,
      this.autoCheckOnClick = true,
      this.checkhasShadow = false,
      this.mainAxisAlignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  CheckboxComponentState createState() => CheckboxComponentState();
}

class CheckboxComponentState extends State<CheckboxComponent> {
  CheckboxComponentState();

  final colorLabel = const Color(0xFF666666);
  final Color shadowColor = const Color(0x1A666666);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(),
        child: _content());
  }

  _onTap() {
    setState(() {
      if (widget.autoCheckOnClick) {
        widget.isSelected = !widget.isSelected;
      }
    });

    if (widget.onTap != null) {
      widget.onTap!(widget.isSelected);
    }
  }

  _content() {
    List<Widget> children = _getChildren();
    return Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children);
  }

  _getChildren() {
    List<Widget> children = [];
    if (widget.isLabelOnTheLeft) {
      if (widget.label != null) {
        children.addAll(
            [Expanded(child: widget.label!), const SizedBox(width: 10)]);
      }
      children.add(_checkBox());
    } else {
      children.add(_checkBox());
      if (widget.label != null) {
        children.addAll([const SizedBox(width: 10), widget.label!]);
      }
    }
    return children;
  }

  _checkBox() {
    return Container(
      padding: const EdgeInsets.all(5),
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.isSelected ? widget.selectedColor : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(7)),
        boxShadow: [
          !widget.checkhasShadow
              ? BoxShadow(
                  color: widget.isSelected
                      ? widget.selectedColor.withOpacity(0.1)
                      : shadowColor,
                  spreadRadius: 2,
                  blurRadius: 1,
                )
              : BoxShadow(
                  color: const Color(0xFFC4C4C4).withOpacity(0.7),
                  blurRadius: 3.0,
                  offset: const Offset(0.0, 2.5)),
        ],
      ),
      child: Visibility(
        visible: widget.icon != null,
        child: widget.icon!,
      ),
    );
  }
}
