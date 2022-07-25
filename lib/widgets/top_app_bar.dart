import 'package:administration_course/constants/style.dart';
import 'package:administration_course/helpers/responsiveness.dart';
import 'package:administration_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';

/// fungsi [topNavigationBar] digunakan untuk kita membuka menu menu yang ada di [AppBar] sesuai dengan [key]
/// contoh menu setting, profile, notification
AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: dark),
      backgroundColor: Colors.transparent, /// set background App Bar jadi transparent 

      /// if [isSmallScreen] then show the menu icon, else show the logo
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Image.asset(
                    'assets/icons/logo.png',
                    width: 24,
                  ),
                )
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState?.openDrawer();
              },
              icon: Icon(Icons.menu)),
      title: Row(
        children: [
          Visibility(
              child: CustomText(
                  text: "Dash",
                  size: 20,
                  color: lightGrey,
                  weight: FontWeight.bold)),
          Expanded(child: Container()),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
            color: dark.withOpacity(.7),
          ),
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: dark.withOpacity(.7),
                  ))
            ],
          ),
          Positioned(
              top: 7,
              right: 7,
              child: Container(
                width: 12,
                height: 12,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: light, width: 2)),
              )),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          SizedBox(
            width: 24,
          ),
          CustomText(
              text: 'Celine Martha',
              size: 24,
              color: lightGrey,
              weight: FontWeight.normal),
          SizedBox(
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              child: CircleAvatar(
                  backgroundColor: light,
                  child: Icon(
                    Icons.person_outline,
                    color: dark,
                  )),
            ),
          )
        ],
      ),
    );
