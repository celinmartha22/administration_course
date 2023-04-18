import 'package:flutter/material.dart';

class NotificationDataNotFound extends StatelessWidget {
  const NotificationDataNotFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 10),
            child: Center(
              child: Image.asset(
                'assets/images/404 Error with a cute animal-pana.png',
                width: 250,
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
            )));
  }
}