import 'package:sellio_mobile/domain/entities/notification.dart';
import 'package:sellio_mobile/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  @override
  Future<List<Notification>> getNotifications() async {
    return [
      const Notification(
        id: '1',
        state: 0,
        orderId: "1x23456",
        storeName: "Sweet Lovers - Pasteleria",
        time: "11:12 PM",
        date: "2025-11-03",
      ),
      const Notification(
        id: '1',
        state: 0,
        orderId: "1x23457",
        storeName: "Sweet Lovers - Pasteleria",
        time: "11:13 PM",
        date: "2025-11-03",
      ),
      const Notification(
        id: '1',
        state: 2,
        orderId: "1x23458",
        storeName: "Sweet Lovers - Pasteleria",
        time: "11:15 PM",
        date: "2025-11-03",
      ),
      const Notification(
        id: '1',
        state: 0,
        orderId: "2x78901",
        storeName: "Burger Zone",
        time: "10:12 PM",
        date: "2025-11-03",
      ),
      const Notification(
        id: '1',
        state: 2,
        orderId: "3x11111",
        storeName: "Pizza Lovers",
        time: "08:15 PM",
        date: "2025-11-02",
      ),
      const Notification(
        id: '1',
        state: 2,
        orderId: "3x11112",
        storeName: "Pizza Lovers",
        time: "08:20 PM",
        date: "2025-11-02",
      ),
      const Notification(
        id: '1',
        state: 2,
        orderId: "3x11113",
        storeName: "Pizza Lovers",
        time: "08:25 PM",
        date: "2025-11-02",
      ),
      const Notification(
        id: '1',
        state: 0,
        orderId: "4x22222",
        storeName: "Coffee Dreams",
        time: "09:00 PM",
        date: "2025-11-01",
      ),
      const Notification(
        id: '1',
        state: 0,
        orderId: "4x22223",
        storeName: "Coffee Dreams",
        time: "09:10 PM",
        date: "2025-11-01",
      ),
      const Notification(
        id: '1',
        state: 0,
        orderId: "4x22224",
        storeName: "Coffee Dreams",
        time: "09:20 PM",
        date: "2025-11-01",
      ),
      const Notification(
        id: '1',
        state: 0,
        orderId: "4x22225",
        storeName: "Coffee Dreams",
        time: "09:30 PM",
        date: "2025-11-01",
      ),
      const Notification(
        id: '1',
        state: 0,
        orderId: "4x22226",
        storeName: "Coffee Dreams",
        time: "09:40 PM",
        date: "2025-11-01",
      ),
      const Notification(
        id: '1',
        state: 0,
        orderId: "4x22227",
        storeName: "Coffee Dreams",
        time: "09:50 PM",
        date: "2025-11-01",
      ),
    ];
  }
}
