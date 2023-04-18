import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormUserTextfield extends StatelessWidget {
  const FormUserTextfield({
    super.key,
    this.myIcon = Icons.verified_user_outlined,
    required this.action,
    required this.myController,
    required this.backColor,
    required this.textColor,
    required this.cursorColor,
    this.iconColor = kPrimaryColor,
    required this.obscureTextValue,
    required this.change,
    required this.myFieldName,
    required this.myKeyboardType,
  });
  final IconData myIcon;
  final TextInputAction action;
  final TextEditingController myController;
  final Color backColor;
  final Color textColor;
  final Color cursorColor;
  final Color iconColor;
  final bool obscureTextValue;
  final Function(String) change;
  final String myFieldName;
  final TextInputType myKeyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: TextFormField(
        onChanged: change,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: textColor, letterSpacing: 0),
        controller: myController,
        obscureText: obscureTextValue,
        textInputAction: action,
        cursorColor: cursorColor,
        onSaved: (email) {},
        keyboardType: myKeyboardType,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          labelText: myFieldName,
          prefixIcon: Icon(
            myIcon,
            color: iconColor,
          ),
          fillColor: backColor,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.deepPurple.shade300)),
          labelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.normal,
              letterSpacing: 0),
        ),
      ),
    );
  }
}
