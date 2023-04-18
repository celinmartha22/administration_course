import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    required this.backColor,
    required this.textColor,
  }) : super(key: key);
  final String text;
  final Function() press;
  final Color backColor, textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 45,
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              backgroundColor: MaterialStateProperty.all<Color>(backColor),
              alignment: Alignment.center),
          onPressed: press,
          child: Text(
            text.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 0),
          )),
    );
  }
}
