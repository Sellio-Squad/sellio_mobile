import '../../../domain/entities/notification.dart';
import '../../../domain/repositories/notification_repository.dart';
import '../../mock/mock_data_generator.dart';

class MockNotificationRepositoryImpl implements NotificationRepository {
  final List<Notification> _notifications =
      MockDataGenerator.generateNotifications(count: 15);

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Future<List<Notification>> getNotifications() async {
    await _simulateDelay();
    return _notifications;
  }
}
