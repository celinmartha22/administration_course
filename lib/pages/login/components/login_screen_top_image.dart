import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

class LoginScreenTopImage extends StatefulWidget {
  LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreenTopImage> createState() => _LoginScreenTopImageState();
}

class _LoginScreenTopImageState extends State<LoginScreenTopImage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "LOGIN",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.normal,
                letterSpacing: 0),
          ),
          const SizedBox(height: defaultPadding * 2),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.5,
            child: Image.asset('assets/images/Tablet login-bro.png'),
          ),
          const SizedBox(height: defaultPadding * 2),
        ],
      ),
    );
  }
}
