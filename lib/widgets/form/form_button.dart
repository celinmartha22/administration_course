import 'package:flutter/material.dart';

class MyFormButton extends StatelessWidget {
  const MyFormButton(
      {super.key, required this.onPress, required this.textButton});
  final VoidCallback onPress;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shadowColor: Colors.deepPurple.shade200,
              minimumSize: const Size(150, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: onPress,
          child: Text(
            textButton.toUpperCase(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          )),
    );
  }
}
