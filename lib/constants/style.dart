import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

const light =  Color(0xFFF7F8FC);
const lightGrey =  Color(0xFFA4A6B3);
const dark =  Color(0xFF363740);
const active =  Color(0xFF3C19C0);




const double defaultPadding = 16.0;

//colors
// const Color kPrimaryColor = Color(0xFF345FB4);
const Color kPrimaryColor = Color(0xFF6F35A5);
const Color kPrimaryLightColor = Color(0xFF9356C9);
const Color kSecondaryColor = Color(0xFFB777EE);
const Color kSecondaryLightColor = Color(0xFFDC9AFF);
const Color kAdditionalColor = Color(0xFFcabefc);
const Color kAdditionalLightColor = Color(0xFFdcd7ff);
const Color kBackgroundColor = Color(0xFFF1E6FF);
const Color kBackgroundLightColor = Color(0xFFeeebfe);
const Color kBackgroundVeryLightColor = Color(0xFFFBFAFF);
const Color kTextBlackColor = Color(0xFF313131);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kTextDarkColor = Color(0xFF33354c);
const Color kTextLightColor = Color(0xFFa6abc8);
const Color kSubTextColor = Color(0xFF757996);
const Color kContainerColor = Color(0xFF777777);
const Color kOtherColor = Color(0xFFF4F6F7);
const Color kErrorBorderColor = Color(0xFFE74C3C);


final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.quintessential(fontSize: 30, fontWeight: FontWeight.w300, letterSpacing: -1.5, color: Colors.white),
  displayMedium: GoogleFonts.quintessential(fontSize: 20, fontWeight: FontWeight.w300, letterSpacing: -0.5, color: Colors.white),
  displaySmall: GoogleFonts.quintessential(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white),
  headlineLarge: GoogleFonts.vollkorn(fontSize: 30),
  headlineMedium: GoogleFonts.vollkorn(fontSize: 28),
  headlineSmall: GoogleFonts.vollkorn(fontSize: 26),
  titleLarge: GoogleFonts.lato(fontSize: 30),
  titleMedium: GoogleFonts.lato(fontSize: 24),
  titleSmall: GoogleFonts.lato(fontSize: 22),
  labelLarge: GoogleFonts.lato(fontSize: 20),
  labelMedium: GoogleFonts.lato(fontSize: 18),
  labelSmall: GoogleFonts.lato(fontSize: 16),
  bodyLarge: GoogleFonts.lato(fontSize: 14),
  bodyMedium: GoogleFonts.lato(fontSize: 12),
  bodySmall: GoogleFonts.lato(fontSize: 10),
);

//default value
const kDefaultPadding = 20.0;

const sizedBox = SizedBox(
  height: kDefaultPadding,
);
const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 2,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);

final kTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
  topRight:
      Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
);

final kBottomBorderRadius = BorderRadius.only(
  bottomRight: Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 40),
  bottomLeft:
  Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 40),
);

final kInputTextStyle = GoogleFonts.poppins(
  color: kTextBlackColor,
  fontSize: 11.sp,
  fontWeight: FontWeight.w500
);

//validation for mobile
const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

//validation for email
const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';