import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/helpers/responsiveness.dart';
import 'package:administration_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomesPage extends StatelessWidget {
  const IncomesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        )
      ],
    );
  }
}