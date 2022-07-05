import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

ySpace(double height) => SizedBox(height: height);
xSpace(double width) => SizedBox(width: width);
const nothingWidget = SizedBox();
String humanFormat(String? date) => DateFormat('dd/MM/yyyy')
    .format(DateTime.parse(date ?? DateTime.now().toIso8601String()));

dp(dynamic data) => debugPrint("$data");

class Helper {
  static void showError(String error) {
    EasyLoading.showError(error);
  }
}
