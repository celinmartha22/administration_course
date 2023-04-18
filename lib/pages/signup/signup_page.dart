import 'package:administration_course/constants/style.dart';
import 'package:administration_course/pages/signup/components/background_signup.dart';
import 'package:administration_course/pages/signup/components/sign_up_top_image.dart';
import 'package:administration_course/pages/signup/components/signup_form.dart';
import 'package:administration_course/responsive.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = '/signup';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundSignUp(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            mobile: const MobileSignupPage(),
            desktop: Row(
              children: [
                const Expanded(
                  child: SignUpScreenTopImage(),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 450,
                        child: SignUpForm(),
                      ),
                      SizedBox(height: defaultPadding / 2),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MobileSignupPage extends StatelessWidget {
  const MobileSignupPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SignUpScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
