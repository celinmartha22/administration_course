import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

class NotificationBlankDataResult extends StatelessWidget {
  const NotificationBlankDataResult({
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
              'assets/images/SEO-pana.png',
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
                    .copyWith(color: lightGrey),
                children: const <TextSpan>[
                  TextSpan(
                      text: 'Hasil pencarian tidak ditemukan\n',
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Silahkan cek ulang kata kunci yang anda tulis',
                      style: TextStyle(color: lightGrey)),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}