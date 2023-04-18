import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/pages/logout/logout_dialog.dart';
import 'package:administration_course/pages/profile/components/profile_pic.dart';
import 'package:administration_course/pages/profile/profile_edit_page.dart';
import 'package:administration_course/widgets/header_widget.dart';
import 'package:administration_course/pages/profile/components/profile_detail_form.dart';
import 'package:administration_course/widgets/welcome_login_signup/rounded_button.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
    static final ValueNotifier<User> userNotifier = ValueNotifier(User(
      idUser: '',
      username: '',
      password: '',
      name: '',
      email: '',
      loginStatus: 0));
  Body({super.key, required this.currentUser});
  User currentUser;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    setState(() {
      Body.userNotifier.value = widget.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<User>(
      valueListenable: Body.userNotifier,
      builder: (_, tasks, __) {
        final user = tasks;
        return SingleChildScrollView(
          child: Stack(
            children: [
              const SizedBox(
                height: 100,
                child: HeaderWidget(100, false, Icons.house_rounded),
              ),
              SizedBox(
                height: 50,
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: kDefaultPadding * 1.5,
                    )),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(
                    0, kDefaultPadding, 0, kDefaultPadding),
                padding: const EdgeInsets.fromLTRB(
                    kDefaultPadding, 0, kDefaultPadding, 0),
                child: Column(
                  children: [
                    ProfilePic(currentUser: user),
                    sizedBox,
                    Text(
                      user.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    sizedBox,
                    Column(
                      children: <Widget>[
                        ProfileDetailForm(
                          myInitialValue: user.idUser,
                          myFieldName: "ID Pengguna",
                          myIcon: Icons.person,
                          myPrefixIconColor: Colors.deepPurple.shade300,
                          isObscureText: false,
                          myMaxLine: 1,
                          myKeyboardType: TextInputType.name,
                        ),
                        ProfileDetailForm(
                          myInitialValue: user.name,
                          myFieldName: "Nama Lengkap",
                          myIcon: Icons.person,
                          myPrefixIconColor: Colors.deepPurple.shade300,
                          isObscureText: false,
                          myMaxLine: 1,
                          myKeyboardType: TextInputType.name,
                        ),
                        ProfileDetailForm(
                          myInitialValue: user.email,
                          myFieldName: "Email",
                          myIcon: Icons.email,
                          myPrefixIconColor: Colors.deepPurple.shade300,
                          isObscureText: false,
                          myMaxLine: 1,
                          myKeyboardType: TextInputType.name,
                        ),
                        ProfileDetailForm(
                          myInitialValue: user.username,
                          myFieldName: "Username",
                          myIcon: Icons.account_circle,
                          myPrefixIconColor: Colors.deepPurple.shade300,
                          isObscureText: false,
                          myMaxLine: 1,
                          myKeyboardType: TextInputType.name,
                        ),
                        ProfileDetailForm(
                          myInitialValue: user.password,
                          myFieldName: "Password",
                          myIcon: Icons.lock,
                          myPrefixIconColor: Colors.deepPurple.shade300,
                          isObscureText: true,
                          myMaxLine: 1,
                          myKeyboardType: TextInputType.name,
                        ),
                        sizedBox,
                        sizedBox,
                        Hero(
                          tag: "edit_profile",
                          child: RoundedButton(
                              text: "Edit Profile",
                              press: () {
                                Navigator.of(context).pushNamed(
                                    ProfileEditFormPage.routeName,
                                    arguments: user);
                              },
                              backColor: kPrimaryLightColor,
                              textColor: Colors.white),
                        ),
                        kHalfSizedBox,
                        Hero(
                          tag: "logout",
                          child: RoundedButton(
                              text: "Logout",
                              press: () => logoutDialog(
                                  context,
                                  "logout",
                                  "${user.name}, Anda akan logout dari aplikasi",
                                  user),
                              backColor: kPrimaryLightColor,
                              textColor: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
