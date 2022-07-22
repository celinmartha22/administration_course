import 'package:administration_course/widgets/large_screen.dart';
import 'package:flutter/material.dart';

const int largeSreenSize = 1366;
const int customScreenSize = 1100;
const int mediumScreenSize = 768;
const int smallScreenSize = 366;

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;

  const ResponsiveWidget(
      {Key? key,
      required this.largeScreen,
      required this.mediumScreen,
      required this.smallScreen,})
      : super(key: key);

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= largeSreenSize;
  static bool isCustomScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= customScreenSize &&
      MediaQuery.of(context).size.width < largeSreenSize;
  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSize &&
      MediaQuery.of(context).size.width < customScreenSize;
  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < mediumScreenSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double _width = constraints.maxWidth;
        if (_width >= largeSreenSize) {
          return largeScreen;
        } else if (_width >= mediumScreenSize && _width < largeSreenSize) {
          /// return [mediumScreen], if mediumScreen is null then return [largeScreen]
          return mediumScreen;
        } else {
          /// return [smallScreen], if smallScreen is null then return [largeScreen]
          return smallScreen;
        }
      },
    );
  }
}
