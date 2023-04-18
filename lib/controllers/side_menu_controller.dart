import 'package:administration_course/constants/style.dart';
import 'package:administration_course/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenuController extends GetxController {
  /// [instance] variable yang akan mengijinkan kita untuk mengakses nilai/data pada [SideMenuController] darimanapun
  static SideMenuController instance = Get.find();

  /// [activeItem] dan [hoverItem] merupakan varibale yang akan di [.obs] observasi/dipantau menggunakan State Management GetX
  /// default [activeItem] adalah menu [OverViewPageRoute] yaitu yang akan terbuka dihalaman pertama
  var activeItem = homePageRoute.obs;
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

  /// Mengembalikan widget dasar dari NAMA MENU [itemName] dan ROUTE MENU [itemRoute]
  Widget returnIconFor(String itemName, String itemRoute) {
    switch (itemRoute) {
      case homePageRoute:
        return _customIcon(Icons.home_outlined, itemName);
      case paketKursusPageRoute:
        return _customIcon(Icons.book, itemName);
      case siswaPageRoute:
        return _customIcon(Icons.person_rounded, itemName);
      case asistenPageRoute:
        return _customIcon(Icons.supervisor_account_rounded, itemName);
      // case invoicesPageRoute:
      //   return _customIcon(Icons.inventory_sharp, itemName);
      // case payrollPageRoute:
      //   return _customIcon(Icons.payment, itemName);
      case jenisKasPageRoute:
        return _customIcon(Icons.sell, itemName);
      case transaksiMasukPageRoute:
        return _customIcon(Icons.input, itemName);
      case transaksiKeluarPageRoute:
        return _customIcon(Icons.output, itemName);
      case laporanPageRoute:
        return _customIcon(Icons.feed, itemName);
      case logoutPageRoute:
        return _customIcon(Icons.logout, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    /// jika menu itu aktif, maka akan langsung return ini, warna icon = dark
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: 22,
        color: kTextDarkColor,
      );
    }

    /// jika tidak aktif, makan cek [isHovering], jika iya maka warna icon = [dark], jika tidak = [lightGrey]
    return Icon(icon, color: isHovering(itemName) ? kTextDarkColor : kTextDarkColor);
  }
}
