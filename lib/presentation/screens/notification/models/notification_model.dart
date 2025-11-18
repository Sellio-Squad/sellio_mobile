import 'package:equatable/equatable.dart';
import '../../../../domain/entities/notification.dart';

class NotificationModel extends Equatable {
  final int state;
  final String orderId;
  final String storeName;
  final String time;
  final String date;

  const NotificationModel({
    required this.state,
    required this.orderId,
    required this.storeName,
    required this.time,
    required this.date,
  });

  @override
  List<Object?> get props => [state, orderId, storeName, time, date];
}

class NotificationMapper {
  static NotificationModel toUI(Notification entity) {
    return NotificationModel(
      orderId: entity.orderId,
      storeName: entity.storeName,
      time: entity.time,
      date: entity.date,
      state: entity.state,
    );
  }

  static List<NotificationModel> toUIList(List<Notification> entities) {
    return entities.map((e) => toUI(e)).toList();
  }
}