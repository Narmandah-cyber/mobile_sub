library area;

import 'package:intl/intl.dart';

String calculateAreaRect(double width, double height) {
  final result = width * height;
  final formatter = NumberFormat('#.####');
  return formatter.format(result);
}

String calculateAreaTriangle(double width, double height) {
  final result = (width * height) / 2;
  final formatter = NumberFormat('#.####');
  return formatter.format(result);
}
