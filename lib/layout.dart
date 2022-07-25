import 'package:administration_course/helpers/responsiveness.dart';
import 'package:administration_course/widgets/large_screen.dart';
import 'package:administration_course/widgets/side_menu.dart';
import 'package:administration_course/widgets/small_screen.dart';
import 'package:administration_course/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
        mediumScreen: LargeScreen(),
      ),
    );
  }
}
