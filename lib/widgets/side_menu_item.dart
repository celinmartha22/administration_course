import 'package:administration_course/helpers/responsiveness.dart';
import 'package:administration_course/widgets/horizontal_menu_item.dart';
import 'package:administration_course/widgets/vertical_menu_item.dart';
import 'package:flutter/material.dart';

/// [SideMenuItem] menentukan side menu model mana yang akan ditampilkan sesuai screen size
class SideMenuItem extends StatelessWidget {
  const SideMenuItem({Key? key, required this.itemName, required this.onTap})
      : super(key: key);
  final String itemName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isMediumScreen(context)) {
      return VerticalMenuItem(itemName: itemName, onTap: onTap);
    } else {
      return HorizontalMenuItem(itemName: itemName, onTap: onTap);
    }
  }
}
