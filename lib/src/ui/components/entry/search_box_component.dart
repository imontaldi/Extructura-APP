import 'package:flutter/material.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';

class SearchBox extends StatefulWidget {
  const SearchBox(
      {Key? key,
      this.onTap,
      this.onTextChange,
      this.height = 35,
      this.placeHolder})
      : super(key: key);

  final Function()? onTap;
  final Function(String)? onTextChange;
  final double height;
  final String? placeHolder;

  @override
  SearchBoxState createState() => SearchBoxState();
}

class SearchBoxState extends State<SearchBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: KGrey_L3, width: 1.5),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/icon_search.png", width: 22, height: 22),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                onTap: widget.onTap,
                cursorColor: KGrey,
                textAlign: TextAlign.start,
                maxLines: 1,
                style: const TextStyle(
                  color: KGrey_L3,
                  fontWeight: FontWeight.normal,
                  fontSize: KFontSizeMedium35,
                ),
                onChanged: (value) {
                  if (widget.onTextChange != null) {
                    widget.onTextChange!(value);
                  }
                },
                decoration: InputDecoration(
                    isDense: true,
                    hintText: widget.placeHolder,
                    hintStyle: const TextStyle(
                      color: KGrey_L3,
                      fontWeight: FontWeight.normal,
                      fontSize: KFontSizeMedium35,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ]),
    );
  }
}
