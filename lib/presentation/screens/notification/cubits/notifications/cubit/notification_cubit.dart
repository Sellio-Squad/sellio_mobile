import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/notification_model.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationInitial());

  Future<void> loadNotifications() async {
    emit(const NotificationLoading());

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final notifications = _getMockNotifications();
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
      final currentState = state as NotificationLoaded;

      try {
        await Future.delayed(const Duration(milliseconds: 300));
        final notifications = _getMockNotifications();
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

  List<NotificationModel> _getMockNotifications() {
    return [
      const NotificationModel(
        state: 0,
        orderId: "1x23456",
        storeName: "Sweet Lovers - Pasteleria",
        time: "11:12 PM",
        date: "2025-11-03",
      ),
      const NotificationModel(
        state: 1,
        orderId: "1x23457",
        storeName: "Sweet Lovers - Pasteleria",
        time: "11:13 PM",
        date: "2025-11-03",
      ),
      const NotificationModel(
        state: 2,
        orderId: "1x23458",
        storeName: "Sweet Lovers - Pasteleria",
        time: "11:15 PM",
        date: "2025-11-03",
      ),
      const NotificationModel(
        state: 1,
        orderId: "2x78901",
        storeName: "Burger Zone",
        time: "10:12 PM",
        date: "2025-11-03",
      ),

      const NotificationModel(
        state: 2,
        orderId: "3x11111",
        storeName: "Pizza Lovers",
        time: "08:15 PM",
        date: "2025-11-02",
      ),
      const NotificationModel(
        state: 2,
        orderId: "3x11112",
        storeName: "Pizza Lovers",
        time: "08:20 PM",
        date: "2025-11-02",
      ),
      const NotificationModel(
        state: 2,
        orderId: "3x11113",
        storeName: "Pizza Lovers",
        time: "08:25 PM",
        date: "2025-11-02",
      ),

      const NotificationModel(
        state: 0,
        orderId: "4x22222",
        storeName: "Coffee Dreams",
        time: "09:00 PM",
        date: "2025-11-01",
      ),
      const NotificationModel(
        state: 0,
        orderId: "4x22223",
        storeName: "Coffee Dreams",
        time: "09:10 PM",
        date: "2025-11-01",
      ),
      const NotificationModel(
        state: 0,
        orderId: "4x22224",
        storeName: "Coffee Dreams",
        time: "09:20 PM",
        date: "2025-11-01",
      ),
      const NotificationModel(
        state: 0,
        orderId: "4x22225",
        storeName: "Coffee Dreams",
        time: "09:30 PM",
        date: "2025-11-01",
      ),
      const NotificationModel(
        state: 0,
        orderId: "4x22226",
        storeName: "Coffee Dreams",
        time: "09:40 PM",
        date: "2025-11-01",
      ),
      const NotificationModel(
        state: 0,
        orderId: "4x22227",
        storeName: "Coffee Dreams",
        time: "09:50 PM",
        date: "2025-11-01",
      ),
    ];
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