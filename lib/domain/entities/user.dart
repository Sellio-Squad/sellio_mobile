
import 'address.dart';

class User {
  final String fullName;
  final String phoneNumber;
  final String countryCode;
  final String? profilePhotoUrl;
  final Address address;

  const User({
    required this.fullName,
    required this.phoneNumber,
    required this.countryCode,
    this.profilePhotoUrl,
    required this.address,
  });

  User copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? countryCode,
    String? profilePhotoUrl,
    Address? address,
  }) {
    return User(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      address: address ?? this.address,
    );
  }
}
