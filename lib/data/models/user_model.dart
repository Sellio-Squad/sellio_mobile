import '../../domain/entities/user.dart';
import 'address_model.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.phoneNumber,
    required super.countryCode,
    super.profilePhotoUrl,
    required super.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      countryCode: json['countryCode'] as String,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'profilePhotoUrl': profilePhotoUrl,
      'address': (address as AddressModel).toJson(),
    };
  }


  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      fullName: user.fullName,
      phoneNumber: user.phoneNumber,
      countryCode: user.countryCode,
      profilePhotoUrl: user.profilePhotoUrl,
      address: user.address,
    );
  }

  User toEntity() {
    return User(
      id: id,
      fullName: fullName,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
      profilePhotoUrl: profilePhotoUrl,
      address: address,
    );
  }
}
