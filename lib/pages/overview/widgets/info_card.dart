import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {Key? key,
      required this.title,
      required this.value,
      required this.topColor,
      required this.isActive,
      required this.onTap})
      : super(key: key);
  final String title;
  final String value;
  final Color topColor;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 136,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12,
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  /// container dengan tinggi cuma 5px yang diberi warna sesuai [topColor]
                  /// jika [topColor] null maka kasih warna [active]
                  Expanded(
                      child: Container(
                    color: topColor,
                    height: 5,
                  ))
                ],
              ),
              Expanded(child: Container()),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$title\n",
                      style: TextStyle(fontSize: 16, color: isActive? active: lightGrey)
                    ),
                                        TextSpan(
                      text: "$value",
                      style: TextStyle(fontSize: 40, color: isActive? active: dark)
                    ),
                  ],
                )
                ),
              Expanded(child: Container())
            ],
          ),
        ),
      ),
    );
  }
}