import 'package:administration_course/constants/controller.dart';
import 'package:administration_course/routing/router.dart';
import 'package:administration_course/routing/routes.dart';
import 'package:flutter/widgets.dart';

/// methode yang mengembalikan sebuah navigator
Navigator localNavigator = Navigator(
  key: navigationController.navigationKey,
  initialRoute: OverViewPageRoute,
  onGenerateRoute: generateRoute,
); 