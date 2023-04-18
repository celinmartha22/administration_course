import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileDetailColumn extends StatelessWidget {
  ProfileDetailColumn(
      {Key? key,
      required this.title,
      required this.value,
      this.ikon,
      this.warna})
      : super(key: key);
  final String title;
  final String value;
  String? ikon;
  int? warna;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0,
                  color: kTextBlackColor,
                  fontSize:
                      SizerUtil.deviceType == DeviceType.tablet ? 7.sp : 11.sp,
                ),
          ),
          const SizedBox(
            height: kDefaultPadding / 4,
          ),
          itemValue(value: value, ikon: ikon, warna: warna),
          const SizedBox(
            height: kDefaultPadding / 4,
          ),
          SizedBox(
            width: 85.w,
            child: const Divider(
              thickness: 1.0,
            ),
          )
        ],
      ),
    );
  }
}

class itemValue extends StatelessWidget {
  itemValue({super.key, required this.value, this.ikon, this.warna});

  final String value;
  String? ikon;
  int? warna;

  @override
  Widget build(BuildContext context) {
    if (value.isNotEmpty && value != "") {
      return Text(value,
          softWrap: true,
          maxLines: 3,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
                color: kTextBlackColor,
                fontSize:
                    SizerUtil.deviceType == DeviceType.tablet ? 7.sp : 13.sp,
              ));
    } else if (ikon != null) {
      return Icon(
        IconData(int.parse(ikon!), fontFamily: 'MaterialIcons'),
        size: 40,
        color: kTextBlackColor,
      );
    } else if (warna != null) {
      return Container(
          width: 100,
          height: 40,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(kDefaultPadding)),
            color: Color(warna!),
            shape: BoxShape.rectangle,
            border: Border.all(
                color: const Color.fromARGB(255, 255, 255, 255), width: 2),
          ));
    } else {
      return Container();
    }
  }
}
