import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/pages/logout/logout_dialog.dart';
import 'package:administration_course/responsive.dart';
import 'package:administration_course/routing/routes.dart';
import 'package:administration_course/widgets/layout/app_layout.dart';
import 'package:administration_course/widgets/menu_bar/drawer_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [DrawerMenu] menentukan side menu model mana yang akan ditampilkan sesuai screen size
class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
    required this.currentUser,
  }) : super(key: key);
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    void onTapMenu(int index, String itemName, String itemRoute) {
      if (!sidemenuController.isActive(itemName)) {
        sidemenuController.changeActiveItmeTo(itemName);
        if (Responsive.isMobile(context)) {
          Get.back();
        }
      }

      if (itemRoute == logoutPageRoute) {
        logoutDialog(context, "logout",
            "${currentUser.name}, Anda akan logout dari aplikasi", currentUser);
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppLayout(
                      currentUser: currentUser,
                      selectedMenu: index,
                    )));
      }
    }

    return Flexible(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sideMenuItems.length,
          itemBuilder: (BuildContext context, int i) {
            return DrawerMenuItem(
                itemName: sideMenuItems[i][0],
                itemRoute: sideMenuItems[i][1],
                onTap: () =>
                    onTapMenu(i, sideMenuItems[i][0], sideMenuItems[i][1]));
          }),
    );
  }
}
