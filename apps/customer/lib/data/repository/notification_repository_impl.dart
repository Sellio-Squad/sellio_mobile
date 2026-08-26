import 'package:sellio_mobile/data/datasource/remote/notification_remote_datasource.dart';
import 'package:sellio_mobile/domain/entities/notification.dart';
import 'package:sellio_mobile/domain/repository/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepositoryImpl({
    required NotificationRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<List<Notification>> getNotifications() async {
    final models = await _remoteDataSource.getNotifications();
    return models.map((model) => model.toEntity()).toList();
  }
}
