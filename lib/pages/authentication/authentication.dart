import 'package:administration_course/constants/style.dart';
import 'package:administration_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: light,
          child: CustomText(
              text: "Authentication",
              size: 24,
              color: active,
              weight: FontWeight.bold)),
    );
  }
}
