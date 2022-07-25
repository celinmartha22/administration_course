import 'package:administration_course/helpers/local_navigator.dart';
import 'package:flutter/material.dart';
class SmallScreen extends StatelessWidget {
  const SmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(16), child: localNavigator);
  }
}