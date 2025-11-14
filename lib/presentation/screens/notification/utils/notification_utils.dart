import 'package:intl/intl.dart';

class NotificationUtils {
  static String formatDateHeader(String dateString) {
    final parsedDate = DateTime.tryParse(dateString);

    if (parsedDate == null) return dateString;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(
        parsedDate.year, parsedDate.month, parsedDate.day);

    if (dateOnly == today) {
      return "Today";
    } else if (dateOnly == yesterday) {
      return "Yesterday";
    } else {
      return DateFormat('MMM dd, yyyy').format(parsedDate);
    }
  }

  static String getNotificationMessage(int state) {
    return switch (state) {
      0 => "has been placed successfully",
      1 => "has been delivered successfully",
      2 => "has been cancelled",
      _ => "has been cancelled",
    };
  }

  static bool isToday(String dateString) {
    final parsedDate = DateTime.tryParse(dateString);
    if (parsedDate == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(
        parsedDate.year, parsedDate.month, parsedDate.day);

    return dateOnly == today;
  }

  static bool isYesterday(String dateString) {
    final parsedDate = DateTime.tryParse(dateString);
    if (parsedDate == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(
        parsedDate.year, parsedDate.month, parsedDate.day);

    return dateOnly == yesterday;
  }
}