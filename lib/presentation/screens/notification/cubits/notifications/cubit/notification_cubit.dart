import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/repositories/notification_repository.dart';
import '../../../models/notification_model.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository repository;
  NotificationCubit(this.repository) : super(const NotificationInitial());

  Future<void> loadNotifications() async {
    emit(const NotificationLoading());

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final notifications = NotificationMapper.toUIList(await repository.getNotifications());
      final groupedNotifications = _groupNotificationsByDate(notifications);

      emit(NotificationLoaded(
        groupedNotifications: groupedNotifications,
        allNotifications: notifications,
      ));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> refreshNotifications() async {
    if (state is NotificationLoaded) {
      try {
        await Future.delayed(const Duration(milliseconds: 300));
        final notifications = NotificationMapper.toUIList(await repository.getNotifications());
        final groupedNotifications = _groupNotificationsByDate(notifications);

        emit(NotificationLoaded(
          groupedNotifications: groupedNotifications,
          allNotifications: notifications,
        ));
      } catch (e) {
        emit(NotificationError(message: e.toString()));
      }
    } else {
      loadNotifications();
    }
  }

  void markAsRead(String orderId) {
    if (state is NotificationLoaded) {
      final currentState = state as NotificationLoaded;

      emit(currentState);
    }
  }

  void deleteNotification(String orderId) {
    if (state is NotificationLoaded) {
      final currentState = state as NotificationLoaded;
      final updatedNotifications = currentState.allNotifications
          .where((notification) => notification.orderId != orderId)
          .toList();

      final groupedNotifications = _groupNotificationsByDate(
          updatedNotifications);

      emit(NotificationLoaded(
        groupedNotifications: groupedNotifications,
        allNotifications: updatedNotifications,
      ));
    }
  }

  Map<String, List<NotificationModel>> _groupNotificationsByDate(
      List<NotificationModel> notifications) {
    notifications.sort((a, b) => b.date.compareTo(a.date));

    final grouped = <String, List<NotificationModel>>{};
    for (final notification in notifications) {
      grouped.putIfAbsent(notification.date, () => []).add(notification);
    }

    return grouped;
  }
}