import 'package:intl/intl.dart';

class DateTimeHelper {
  static String dateOnly(DateTime dateTime) {
    DateFormat formatter = DateFormat("dd  MMMM");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String dateWithYear(DateTime dateTime) {
    DateFormat formatter = DateFormat("dd  MMMM, yyyy");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String dayOnly(DateTime dateTime) {
    DateFormat formatter = DateFormat("EEEE");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String prettyDateWithDayTime(DateTime dateTime) {
    DateFormat formatter = DateFormat("dd  MMM  y  hh:m a");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String prettyDateTime(DateTime dateTime) {
    DateFormat formatter = DateFormat("dd MMM hh:mm a");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String timeOnly(DateTime dateTime) {
    DateFormat formatter = DateFormat("hh:m  a");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    if (date1.year != date2.year) return false;
    if (date1.month != date2.month) return false;
    if (date1.day != date2.day) return false;

    return true;
  }
}
