import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';

// ignore: must_be_immutable
class PdfReaderNavigationBarComponent extends StatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? titleContent;
  bool isContentBarExtended;
  bool isFooterBarExtended;
  Widget? contentExtendContent;
  double contentExtendHeight;
  Widget? footerExtendedContent;
  final bool hasBack;
  final bool showPageIndicator;
  final Function()? onBackClick;
  PdfController pdfController;

  PdfReaderNavigationBarComponent({
    Key? key,
    this.title = '',
    this.isContentBarExtended = false,
    this.isFooterBarExtended = false,
    this.contentExtendContent,
    this.footerExtendedContent,
    this.contentExtendHeight = 0,
    this.titleContent,
    this.hasBack = false,
    this.onBackClick,
    this.showPageIndicator = false,
    required this.pdfController,
  }) : super(key: key);

  @override
  PdfReaderNavigationBarComponentState createState() =>
      PdfReaderNavigationBarComponentState();
  final double barSize = 55;
  final double footerBarSize = 45;

  @override
  Size get preferredSize => Size.fromHeight(
        ((isFooterBarExtended && isContentBarExtended)
            ? barSize + footerBarSize + contentExtendHeight + 5
            : (isFooterBarExtended)
                ? barSize + footerBarSize
                : (isContentBarExtended)
                    ? barSize + contentExtendHeight
                    : barSize),
      );
}

class PdfReaderNavigationBarComponentState
    extends State<PdfReaderNavigationBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: ((widget.isFooterBarExtended && widget.isContentBarExtended)
              ? widget.barSize +
                  widget.footerBarSize +
                  widget.contentExtendHeight
              : (widget.isFooterBarExtended)
                  ? widget.barSize + widget.footerBarSize
                  : (widget.isContentBarExtended)
                      ? widget.barSize + widget.contentExtendHeight
                      : widget.barSize) +
          5,
      child: Column(
        children: [
          _menu(),
          AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: widget.isFooterBarExtended ? 45 : 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Material(
                    elevation: 1,
                    child: Container(
                      height: 40,
                      color: Colors.white,
                      child: widget.footerExtendedContent,
                    ),
                  ),
                ],
              )),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: widget.isContentBarExtended
                ? widget.contentExtendHeight + 5
                : 0,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                _menuButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _menu() {
    return Material(
      elevation: 4,
      shadowColor: KGrey_L4.withOpacity(0.5),
      child: Container(
        height: 55,
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: (widget.titleContent != null)
                  ? widget.titleContent!
                  : Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                              color: Color(0xFF666666), fontSize: 15),
                        ),
                      ),
                    ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _menuButton(),
                    const Spacer(),
                    Visibility(
                      visible: widget.showPageIndicator,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          backPageIcon(),
                          pageNumberIndicator(),
                          forwardPageIcon(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _menuButtons() {
    return Container(
      height: widget.contentExtendHeight,
      color: Colors.white,
      child: widget.contentExtendContent,
    );
  }

  _menuButton() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(40.0)),
      child: Material(
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onBackClick,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: widget.hasBack
                ? Image.asset(
                    "images/icon_button_back.png",
                    color: KPrimary,
                    alignment: Alignment.centerLeft,
                    height: 20,
                    width: 20,
                  )
                : Image.asset(
                    "images/icon_menu.png",
                    color: KPrimary,
                    alignment: Alignment.centerLeft,
                    height: 20,
                    width: 20,
                  ),
          ),
        ),
      ),
    );
  }

  Widget backPageIcon() {
    return IconButton(
      icon: const Icon(
        Icons.navigate_before,
        size: 25,
        color: KPrimary,
      ),
      onPressed: () {
        widget.pdfController.previousPage(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 100),
        );
      },
    );
  }

  Widget pageNumberIndicator() {
    return PdfPageNumber(
      controller: widget.pdfController,
      builder: (_, loadingState, page, pagesCount) => Container(
        alignment: Alignment.center,
        child: Text(
          '$page/${pagesCount ?? 0}',
          style: const TextStyle(
            fontSize: KFontSizeLarge40,
            color: KGrey,
          ),
        ),
      ),
    );
  }

  Widget forwardPageIcon() {
    return IconButton(
      icon: const Icon(
        Icons.navigate_next,
        size: 25,
        color: KPrimary,
      ),
      onPressed: () {
        widget.pdfController.nextPage(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 100),
        );
      },
    );
  }
}
