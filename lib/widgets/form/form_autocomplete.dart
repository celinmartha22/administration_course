import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

class MyFormAutoComplete extends StatefulWidget {
  MyFormAutoComplete(
      {super.key,
      required this.listName,
      required this.listId,
      required this.myController,
      required this.myFieldName,
      required this.myIcon,
      required this.myPrefixIconColor,
      required this.myValidationNote});
  List<String> listName;
  List<String> listId;
  TextEditingController myController;
  String myFieldName;
  IconData myIcon;
  Color myPrefixIconColor;
  final String myValidationNote;

  @override
  State<MyFormAutoComplete> createState() => _MyFormAutoCompleteState();
}

class _MyFormAutoCompleteState extends State<MyFormAutoComplete> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: light, border: Border.all(color: light)),
      child: Autocomplete(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          } else {
            return widget.listName.where((word) => word
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()));
          }
        },
        optionsViewBuilder: (context, Function(String) onSelected, options) {
          return Material(
            elevation: 4,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final option = options.elementAt(index);

                return ListTile(
                  title: SubstringHighlight(
                    text: option.toString(),
                    term: widget.myController.text,
                    textStyleHighlight: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () {
                    onSelected(index.toString());
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: options.length,
            ),
          );
        },
        onSelected: (selectedindex) {
          debugPrint(widget.listId[int.parse(selectedindex.toString())]);
          debugPrint(widget.listName[int.parse(selectedindex.toString())]);
        },
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          controller = widget.myController;
          return TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return widget.myValidationNote;
              } else {
                return null;
              }
            },
            controller: controller,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.normal,
                letterSpacing: 0),
            decoration: InputDecoration(
                isDense: true,
                labelText: widget.myFieldName,
                prefixIcon: Icon(
                  widget.myIcon,
                  color: widget.myPrefixIconColor,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.deepPurple.shade300)),
                labelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0)),
          );
        },
      ),
    );
  }
}
