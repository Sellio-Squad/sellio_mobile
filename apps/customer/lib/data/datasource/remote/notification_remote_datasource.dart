import 'package:core/core.dart';

import '../../core/api/api_endpoints.dart';
import '../../models/notification_data_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationDataModel>> getNotifications();
  Future<void> markAsRead(String notificationId);
  Future<void> deleteNotification(String notificationId);
}

class NotificationRemoteDataSourceImpl
    implements NotificationRemoteDataSource {
  final ApiClient _httpClient;

  NotificationRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<NotificationDataModel>> getNotifications() async {
    final response = await _httpClient.get(ApiEndpoints.notifications);
    final notifications = (response.data as List)
        .map((json) => NotificationDataModel.fromJson(
            json as Map<String, dynamic>))
        .toList();
    return notifications;
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _httpClient.put(ApiEndpoints.notificationRead(notificationId));
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await _httpClient.delete(ApiEndpoints.notificationDelete(notificationId));
  }
}
