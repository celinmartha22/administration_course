import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

class MyFormRadio extends StatelessWidget {
  MyFormRadio(
      {super.key,
      required this.title,
      required this.value,
      required this.gender,
      required this.isSelected,
      required this.onChanged});
  String title;
  Gender value;
  Gender? gender;
  bool isSelected;
  Function(Gender?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadioListTile<Gender>(
        contentPadding: const EdgeInsets.all(0),
        tileColor: kBackgroundLightColor,
        activeColor: kPrimaryColor,
        selectedTileColor: kBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.normal,
              letterSpacing: 0),
        ),
        dense: true,
        value: value,
        groupValue: gender,
        onChanged: onChanged,
        selected: isSelected,
      ),
    );
  }
}
