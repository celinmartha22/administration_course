// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';

// class NavigationController extends GetxController {
//   /// [instance] variable yang akan mengijinkan kita untuk mengakses nilai/data pada [NavigationController] darimanapun
//   static NavigationController instance = Get.find();

//   /// key global, agar aplikasi tau mana navigator yang akan kita ubah, sperti ketika ingin mengubah screen/halaman,
//   /// maka kita akan tau dari navigator mana yang akan kita ubah
//   final GlobalKey<NavigatorState> navigationKey = GlobalKey();

//   Future<dynamic>? navigateTo(String routeName) {
//     return navigationKey.currentState?.pushNamed(routeName);
//   }

//   goBack() => navigationKey.currentState?.pop();

//   // void controlMenu() {
//   //   if (!navigationKey.currentState!.isDrawerOpen) {
//   //     navigationKey.currentState!.openDrawer();
//   //   }
//   // }
// }
