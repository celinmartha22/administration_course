// import 'package:flutter/cupertino.dart';
import 'package:administration_course/constants/formating.dart';
import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyFormTextfield extends StatelessWidget {
  const MyFormTextfield(
      {super.key,
      required this.myController,
      required this.myFieldName,
      this.myIcon = Icons.verified_user_outlined,
      this.myPrefixIconColor = Colors.blueAccent,
      required this.myValidationNote,
      required this.isCurrency,
      required this.myMaxLine,
      required this.myKeyboardType});
  final TextEditingController myController;
  final String myFieldName;
  final IconData myIcon;
  final Color myPrefixIconColor;
  final String myValidationNote;
  final bool isCurrency;
  final int myMaxLine;
  final TextInputType myKeyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return myValidationNote;
          } else {
            return null;
          }
        },
        controller: myController,
        keyboardType: myKeyboardType,
        maxLines: myMaxLine,
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
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
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.deepPurple.shade300)),
          labelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.normal,
              letterSpacing: 0),
        ),
        onChanged: (value) {
          if (isCurrency) {
            value = formatNumber(
              value.replaceAll(',', ''),
            );
            myController.value = TextEditingValue(
              text: value,
              selection: TextSelection.collapsed(
                offset: value.length,
              ),
            );
          }
        },
      ),
    );
  }
}
