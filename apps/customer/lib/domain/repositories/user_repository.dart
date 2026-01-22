import '../../core/error/result.dart';
import '../entities/address.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Result<User>> getUserProfile();

  Future<Result<User>> updateUserProfile({
    String? firstName,
    String? lastName,
    String? email,
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
