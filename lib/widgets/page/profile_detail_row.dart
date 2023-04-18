import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                      color: kTextBlackColor,
                      fontSize: SizerUtil.deviceType == DeviceType.tablet
                          ? 7.sp
                          : 9.sp,
                    ),
              ),
              const SizedBox(
                height: kDefaultPadding / 4,
              ),
              Text(value,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                        color: kTextBlackColor,
                        fontSize: SizerUtil.deviceType == DeviceType.tablet
                            ? 7.sp
                            : 11.sp,
                      )),
              const SizedBox(
                height: kDefaultPadding / 4,
              ),
              SizedBox(
                width: 40.w,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
