import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Sign Up".toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.normal,
                letterSpacing: 0),
          ),
          const SizedBox(height: defaultPadding),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Image.asset('assets/images/Sign up-amico.png'),
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
