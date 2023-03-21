// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: overridden_fields, deprecated_member_use

import 'package:flutter/material.dart';

const Duration _materialBannerTransitionDuration = Duration(milliseconds: 250);
const Curve _materialBannerHeightCurve = Curves.fastOutSlowIn;

class MaterialBannerCustom extends MaterialBanner {
  /// Creates a [MaterialBannerCustom].
  ///
  /// The [actions], [content], and [forceActionsBelow] must be non-null.
  /// The [actions].length must be greater than 0. The [elevation] must be null or
  /// non-negative.
  const MaterialBannerCustom(
      {Key? key,
      required this.content,
      this.contentTextStyle,
      required this.actions,
      this.elevation,
      this.leading,
      this.backgroundColor,
      this.padding,
      this.leadingPadding,
      this.forceActionsBelow = false,
      this.overflowAlignment = OverflowBarAlignment.end,
      this.animation,
      this.onVisible})
      : assert(elevation == null || elevation >= 0.0),
        super(key: key, content: content, actions: actions);

  /// The content of the [MaterialBannerCustom].
  ///
  /// Typically a [Text] widget.
  @override
  final Widget content;

  /// Style for the text in the [content] of the [MaterialBannerCustom].
  ///
  /// If `null`, [MaterialBannerThemeData.contentTextStyle] is used. If that is
  /// also `null`, [TextTheme.bodyText2] of [ThemeData.textTheme] is used.
  @override
  final TextStyle? contentTextStyle;

  /// The set of actions that are displayed at the bottom or trailing side of
  /// the [MaterialBannerCustom].
  ///
  /// Typically this is a list of [TextButton] widgets.
  @override
  final List<Widget> actions;

  /// The z-coordinate at which to place the material banner.
  ///
  /// This controls the size of the shadow below the material banner.
  ///
  /// Defines the banner's [Material.elevation].
  ///
  /// If this property is null, then [MaterialBannerThemeData.elevation] of
  /// [ThemeData.bannerTheme] is used, if that is also null, the default value is 0.
  /// If the elevation is 0, the [Scaffold]'s body will be pushed down by the
  /// MaterialBanner when used with [ScaffoldMessenger].
  @override
  final double? elevation;

  /// The (optional) leading widget of the [MaterialBannerCustom].
  ///
  /// Typically an [Icon] widget.
  @override
  final Widget? leading;

  /// The color of the surface of this [MaterialBannerCustom].
  ///
  /// If `null`, [MaterialBannerThemeData.backgroundColor] is used. If that is
  /// also `null`, [ColorScheme.surface] of [ThemeData.colorScheme] is used.
  @override
  final Color? backgroundColor;

  /// The amount of space by which to inset the [content].
  ///
  /// If the [actions] are below the [content], this defaults to
  /// `EdgeInsetsDirectional.only(start: 16.0, top: 24.0, end: 16.0, bottom: 4.0)`.
  ///
  /// If the [actions] are trailing the [content], this defaults to
  /// `EdgeInsetsDirectional.only(start: 16.0, top: 2.0)`.
  @override
  final EdgeInsetsGeometry? padding;

  /// The amount of space by which to inset the [leading] widget.
  ///
  /// This defaults to `EdgeInsetsDirectional.only(end: 16.0)`.
  @override
  final EdgeInsetsGeometry? leadingPadding;

  /// An override to force the [actions] to be below the [content] regardless of
  /// how many there are.
  ///
  /// If this is true, the [actions] will be placed below the [content]. If
  /// this is false, the [actions] will be placed on the trailing side of the
  /// [content] if [actions]'s length is 1 and below the [content] if greater
  /// than 1.
  ///
  /// Defaults to false.
  @override
  final bool forceActionsBelow;

  /// The horizontal alignment of the [actions] when the [actions] laid out in a column.
  ///
  /// Defaults to [OverflowBarAlignment.end].
  @override
  final OverflowBarAlignment overflowAlignment;

  /// The animation driving the entrance and exit of the material banner when presented by the [ScaffoldMessenger].
  @override
  final Animation<double>? animation;

  /// Called the first time that the material banner is visible within a [Scaffold] when presented by the [ScaffoldMessenger].
  @override
  final VoidCallback? onVisible;

  // API for ScaffoldMessengerState.showMaterialBanner():

  /// Creates an animation controller useful for driving a material banner's entrance and exit animation.
  static AnimationController createAnimationController(
      {required TickerProvider vsync}) {
    return AnimationController(
      duration: _materialBannerTransitionDuration,
      debugLabel: 'MaterialBanner',
      vsync: vsync,
    );
  }

