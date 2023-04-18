extension DoubleExtensions on int { // INT ganti double
  String removeDecimalZeroFormat() {
    return toStringAsFixed(truncateToDouble() == this ? 0 : 2);
  }
}