// Flutter imports:
import 'package:extructura_app/values/k_values.dart';
import 'package:flutter/material.dart';

import '../../../../values/k_colors.dart';

// ignore: must_be_immutable
class FaqCardComponent extends StatefulWidget {
  final String title;
  String? subtitle;
  final String? cardNumber;
  final String? description;
  final TextStyle? style;
  final int columnCount;
  bool isExpanded;
  final double radius;
  bool static = false;

  FaqCardComponent({
    Key? key,
    required this.title,
    this.style,
    this.cardNumber,
    this.columnCount = 7,
    this.description,
    this.isExpanded = false,
    this.static = false,
    this.radius = 20,
    this.subtitle,
  }) : super(key: key);

  @override
  FaqCardComponentState createState() => FaqCardComponentState();
}

class FaqCardComponentState extends State<FaqCardComponent> {
  FaqCardComponentState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: KWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(
            widget.radius,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.title,
                  style: widget.style ??
                      TextStyle(
                        fontSize: KFontSizeMedium35,
                        color: widget.isExpanded ? KPrimary : KGrey,
                        fontWeight: widget.isExpanded
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(
                  () {
                    widget.isExpanded = !widget.isExpanded;
                  },
                ),
                child: Image.asset(
                  widget.isExpanded == true
                      ? "images/icon_arrow_up.png"
                      : "images/icon_arrow_down.png",
                  color: KGrey,
                ),
              ),
            ],
          ),
          Visibility(
            visible: widget.isExpanded,
            child: const SizedBox(
              height: 15,
            ),
          ),
          Visibility(
            visible: widget.isExpanded,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _description(),
            ),
          ),
        ],
      ),
    );
  }

  _description() {
    return Text(
      widget.description!,
      style: const TextStyle(
        fontSize: KFontSizeMedium35,
        color: KGrey,
      ),
    );
  }
}
