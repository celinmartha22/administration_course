import 'package:administration_course/constants/style.dart';
import 'package:administration_course/pages/login/login_page.dart';
import 'package:administration_course/pages/signup/signup_page.dart';
import 'package:flutter/material.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: RoundedButton(
              text: "login",
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
              backColor: kPrimaryColor,
              textColor: Colors.white),
        ),
        // const SizedBox(height: 16),
        Hero(
          tag: "sign_up",
          child: RoundedButton(
              text: "sign up",
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
              backColor: kSecondaryColor,
              textColor: Colors.black),
        ),
      ],
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    required this.backColor,
    required this.textColor,
  }) : super(key: key);
  final String text;
  final Function() press;
  final Color backColor, textColor;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
      width: screenSize.width * 0.8,
      height: kDefaultPadding * 3,
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(kDefaultPadding * 2))),
              backgroundColor: MaterialStateProperty.all<Color>(backColor),
              alignment: Alignment.center),
          onPressed: press,
          child: Text(
            text.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 0),
          )),
    );
  }
}
