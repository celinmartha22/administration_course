import 'package:flutter/material.dart';

class TextfieldContainer extends StatelessWidget {
  const TextfieldContainer(
      {super.key,
      required this.child,
      required this.backColor,
      required this.shadowColor,
      required this.offset});
  final Widget child;
  final Color backColor;
  final Color shadowColor;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 4,
            offset: offset, // Shadow position
          ),
        ],
      ),
      child: child,
    );
  }
}
