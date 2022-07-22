import 'package:administration_course/constants/style.dart';
import 'package:administration_course/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  /// [instance] variable yang akan mengijinkan kita untuk mengakses nilai/data pada [MenuController] darimanapun
  static MenuController instance = Get.find();

  /// [activeItem] dan [hoverItem] merupakan varibale yang akan di [.obs] observasi/dipantau menggunakan State Management GetX
  /// default [activeItem] adalah menu [OverViewPageRoute] yaitu yang akan terbuka dihalaman pertama
  var activeItem = OverViewPageRoute.obs;
  var hoverItem = "".obs;

  /// Setiap kita ganti halaman, kita harus mengganti [activeItem] dengan nama menu yang sedang aktif
  changeActiveItmeTo(String itemName) {
    activeItem.value = itemName;
  }

  /// Mengatur menu mana yang akan tampil paling atas berdasarkan nama menu/item
  /// Jika nama menu/item sama dengan nama menu/item yang sedang aktif, maka menu itu akan ditampilkan paling atas
  onHover(String itemName) {
    if (!isActive(itemName)) {
      hoverItem.value = itemName;
    }
  }

  /// Mengecek apakah item/menu itu aktif atau tidak
  isActive(String itemName) => activeItem.value == itemName;

  /// Mengecek apakah item/menu itu tampil paling atas
  isHovering(String itemName) => hoverItem.value == itemName;

  /// Mengembalikan widget dasar dari [itemName]
  Widget returnIconFor(String itemName) {
    return Container();
  }

  Widget _customIcon(IconData icon, String itemName) {
    /// jika menu itu aktif, maka akan langsung return ini, warna icon = dark
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: 22,
        color: dark,
      );
    }

    /// jika tidak aktif, makan cek [isHovering], jika iya maka warna icon = [dark], jika tidak = [lightGrey]
    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey
    );
  }
}
