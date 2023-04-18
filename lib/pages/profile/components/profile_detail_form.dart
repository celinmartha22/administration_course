// import 'package:administration_course/constants/formating.dart';
import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileDetailForm extends StatelessWidget {
  const ProfileDetailForm(
      {super.key,
      required this.myInitialValue,
      required this.myFieldName,
      this.myIcon = Icons.verified_user_outlined,
      this.myPrefixIconColor = Colors.blueAccent,
      required this.isObscureText,
      required this.myMaxLine,
      required this.myKeyboardType});
  final String myInitialValue;
  final String myFieldName;
  final IconData myIcon;
  final Color myPrefixIconColor;
  final bool isObscureText;
  final int myMaxLine;
  final TextInputType myKeyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        readOnly: true,
        initialValue: myInitialValue,
        keyboardType: myKeyboardType,
        maxLines: myMaxLine,
        obscureText: isObscureText,
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.normal,
              letterSpacing: 0,
            ),
        decoration: InputDecoration(
          isDense: true,
          labelText: myFieldName,
          prefixIcon: Icon(
            myIcon,
            color: myPrefixIconColor,
            size: kDefaultPadding,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding*2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding*2),
              borderSide: BorderSide(color: Colors.deepPurple.shade300)),
          labelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: kSubTextColor,
              fontWeight: FontWeight.normal,
              letterSpacing: 0),
        ),
      ),
    );
  }
}
