import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class DrawerHeaderTop extends StatefulWidget {
  static final ValueNotifier<User> userNotifier = ValueNotifier(User(
      idUser: '',
      username: '',
      password: '',
      name: '',
      email: '',
      loginStatus: 0));
  DrawerHeaderTop({super.key, required this.currentUser});
  User currentUser;

  @override
  State<DrawerHeaderTop> createState() => _DrawerHeaderTopState();
}

class _DrawerHeaderTopState extends State<DrawerHeaderTop> {
  @override
  void initState() {
    super.initState();
    setState(() {
      DrawerHeaderTop.userNotifier.value = widget.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<User>(
        valueListenable: DrawerHeaderTop.userNotifier,
        builder: (_, tasks, __) {
          final user = tasks;
          return UserAccountsDrawerHeader(
            onDetailsPressed: () {
              Navigator.of(context)
                  .pushNamed(ProfilePage.routeName, arguments: user);
            },
            decoration: const BoxDecoration(
              color: kBackgroundLightColor,
            ),
            accountName: Text(user.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: kTextDarkColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0)),
            accountEmail: Text(user.email,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: kSubTextColor, letterSpacing: 0)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: kPrimaryLightColor,
              child: Text(user.name.substring(0, 1),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: kBackgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      letterSpacing: 0)),
            ),
          );
        });
  }
}
