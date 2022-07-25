import 'package:administration_course/constants/style.dart';
import 'package:administration_course/controllers/menu_controller.dart';
import 'package:administration_course/controllers/navigation_controller.dart';
import 'package:administration_course/layout.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Get.put(MenuController());  /// me-Register [MenuController]
  Get.put(NavigationController());  /// me-Register [NavigationController]
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course App',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        // primaryColor: Colors.blue,
        // primarySwatch: Colors.blue,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),

        /// [pageTransitionsTheme] untuk mengatur tema/gaya transisi ketika akan ganti halaman
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
        }),
      ),
      home: SiteLayout(),
    );
  }
}
