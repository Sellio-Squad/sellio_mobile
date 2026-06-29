import 'package:core/error/result.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Result<User>> getUserProfile();

  Future<Result<User>> updateUserProfile({
    String? fullName,
    String? phoneNumber,
    String? country,
    String? city,
    String? avatarUrl,
  });

  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<Result<void>> resetPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<Result<void>> deleteAccount();

  Future<Result<String>> uploadProfilePhoto(String filePath);
}
