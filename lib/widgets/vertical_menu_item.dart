import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Side item menu menurun yang isinya [icon berada diatas nama menu]
class VerticalMenuItem extends StatelessWidget {
  const VerticalMenuItem(
      {Key? key, required this.itemName, required this.onTap})
      : super(key: key);
  final String itemName;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover("Not hovering!");
      },

      /// [Obx()] artinya widget tersebut diobservasi/dipantau
      /// karna bisa saja terjadi perubahan value pada [Container] dibawah
      child: Obx(() {
        return Container(
          color: menuController.isHovering(itemName)
              ? lightGrey.withOpacity(.1)
              : Colors.transparent,
          child: Row(
            children: [
              /// [Visibility] adlah widget yang digunakan untuk menampilkan atau menyembunyikan widget yang ada didalamnya [child] nya
              Visibility(
                visible: menuController.isHovering(itemName) ||
                    menuController.isActive(itemName),

                /// [Container] ini akan jadi bar kecil disamping kiri menu, bar kecil akan muncul jika menunya [isHovering] atau [isActive]
                child: Container(
                  width: 3,
                  height: 72,
                  color: dark,
                ),
                maintainAnimation: true,
                maintainSize: true,
                maintainState: true,
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: menuController.returnIconFor(itemName),
                  ),
                  if (!menuController.isActive(itemName))
                    Flexible(
                        child: CustomText(
                            text: itemName,
                            size: 18,
                            color: menuController.isHovering(itemName)
                                ? dark
                                : lightGrey,
                            weight: FontWeight.normal))
                  else
                    Flexible(
                        child: CustomText(
                            text: itemName,
                            size: 18,
                            color: dark,
                            weight: FontWeight.bold))
                ],
              ))
            ],
          ),
        );
      }),
    );
  }
}
