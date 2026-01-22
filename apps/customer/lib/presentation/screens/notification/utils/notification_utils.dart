import 'package:intl/intl.dart';
import '../extensions/notification_extensions.dart';

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

  static NotificationStateMessage getMessageType(int state) {
    return switch (state) {
      0 => NotificationStateMessage.placed,
      1 => NotificationStateMessage.delivered,
      2 => NotificationStateMessage.cancelled,
      _ => NotificationStateMessage.cancelled,
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
