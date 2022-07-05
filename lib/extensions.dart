import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get humanFormat {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
