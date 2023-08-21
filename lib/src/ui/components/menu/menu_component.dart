import 'package:extructura_app/values/k_apk_date.dart';
import 'package:flutter/material.dart';
import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';
import 'package:flutter/services.dart';

class MenuDrawerItem {
  final String text;
  final Widget? icon;
  final Function? onTap;
  final bool hasDropdown;
  bool isDropdownEnabled;
  final Function? onDropdown;
  List<MenuDrawerItem>? listSubMenu;
  bool isVisible;

  MenuDrawerItem({
    this.text = "",
    this.icon,
    this.onTap,
    this.hasDropdown = false,
    this.isDropdownEnabled = false,
    this.onDropdown,
    this.listSubMenu,
    this.isVisible = true,
  });
}

class MenuComponent extends StatefulWidget {
  final Function closeMenu;
  final double? width;

  const MenuComponent({required this.closeMenu, this.width})
      : super(
          key: const Key('menu'),
        );

  @override
  MenuComponentState createState() => MenuComponentState();
}

class MenuComponentState extends State<MenuComponent> {
  final List<MenuDrawerItem> _items = [
    MenuDrawerItem(
        text: "Página Principal",
        icon: const Icon(Icons.home_rounded, color: KPrimary, size: 30.0),
        onTap: () {
          PageManager().goHomePage();
        }),
    MenuDrawerItem(
        text: "Ver tutorial",
        icon: const Icon(Icons.video_library_rounded,
            color: KPrimary, size: 30.0),
        onTap: () {
          PageManager().goTutorialPage();
        }),
    MenuDrawerItem(
        text: "FAQ",
        icon: const Icon(Icons.question_answer_rounded,
            color: KPrimary, size: 30.0),
        onTap: () {
          PageManager().goFAQPage();
        }),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: Container(
          color: KPrimary,
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: _menuContent(),
            ),
          ),
        ),
      ),
    );
  }

  _menuContent() {
    return Column(
      key: const Key('menuContent'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(),
        const Divider(
          height: 0,
          color: Color(0XFFBDBDBD),
          thickness: 1,
        ),
        Expanded(
          child: _options(),
        ),
        _footer()
        //_footer()
      ],
    );
  }

  _header() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding:
            const EdgeInsets.only(top: 40, bottom: 30, left: 30, right: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        key: const Key('menuHeader'),
        child: _data(),
      ),
    );
  }

  _data() {
    return Center(
      child: Row(
        children: [
          Container(
            height: 35,
            width: 35,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: KPrimary),
            child: Center(
              child: Image.asset(
                "images/app_icon/icon_transparent_background.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text("Extructura",
                style: TextStyle(
                    color: KPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: KFontSizeXLarge45)),
          ),
        ],
      ),
    );
  }

  _options() {
    return ListView.builder(
        itemCount: _items.length,
        padding: const EdgeInsets.only(top: 5),
        itemBuilder: (_, int index) {
          return _item(_items[index]);
        });
  }

  _item(MenuDrawerItem item) {
    return Visibility(
      visible: true,
      child: GestureDetector(
        onTap: () {
          if (item.onTap != null) {
            item.onTap!();
          } else {
            item.isDropdownEnabled = !item.isDropdownEnabled;
            setState(() {});
          }
        },
        child: Container(
          color: !item.hasDropdown
              ? Colors.transparent
              : !item.isDropdownEnabled
                  ? Colors.transparent
                  : const Color(0xFFEDEDED),
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 0.0, right: 15.0),
                      child: item.icon,
                    ),
                    Expanded(
                      child: Text(
                        item.text,
                        style: const TextStyle(
                            color: KGrey,
                            fontWeight: FontWeight.w400,
                            fontSize: KFontSizeMedium35),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Visibility(
                        visible: item.hasDropdown,
                        child: const SizedBox(width: 20)),
                    Visibility(
                        visible: item.hasDropdown,
                        child: _hasDropdown(item.isDropdownEnabled)),
                  ],
                ),
              ),
              Visibility(
                visible: item.hasDropdown && item.isDropdownEnabled,
                child: _subMenu(item),
              )
            ],
          ),
        ),
      ),
    );
  }

  _subMenu(MenuDrawerItem item) {
    if (item.listSubMenu != null) {
      return Column(
        children: [
          for (int i = 0; i < item.listSubMenu!.length; i++)
            _itemSubMenu(item.listSubMenu![i])
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _itemSubMenu(MenuDrawerItem item) {
    return GestureDetector(
      onTap: () {
        if (item.onTap != null) {
          item.onTap!();
        } else {
          item.isDropdownEnabled = !item.isDropdownEnabled;
          setState(() {});
        }
      },
      child: Visibility(
        visible: item.isVisible,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 85, top: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  item.text,
                  style: const TextStyle(
                      color: KGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: KFontSizeMedium35),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _hasDropdown(bool isDropdownEnabled) {
    if (isDropdownEnabled) {
      return Image.asset("images/icon_arrow_top.png", height: 15);
    } else {
      return Image.asset("images/icon_arrow_bottom.png", height: 15);
    }
  }

  _footer() {
    return Column(
      key: const Key('menuFooter'),
      children: <Widget>[
        // Borrar despues
        const Text(
          "Versión: $kAPKDate",
          style: TextStyle(
            color: KGrey,
            fontWeight: FontWeight.w400,
            fontSize: KFontSizeMedium35,
          ),
        ),
        const SizedBox(height: 20),
        // ---------------------
        const Divider(
          height: 0,
          color: Color(0XFFC7C7C7),
          thickness: 1,
        ),
        _item(
          MenuDrawerItem(
            onTap: () => {
              PageManager().openInformationPopup(
                title: "¿Desea salir de la aplicación?",
                imageURL: "images/icon_warning.png",
                labelButtonAccept: "Si",
                labelButtonCancel: "No",
                isCancellable: false,
                onAccept: () => SystemNavigator.pop(),
              )
            },
            text: "Salir",
            icon: const Icon(
              Icons.logout,
              color: KPrimary,
              size: 30.0,
            ),
          ),
        )
      ],
    );
  }
}
