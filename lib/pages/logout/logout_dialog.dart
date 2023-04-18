import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/data/provider/user_all_provider.dart';
import 'package:administration_course/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

logoutDialog(
    BuildContext context, String tipe, String contentText, User userLoggedin) {
  debugPrint("LOGOUT User => ${userLoggedin.username} - ${userLoggedin.name}");
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "LOGOUT",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Wrap(
            children: <Widget>[
              // Expanded(
              //     flex: 2,
              //     child: Image.asset('assets/images/Yesorno-amico.png')),
              Text(
                contentText,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: kPrimaryColor, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "BATAL",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: kTextBlackColor, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "LANJUT",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: kTextBlackColor, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                if (tipe == "logout") {
                  sidemenuController.changeActiveItmeTo("Home");
                  Provider.of<UserAllProvider>(context, listen: false)
                      .updateUserStatus(userLoggedin.idUser, 0);
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(
                      context, WelcomePage.routeName, (route) => false);
                } else if (tipe == "close") {
                  SystemNavigator.pop();
                }
              },
            ),
          ],
        );
      });
}
