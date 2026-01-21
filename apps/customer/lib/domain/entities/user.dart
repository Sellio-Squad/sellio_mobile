import 'address.dart';

class User {
  final String firstName;
  final String lastName;
  final String? email;
  final String phoneNumber;
  final String? avatarUrl;
  final Address address;

  const User({
    required this.firstName,
    required this.lastName,
    this.email,
    required this.phoneNumber,
    this.avatarUrl,
    required this.address,
  });

  User copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? city,
    String? country,
    String? avatarUrl,
    Address? address,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      address: address ?? this.address,
    );
  }
}
