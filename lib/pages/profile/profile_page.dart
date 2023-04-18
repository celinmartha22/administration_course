import 'package:administration_course/data/model/user.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = "/profile";
  const ProfilePage({super.key, required this.currentUser});
  final User currentUser;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: Body(currentUser: widget.currentUser)));
  }
}
