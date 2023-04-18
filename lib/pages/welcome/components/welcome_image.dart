import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "WELCOME TO",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: kPrimaryColor, fontWeight: FontWeight.normal),
          ),
          kHalfSizedBox,
          Text(
            "COURSE\nADMINISTRATION",
            // "RUMAH BELAJAR\nREJENDRA",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.normal,
                letterSpacing: 0, wordSpacing: 0),
          ),
          const SizedBox(height: defaultPadding * 2),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.5,
            child: Image.asset('assets/images/Seminar-amico.png'),
          ),
          const SizedBox(height: defaultPadding * 2),
        ],
      ),
    );
  }
}
