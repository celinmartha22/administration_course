import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/constants/style.dart';
// import 'package:administration_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Side item menu mendatar yang isinya [icon berada disamping nama menu]
class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem(
      {Key? key,
      required this.itemName,
      required this.itemRoute,
      required this.onTap})
      : super(key: key);
  final String itemName;
  final String itemRoute;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: onTap,
        child: Obx(() {
          return Container(
            margin: sidemenuController.isActive(itemName)
                ? const EdgeInsets.all(10)
                : const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: sidemenuController.isActive(itemName)
                  ? kAdditionalColor
                  : Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: screenWidth / 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: sidemenuController.returnIconFor(itemName, itemRoute),
                ),
                if (!sidemenuController.isActive(itemName))
                  Text(
                    itemName,
                    style: const TextStyle(
                        fontSize: 18,
                        color: kTextLightColor,
                        fontWeight: FontWeight.normal),
                  )
                else
                  Text(
                    itemName,
                    style: const TextStyle(
                        fontSize: 18,
                        color: kTextDarkColor,
                        fontWeight: FontWeight.bold),
                  )
              ],
            ),
          );
        }));
  }
}
