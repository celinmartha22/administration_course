import 'package:administration_course/pages/overview/widgets/info_card.dart';
import 'package:administration_course/pages/overview/widgets/info_card_small.dart';
import 'package:flutter/material.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  const OverviewCardsSmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InfoCardSmall(
              title: 'Rides in Progress',
              value: '7',
              topColor: Colors.orange,
              isActive: false,
              onTap: () {}),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
              title: 'Students',
              value: '328',
              topColor: Colors.lightGreen,
              isActive: false,
              onTap: () {}),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
              title: 'Teams',
              value: '45',
              topColor: Colors.redAccent,
              isActive: false,
              onTap: () {}),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
              title: 'Courses',
              value: '5',
              topColor: Colors.blueAccent,
              isActive: false,
              onTap: () {})
        ],
      ),
    );
  }
}
