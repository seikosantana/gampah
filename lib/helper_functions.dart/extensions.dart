import 'dart:math';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.toCapitalized())
      .join(" ");
}

extension NumberSIPrefix on int {
  static List<String> symbolsSI = [
    "",
    "k",
    "M",
    "G",
    "T",
    "P",
    "E",
  ];

  double log10(num x) => log(x) / ln10;

  String toSIPrefixed(int digits) {
    int tier = (log10(this).toDouble() / 3).floor();
    int scale = pow(10, tier * 3).toInt();
    double scaled = this / scale;
    return scaled.toStringAsFixed(digits) + symbolsSI[tier];
  }
}
