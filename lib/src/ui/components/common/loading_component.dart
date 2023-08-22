// ignore_for_file: unnecessary_type_check, unnecessary_null_comparison

import 'package:extructura_app/values/k_values.dart';
import 'package:flutter/material.dart';
import 'package:extructura_app/values/k_colors.dart';

class Loading extends StatefulWidget {
  const Loading({
    Key? key,
    this.color = Colors.grey,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 2000),
  })  : assert(
            !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
                !(itemBuilder == null && color == null),
            'You should specify either a itemBuilder or a color'),
        assert(size != null),
        super(key: key);

  final Color color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;

  @override
  SpinKitChasingDotsState createState() => SpinKitChasingDotsState();
}

class SpinKitChasingDotsState extends State<Loading>
    with TickerProviderStateMixin {
  late AnimationController _scaleCtrl, _rotateCtrl;
  late Animation<double> _scale, _rotate;

  @override
  void initState() {
    super.initState();

    _scaleCtrl = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() => setState(() {}))
      ..repeat(reverse: true);
    _scale = Tween(begin: -1.0, end: 1.0)
        .animate(CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeInOut));

    _rotateCtrl = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() => setState(() {}))
      ..repeat();
    _rotate = Tween(begin: 0.0, end: 360.0)
        .animate(CurvedAnimation(parent: _rotateCtrl, curve: Curves.linear));
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    _rotateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Transform.rotate(
          angle: _rotate.value * 0.0174533,
          child: Stack(
            children: <Widget>[
              Positioned(top: 0.0, child: _circle(1.0 - _scale.value.abs(), 0)),
              Positioned(bottom: 0.0, child: _circle(_scale.value.abs(), 1)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circle(double scale, int index) {
    return Transform.scale(
      scale: scale,
      child: SizedBox.fromSize(
        size: Size.square(widget.size * 0.6),
        child: widget.itemBuilder != null
            ? widget.itemBuilder!(context, index)
            : DecoratedBox(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: widget.color)),
      ),
    );
  }
}

Widget loadingComponent(bool isVisible,
    {Color color = KPrimary,
    Color backgroundColor = Colors.white,
    double size = 50,
    EdgeInsetsGeometry? padding,
    String? loadingText}) {
  return Visibility(
    visible: isVisible,
    child: Container(
      padding: padding ?? const EdgeInsets.all(0),
      color: backgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Loading(
            color: color,
            size: size,
          ),
          Visibility(
            visible: loadingText != null,
            child: Column(
              children: [
                const SizedBox(height: 30),
                Material(
                  color: Colors.transparent,
                  child: Text(
                    loadingText ?? "",
                    style: TextStyle(
                      color: KWhite,
                      fontSize: KFontSizeXLarge45,
                      fontWeight: FontWeight.w700,
                      background: Paint()..color = Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
