import 'address.dart';

class User {
  final String fullName;
  final String? email;
  final String phoneNumber;
  final String? avatarUrl;
  final Address address;

  const User({
    required this.fullName,
    this.email,
    required this.phoneNumber,
    this.avatarUrl,
    required this.address,
  });

  User copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? city,
    String? country,
    String? avatarUrl,
    Address? address,
  }) {
    return User(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      address: address ?? this.address,
    );
  }
}
