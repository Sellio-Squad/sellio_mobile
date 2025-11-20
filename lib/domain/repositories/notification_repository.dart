
import 'package:sellio_mobile/domain/entities/notification.dart';

abstract class NotificationRepository {
  Future<List<Notification>> getNotifications();
}