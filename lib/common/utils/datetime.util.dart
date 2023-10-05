import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class DateTimeUtil {
  static String formatDateTime(DateTime dateTime, {String? formatString}) {
    return DateFormat(formatString ?? 'MMM dd, yyyy hh:mm a').format(dateTime);
  }

  static String formatDateTimeShort(DateTime dateTime, {String? formatString}) {
    return DateFormat(formatString ?? 'MM/dd/yyyy HH:mm').format(dateTime);
  }

  static String humanizeDateTime(DateTime dateTime) {
    return Jiffy.parseFromDateTime(dateTime).fromNow();
  }
}
