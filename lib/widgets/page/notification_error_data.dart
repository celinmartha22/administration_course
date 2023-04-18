import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

class NotificationErrorData extends StatelessWidget {
  const NotificationErrorData({
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
              'assets/images/Feeling sorry-pana.png',
              width: 250,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: light),
                children: const <TextSpan>[
                  TextSpan(
                      text:'Terjadi kesalahan yang tidak diketahui\n',
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'Silahkan cek data yang anda miliki',
                      style: TextStyle(color: kPrimaryColor)),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
