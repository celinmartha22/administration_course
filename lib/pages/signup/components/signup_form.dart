import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/data/provider/user_all_provider.dart';
import 'package:administration_course/responsive.dart';
import 'package:administration_course/routing/routes.dart';
import 'package:administration_course/widgets/layout/app_layout.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/pages/login/login_page.dart';
import 'package:administration_course/widgets/already_have_an_account_acheck.dart';
import 'package:administration_course/widgets/welcome_login_signup/rounded_button.dart';
import 'package:administration_course/widgets/welcome_login_signup/rounded_input_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Duration get registTime => const Duration(milliseconds: 2250);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> registerNewUser(
        String name, String email, String username, String password) async {
      debugPrint(
          'Register New User => Name: $name, Email: $email, Username: $username, Password: $password');
      if (_formKey.currentState!.validate()) {
        String id = "U${DateFormat("yyyy.MMdd.HHmmss").format(DateTime.now())}";
        final userData = User(
            idUser: id,
            username: username,
            password: password,
            name: name,
            email: email,
            loginStatus: 0);
        await Provider.of<UserAllProvider>(context, listen: false)
            .addUser(userData);

        final userLogin =
            await Provider.of<UserAllProvider>(context, listen: false)
                .getUserByUserPass(username, password);
        if (userLogin.username != username && userLogin.email != email) {
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
            content: const Text('Registrasi Berhasil'),
            backgroundColor: Colors.green,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
              "Data Registrasi salah\nSilahkan cek kembali data yang anda"),
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
            hintText: "Full name",
            controller: _fullNameController,
            obscureTextValue: false,
            action: TextInputAction.next,
            backColor: kBackgroundColor,
            shadowColor: kBackgroundColor,
            offset: const Offset(0, 0),
            cursorColor: kPrimaryColor,
            iconColor: kPrimaryColor,
            textColor: kPrimaryColor,
            hinttextColor: kSecondaryColor,
            myValidationNote: "Masukkan nama lengkap.",
          ),
          RoundedInputTextfield(
            change: (value) {},
            icon: Icons.account_circle,
            hintText: "Username",
            controller: _userNameController,
            obscureTextValue: false,
            action: TextInputAction.next,
            backColor: kBackgroundColor,
            shadowColor: kBackgroundColor,
            offset: const Offset(0, 0),
            cursorColor: kPrimaryColor,
            iconColor: kPrimaryColor,
            textColor: kPrimaryColor,
            hinttextColor: kSecondaryColor,
            myValidationNote: "Masukkan username.",
          ),
          RoundedInputTextfield(
            change: (value) {},
            icon: Icons.email,
            hintText: "Email",
            controller: _emailController,
            obscureTextValue: false,
            action: TextInputAction.next,
            backColor: kBackgroundColor,
            shadowColor: kBackgroundColor,
            offset: const Offset(0, 0),
            cursorColor: kPrimaryColor,
            iconColor: kPrimaryColor,
            textColor: kPrimaryColor,
            hinttextColor: kSecondaryColor,
            myValidationNote: "Masukkan alamat email",
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
            myValidationNote: "Masukkan password",
          ),
          const SizedBox(height: defaultPadding / 2),
          Hero(
            tag: "sign_up",
            child: RoundedButton(
                text: "Sign Up",
                press: () async {
                  registerNewUser(
                      _fullNameController.text,
                      _emailController.text,
                      _userNameController.text,
                      _passwordController.text);
                },
                backColor: kPrimaryColor,
                textColor: Colors.white),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
