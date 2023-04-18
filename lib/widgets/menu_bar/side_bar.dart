import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/widgets/menu_bar/drawer_header_top.dart';
import 'package:administration_course/widgets/menu_bar/drawer_menu.dart';
import 'package:administration_course/widgets/page/notification_blank_data_result.dart';
import 'package:administration_course/widgets/page/notification_data_not_found.dart';
import 'package:administration_course/widgets/page/notification_error_data.dart';
import 'package:administration_course/widgets/page/notification_no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// List Menu yang berada disamping kiri
/// Widget [SideBar] akan dimasukkan ke widget [Drawer] yang ada di halaman [layout]
class SideBar extends StatefulWidget {
  const SideBar({
    Key? key,
    required this.currentUser,
  }) : super(key: key);
  final User currentUser;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kBackgroundVeryLightColor,
      child: Column(
        children: [
          DrawerHeaderTop(currentUser: widget.currentUser),
          DrawerMenu(currentUser: widget.currentUser),
        ],
      ),
    );
  }
}
