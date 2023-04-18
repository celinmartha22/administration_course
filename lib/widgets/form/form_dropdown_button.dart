import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';

class MyFormDropdownButton extends StatefulWidget {
  MyFormDropdownButton(
      {super.key,
      required this.listItem,
      required this.myController,
      required this.myFieldName,
      required this.myValue,
      required this.myIcon,
      required this.myPrefixIconColor});
  List<String> listItem;
  TextEditingController myController;
  String myFieldName;
  String myValue;
  IconData myIcon;
  Color myPrefixIconColor;

  @override
  State<MyFormDropdownButton> createState() => _MyFormDropdownButtonState();
}

class _MyFormDropdownButtonState extends State<MyFormDropdownButton> {
  String dropdownValue = "SD";
  @override
  void initState() {
    final index =
        widget.listItem.indexWhere((element) => element == widget.myValue) != -1
            ? widget.listItem.indexWhere((element) => element == widget.myValue)
            : widget.listItem.indexWhere(
                        (element) => element.contains(widget.myValue)) !=
                    -1
                ? widget.listItem
                    .indexWhere((element) => element.contains(widget.myValue))
                : 0;
    dropdownValue = widget.listItem[index];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: light, border: Border.all(color: light)),
      child: DropdownButtonFormField(
        dropdownColor: Colors.deepPurple.shade50,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 30,
        iconEnabledColor: Colors.deepPurple,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: kPrimaryColor,
            fontWeight: FontWeight.normal,
            letterSpacing: 0),
        items: widget.listItem.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
            widget.myController.text = value;
          });
        },
        isExpanded: true,
        value: dropdownValue,
        focusColor: kBackgroundColor,
        decoration: InputDecoration(
            isDense: true,
            labelText: widget.myFieldName,
            labelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: kTextBlackColor,
                fontWeight: FontWeight.normal,
                letterSpacing: 0),
            prefixIcon: Icon(
              widget.myIcon,
              color: widget.myPrefixIconColor,
            )),
      ),
    );
  }
}
