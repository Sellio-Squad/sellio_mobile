
import '../../domain/entities/address.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

extension UserModelMapper on UserModel {
  User toEntity() {
    return User(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      avatarUrl: avatarUrl,
      address: Address(
        country: country,
        city: city,
      ),
    );
  }
}
