import 'package:administration_course/pages/overview/widgets/info_card.dart';
import 'package:flutter/material.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  const OverviewCardsMediumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
                title: 'Rides in Progress',
                value: '7',
                topColor: Colors.orange,
                isActive: false,
                onTap: () {}),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
                title: 'Students',
                value: '328',
                topColor: Colors.lightGreen,
                isActive: false,
                onTap: () {}),
          ],
        ),
                    SizedBox(
              height: 16,
            ),
        Row(
          children: [
            InfoCard( 
                title: 'Teams',
                value: '45',
                topColor: Colors.redAccent,
                isActive: false,
                onTap: () {}),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
                title: 'Courses',
                value: '5',
                topColor: Colors.blueAccent,
                isActive: false,
                onTap: () {}),
          ],
        )
      ],
    );
  }
}
