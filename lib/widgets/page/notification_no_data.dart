import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

class NotificationNoData extends StatelessWidget {
  const NotificationNoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 10),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              'assets/images/Empty-amico.png',
              width: 250,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Text('Data kosong\nTidak ada data yang ditampilkan',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: kPrimaryColor, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ));
  }
}
