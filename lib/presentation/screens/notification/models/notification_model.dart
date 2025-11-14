import 'package:equatable/equatable.dart';

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