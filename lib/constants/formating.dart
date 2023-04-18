import 'package:intl/intl.dart';

String formatNumber(String s) {
  if (s != "") {
    return NumberFormat.decimalPattern().format(
      int.parse(s.replaceAll(RegExp(r'[^0-9]'), '')),
    );
  } else {
    return "";
  }
}
