// import 'package:flutter/cupertino.dart';
import 'package:administration_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyFormDatePicker extends StatefulWidget {
  const MyFormDatePicker(
      {super.key,
      required this.myController,
      required this.myFieldName,
      this.myIcon,
      this.myPrefixIconColor = Colors.blueAccent,
      required this.myValidationNote});
  final TextEditingController myController;
  final String myFieldName;
  final IconData? myIcon;
  final Color myPrefixIconColor;
  final String myValidationNote;

  @override
  State<MyFormDatePicker> createState() => _MyFormDatePickerState();
}

class _MyFormDatePickerState extends State<MyFormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: TextFormField(
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2200),
              builder: (context, child) {
                return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: kPrimaryColor, // header background color
                        onPrimary: kTextWhiteColor, // header text color
                        onSurface: kPrimaryColor, // body text color
                      ),
                      textTheme: TextTheme(
                        headlineSmall:
                            GoogleFonts.lato(), // Selected Date landscape
                        titleLarge:
                            GoogleFonts.lato(), // Selected Date portrait
                        labelSmall: GoogleFonts.lato(), // Title - SELECT DATE
                        bodyLarge: GoogleFonts.lato(), // year gridbview picker
                        titleMedium:
                            GoogleFonts.lato(color: Colors.black), // input
                        titleSmall: GoogleFonts.lato(), // month/year picker
                        bodySmall: GoogleFonts.lato(), // days
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                            backgroundColor: kBackgroundColor,
                            foregroundColor: kPrimaryColor,
                            textStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0)),
                      ),
                    ),
                    child: child!);
              },
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat("dd MMMM yyyy").format(pickedDate);

              setState(() {
                widget.myController.text = formattedDate.toString();
              });
              // FocusScope.of(context).requestFocus(new FocusNode());
            } else {
              debugPrint("Not selected");
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.myValidationNote;
            } else {
              return null;
            }
          },
          controller: widget.myController,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.normal,
              letterSpacing: 0),
          decoration: InputDecoration(
              isDense: true,
              labelText: widget.myFieldName,
              prefixIcon: widget.myIcon == null
                  ? null
                  : Icon(
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
        ),
      ),
    );
  }
}
