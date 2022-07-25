import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/helpers/responsiveness.dart';
import 'package:administration_course/routing/routes.dart';
import 'package:administration_course/widgets/custom_text.dart';
import 'package:administration_course/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// List Menu yang berada disamping kiri
/// Widget [SideMenu] akan dimasukkan ke widget [Drawer] yang ada di halaman [layout]
class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: _width / 48,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Image.asset('assets/icons/logo.png'),
                    ),
                    Flexible(
                        child: CustomText(
                            text: "Dash",
                            size: 20,
                            color: active,
                            weight: FontWeight.bold)),
                             SizedBox(width: _width / 48),
                  ],
                ),
                SizedBox(
                      height: 30,
                    ),
              ],
            ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((itemName) => SideMenuItem(
                    itemName: itemName,
                    onTap: () {
                      if (itemName == AuthenticationPageRoute) {
                        // TODO:: go to authentication page
                      }

                      if (!menuController.isActive(itemName)) {
                        menuController.changeActiveItmeTo(itemName);
                        if (ResponsiveWidget.isSmallScreen(context)) {
                          Get.back();
                          // TO DO:: go to item name route
                        }
                      }
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
