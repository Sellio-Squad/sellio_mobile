import 'package:intl/intl.dart';

String formatDateToReadable(DateTime date) {
  return DateFormat('dd MMM yyyy').format(date.toLocal());
}
