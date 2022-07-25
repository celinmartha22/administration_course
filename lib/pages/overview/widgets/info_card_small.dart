import 'package:administration_course/constants/style.dart';
import 'package:administration_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
class InfoCardSmall extends StatelessWidget {
  const InfoCardSmall({Key? key, required this.title, required this.value, required this.topColor, required this.isActive, required this.onTap}) : super(key: key);
    final String title;
  final String value;
  final Color topColor;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isActive? active:lightGrey, width: .5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: title, size: 24, color: isActive? active:lightGrey, weight: FontWeight.w300),
            CustomText(text: value, size: 24, color: isActive? active:lightGrey, weight: FontWeight.bold),
          ],
        ),
      ),
    ));
  }
}