import 'dart:html';

import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/helpers/responsiveness.dart';
import 'package:administration_course/pages/overview/widgets/available_students.dart';
import 'package:administration_course/pages/overview/widgets/overview_cards_large.dart';
import 'package:administration_course/pages/overview/widgets/overview_cards_medium.dart';
import 'package:administration_course/pages/overview/widgets/overview_cards_small.dart';
import 'package:administration_course/widgets/custom_text.dart';
import 'package:administration_course/pages/overview/widgets/revenue_section_large.dart';
import 'package:administration_course/pages/overview/widgets/revenue_section_medium.dart';
import 'package:administration_course/pages/overview/widgets/revenue_section_small.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      color: Colors.black,
                      weight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              if (ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isCustomScreen(context))
                OverviewCardsLargeScreen()
              else if (ResponsiveWidget.isMediumScreen(context))
                OverviewCardsMediumScreen()
              else
                OverviewCardsSmallScreen(),

              if (ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isCustomScreen(context))
                RevenueSectionLarge()
              else if (ResponsiveWidget.isMediumScreen(context))
                RevenueSectionMedium()
              else
                RevenueSectionSmall(),

                // DataTable2SimpleDemo(),
            ],
          ))
        ],
      ),
    );
  }
}
