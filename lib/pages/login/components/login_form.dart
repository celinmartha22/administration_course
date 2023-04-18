import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/data/provider/user_all_provider.dart';
import 'package:administration_course/responsive.dart';
import 'package:administration_course/routing/routes.dart';
import 'package:administration_course/widgets/layout/app_layout.dart';
import 'package:administration_course/pages/signup/signup_page.dart';
import 'package:administration_course/widgets/already_have_an_account_acheck.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:administration_course/constants/style.dart';

import '../../../widgets/welcome_login_signup/rounded_button.dart';
import '../../../widgets/welcome_login_signup/rounded_input_textfield.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Duration get loginTime => const Duration(milliseconds: 2250);
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final allUser = Provider.of<UserAllProvider>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> login(String user, String password) async {
      debugPrint('Login => User: $user, Password: $password');
      if (_formKey.currentState!.validate()) {
        final userLogin =
            await Provider.of<UserAllProvider>(context, listen: false)
                .getUserByUserPass(user, password);
        if (userLogin.username != user && userLogin.email != user) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Username atau Email tidak valid'),
            backgroundColor: Colors.red.shade300,
          ));
        } else if (userLogin.password != password) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Password tidak cocok'),
            backgroundColor: Colors.red.shade300,
          ));
        } else {
          await Provider.of<UserAllProvider>(context, listen: false)
              .updateUserStatus(userLogin.idUser, 1);

          if (!sidemenuController.isActive(sideMenuItems[0][0])) {
            sidemenuController.changeActiveItmeTo(sideMenuItems[0][0]);
            if (Responsive.isMobile(context)) {
              Get.back();
            }
          }
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AppLayout(
                        currentUser: userLogin,
                        selectedMenu: 0,
                      )));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Login Berhasil'),
            backgroundColor: Colors.green,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
              "Username, Email atau Password salah\nSilahkan cek kembali data yang anda"),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          RoundedInputTextfield(
            change: (value) {},
            icon: Icons.person,
            hintText: "Your username or email",
            controller: _userController,
            obscureTextValue: false,
            action: TextInputAction.next,
            backColor: kBackgroundColor,
            shadowColor: kBackgroundColor,
            offset: const Offset(0, 0),
            cursorColor: kPrimaryColor,
            iconColor: kPrimaryColor,
            textColor: kPrimaryColor,
            hinttextColor: kSecondaryColor,
            myValidationNote: "Masukkan username atau email anda.",
          ),
          RoundedInputTextfield(
            change: (value) {},
            icon: Icons.lock,
            hintText: "Your password",
            controller: _passwordController,
            obscureTextValue: true,
            action: TextInputAction.done,
            backColor: kBackgroundColor,
            shadowColor: kBackgroundColor,
            offset: const Offset(0, 0),
            cursorColor: kPrimaryColor,
            iconColor: kPrimaryColor,
            textColor: kPrimaryColor,
            hinttextColor: kSecondaryColor,
            myValidationNote: "Masukkan password anda.",
          ),
          const SizedBox(height: defaultPadding * 0.5),
          Hero(
            tag: "login_btn",
            child: RoundedButton(
                text: "login",
                press: () {
                  login(_userController.text, _passwordController.text);
                },
                backColor: kPrimaryColor,
                textColor: Colors.white),
          ),
          const SizedBox(height: defaultPadding * 0.5),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpPage();
                  },
                ),
              );
            },
          ),
          const SizedBox(height: defaultPadding * 2),
        ],
      ),
    );
  }
}
