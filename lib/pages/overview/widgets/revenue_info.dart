import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

/// Data tambahan yang muncul disebelah grafik chart
class RevenueInfo extends StatelessWidget {
  const RevenueInfo({Key? key, required this.title, required this.amount})
      : super(key: key);
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: "$title \n\n",
                  style: TextStyle(color: lightGrey, fontSize: 16)),
              TextSpan(
                  text: "\$ $amount \n\n",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ])));
  }
}