  /// Creates a copy of this material banner but with the animation replaced with the given animation.
  ///
  /// If the original material banner lacks a key, the newly created material banner will
  /// use the given fallback key.
  @override
  MaterialBannerCustom withAnimation(Animation<double> newAnimation,
      {Key? fallbackKey}) {
    return MaterialBannerCustom(
      key: key ?? fallbackKey,
      content: content,
      contentTextStyle: contentTextStyle,
      actions: actions,
      elevation: elevation,
      leading: leading,
      backgroundColor: backgroundColor,
      padding: padding,
      leadingPadding: leadingPadding,
      forceActionsBelow: forceActionsBelow,
      overflowAlignment: overflowAlignment,
      animation: newAnimation,
      onVisible: onVisible,
    );
  }

  @override
  State<MaterialBannerCustom> createState() => _MaterialBannerCustomState();
}

class _MaterialBannerCustomState extends State<MaterialBannerCustom> {
  bool _wasVisible = false;

  @override
  void initState() {
    super.initState();
    widget.animation?.addStatusListener(_onAnimationStatusChanged);
  }

  @override
  void didUpdateWidget(MaterialBannerCustom oldWidget) {
    if (widget.animation != oldWidget.animation) {
      oldWidget.animation?.removeStatusListener(_onAnimationStatusChanged);
      widget.animation?.addStatusListener(_onAnimationStatusChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.animation?.removeStatusListener(_onAnimationStatusChanged);
    super.dispose();
  }

  void _onAnimationStatusChanged(AnimationStatus animationStatus) {
    switch (animationStatus) {
      case AnimationStatus.dismissed:
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.completed:
        if (widget.onVisible != null && !_wasVisible) {
          widget.onVisible!();
        }
        _wasVisible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    assert(widget.actions.isNotEmpty);

    final ThemeData theme = Theme.of(context);
    final MaterialBannerThemeData bannerTheme = MaterialBannerTheme.of(context);

    final bool isSingleRow =
        widget.actions.length == 1 && !widget.forceActionsBelow;
    final EdgeInsetsGeometry padding = widget.padding ??
        bannerTheme.padding ??
        (isSingleRow
            ? const EdgeInsetsDirectional.only(start: 16.0, top: 2.0)
            : const EdgeInsetsDirectional.only(
                start: 16.0, top: 24.0, end: 16.0, bottom: 4.0));
    final EdgeInsetsGeometry leadingPadding = widget.leadingPadding ??
        bannerTheme.leadingPadding ??
        const EdgeInsetsDirectional.only(end: 16.0);

    final Widget buttonBar = Container(
      alignment: AlignmentDirectional.centerEnd,
      constraints: const BoxConstraints(minHeight: 52.0),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: OverflowBar(
        overflowAlignment: widget.overflowAlignment,
        spacing: 8,
        children: widget.actions,
      ),
    );

    final double elevation = widget.elevation ?? bannerTheme.elevation ?? 0.0;
    final Color backgroundColor = widget.backgroundColor ??
        bannerTheme.backgroundColor ??
        theme.colorScheme.surface;
    final TextStyle? textStyle = widget.contentTextStyle ??
        bannerTheme.contentTextStyle ??
        theme.textTheme.bodyText2;

    Widget materialBanner = Container(
      margin: EdgeInsets.only(bottom: elevation > 0 ? 10.0 : 0.0),
      child: Material(
        elevation: elevation,
        color: backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: padding,
              child: Row(
                children: <Widget>[
                  if (widget.leading != null)
                    Padding(
                      padding: leadingPadding,
                      child: widget.leading,
                    ),
                  Expanded(
                    child: DefaultTextStyle(
                      style: textStyle!,
                      child: widget.content,
                    ),
                  ),
                  if (isSingleRow) buttonBar,
                ],
              ),
            ),
            if (!isSingleRow) buttonBar,
            if (elevation == 0) const Divider(height: 0),
          ],
        ),
      ),
    );

    // This provides a static banner for backwards compatibility.
    if (widget.animation == null) return materialBanner;

    final CurvedAnimation heightAnimation = CurvedAnimation(
        parent: widget.animation!, curve: _materialBannerHeightCurve);
    final Animation<Offset> slideOutAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: widget.animation!,
      curve: const Threshold(0.0),
    ));

    materialBanner = Semantics(
      container: true,
      liveRegion: true,
      onDismiss: () {
        ScaffoldMessenger.of(context).removeCurrentMaterialBanner(
            reason: MaterialBannerClosedReason.dismiss);
      },
      child: mediaQueryData.accessibleNavigation
          ? materialBanner
          : SlideTransition(
              position: slideOutAnimation,
              child: materialBanner,
            ),
    );

    final Widget materialBannerTransition;
    if (mediaQueryData.accessibleNavigation) {
      materialBannerTransition = materialBanner;
    } else {
      materialBannerTransition = AnimatedBuilder(
        animation: heightAnimation,
        builder: (BuildContext context, Widget? child) {
          return Align(
            alignment: AlignmentDirectional.bottomStart,
            heightFactor: heightAnimation.value,
            child: child,
          );
        },
        child: materialBanner,
      );
    }

    return SafeArea(
      child: Hero(
        tag: '<MaterialBanner Hero tag - ${widget.content}>',
        child: ClipRect(child: materialBannerTransition),
      ),
    );
  }
}
