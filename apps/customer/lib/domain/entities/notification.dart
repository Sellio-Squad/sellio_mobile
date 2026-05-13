class Notification {
  final String id;
  final String orderId;
  final String storeName;
  final String time;
  final String date;
  final int state;

  const Notification({
    required this.id,
    required this.orderId,
    required this.storeName,
    required this.time,
    required this.date,
    required this.state,
  });

  Notification copyWith({
    String? id,
    String? orderId,
    String? storeName,
    String? time,
    String? date,
    int? state,
  }) {
    return Notification(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      storeName: storeName ?? this.storeName,
      time: time ?? this.time,
      date: date ?? this.date,
      state: state ?? this.state,
    );
  }
}
