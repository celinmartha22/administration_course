import 'package:administration_course/constants/style.dart';
import 'package:administration_course/pages/overview/widgets/bar_chart.dart';
import 'package:administration_course/widgets/custom_text.dart';
import 'package:administration_course/pages/overview/widgets/revenue_info.dart';
import 'package:flutter/material.dart';

/// Data tambahan atau ramngkuman dari grafik chart [Small Screen]
class RevenueSectionSmall extends StatelessWidget {
  const RevenueSectionSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Column(
        children: [
          Container(
            height: 260 ,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                  text: 'Revenue Chart',
                  size: 20,
                  color: lightGrey,
                  weight: FontWeight.bold),
              Container(
                width: 600,
                height: 200,
                child: SimpleBarChart.withSampleData(),
              )
            ],
          )),
          Container(
            width: 120,
            height: 1,
            color: lightGrey,
          ),
          Container(
            height: 260,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  RevenueInfo(title: "Today\'s revenue", amount: "23"),
                  RevenueInfo(title: "Last 7 days ", amount: "150"),
                ],
              ),
              Row(
                children: [
                  RevenueInfo(title: "Last 30 days", amount: "1,203"),
                  RevenueInfo(title: "Last 12 months", amount: "3,234"),
                ],
              )
            ],
          )),
        ],
      ),
    );
  }
}
