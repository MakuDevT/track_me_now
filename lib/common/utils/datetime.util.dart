import 'package:intl/intl.dart';

class DateTimeUtil {
  static String formatDateTime(DateTime dateTime, {String? formatString}) {
    return DateFormat(formatString ?? 'MMMM dd, yyyy hh:mm a').format(dateTime);
  }
}
