import '../../domain/entities/address.dart';
import '../../domain/entities/user.dart';
import '../models/user/user_model.dart';

extension UserModelMapper on UserModel {
  User toEntity() {
    return User(
      fullName: fullName,
      phoneNumber: phoneNumber,
      avatarUrl: avatarUrl,
      address: Address(
        country: country,
        city: city,
      ),
    );
  }
}
