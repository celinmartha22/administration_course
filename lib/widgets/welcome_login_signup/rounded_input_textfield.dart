import 'package:administration_course/widgets/welcome_login_signup/textfield_container.dart';
import 'package:flutter/material.dart';

class RoundedInputTextfield extends StatelessWidget {
  const RoundedInputTextfield(
      {super.key,
      required this.hintText,
      this.icon = Icons.person,
      required this.controller,
      required this.action,
      required this.cursorColor,
      required this.obscureTextValue,
      required this.iconColor,
      required this.textColor,
      required this.hinttextColor,
      required this.change,
      required this.backColor,
      required this.shadowColor,
      required this.offset,
      required this.myValidationNote});
  final String hintText;
  final IconData icon;
  final TextInputAction action;
  final TextEditingController controller;
  final Color backColor;
  final Color shadowColor;
  final Color cursorColor;
  final Color iconColor;
  final Color textColor;
  final Color hinttextColor;
  final Offset offset;
  final bool obscureTextValue;
  final String myValidationNote;
  final Function(String) change;

  @override
  Widget build(BuildContext context) {
    return TextfieldContainer(
        backColor: backColor,
        shadowColor: shadowColor,
        offset: offset,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return myValidationNote != "" ? myValidationNote : null;
            } else {
              return null;
            }
          },
          onChanged: change,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: textColor, letterSpacing: 0),
          controller: controller,
          obscureText: obscureTextValue,
          textInputAction: action,
          cursorColor: cursorColor,
          onSaved: (email) {},
          decoration: InputDecoration(
              icon: Icon(
                icon,
                color: iconColor,
              ),
              hintText: hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: hinttextColor, letterSpacing: 0),
              border: InputBorder.none),
        ));
  }
}
