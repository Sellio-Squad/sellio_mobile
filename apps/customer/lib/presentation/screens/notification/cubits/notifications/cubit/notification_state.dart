import 'package:equatable/equatable.dart';

import '../../../models/notification_model.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();

  @override
  List<Object?> get props => [];
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();

  @override
  List<Object?> get props => [];
}

class NotificationLoaded extends NotificationState {
  final Map<String, List<NotificationModel>> groupedNotifications;
  final List<NotificationModel> allNotifications;

  const NotificationLoaded({
    required this.groupedNotifications,
    required this.allNotifications,
  });

  NotificationLoaded copyWith({
    Map<String, List<NotificationModel>>? groupedNotifications,
    List<NotificationModel>? allNotifications,
  }) {
    return NotificationLoaded(
      groupedNotifications: groupedNotifications ?? this.groupedNotifications,
      allNotifications: allNotifications ?? this.allNotifications,
    );
  }

  @override
  List<Object?> get props => [groupedNotifications, allNotifications];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError({required this.message});

  @override
  List<Object?> get props => [message];
}
