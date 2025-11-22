import 'package:sellio_mobile/data/mappers/address_mapper.dart';

import '../../domain/entities/user.dart';
import '../models/user_model.dart';

extension UserModelMapper on UserModel {
  User toEntity() => User(
    fullName: fullName,
    phoneNumber: phoneNumber,
    countryCode: countryCode,
    profilePhotoUrl: profilePhotoUrl,
    address: address.toEntity(),
  );
}

