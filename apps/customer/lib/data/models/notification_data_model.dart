import '../../domain/entities/notification.dart';

class NotificationDataModel {
  final String id;
  final String orderId;
  final String storeName;
  final String time;
  final String date;
  final int state;

  const NotificationDataModel({
    required this.id,
    required this.orderId,
    required this.storeName,
    required this.time,
    required this.date,
    required this.state,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
      id: json['id']?.toString() ?? '',
      orderId: json['orderId']?.toString() ?? '',
      storeName: json['storeName']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      state: json['state'] is int ? json['state'] as int : 0,
    );
  }

  Notification toEntity() {
    return Notification(
      id: id,
      orderId: orderId,
      storeName: storeName,
      time: time,
      date: date,
      state: state,
    );
  }
}
