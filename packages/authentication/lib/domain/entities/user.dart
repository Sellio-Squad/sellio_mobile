import 'address.dart';

class User {
  final String fullName;
  final String phoneNumber;
  final String? avatarUrl;
  final Address address;

  const User({
    required this.fullName,
    required this.phoneNumber,
    this.avatarUrl,
    required this.address,
  });

  User copyWith({
    String? fullName,
    String? phoneNumber,
    String? city,
    String? country,
    String? avatarUrl,
    Address? address,
  }) {
    return User(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      address: address ?? this.address,
    );
  }
}
