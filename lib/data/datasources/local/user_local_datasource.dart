import '../../models/address_model.dart';
import '../../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel?> getCachedUser();

  Future<void> cacheUser(UserModel user);

  Future<void> clearUserCache();

  Future<String?> getAuthToken();

  Future<void> saveAuthToken(String token,
      {String? refreshToken, DateTime? expiresAt});

  Future<void> clearAuthToken();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserModel? _cachedUser;
  String? _authToken;
  DateTime? _tokenExpiry;

  UserLocalDataSourceImpl();

  @override
  Future<UserModel?> getCachedUser() async {
    // Return fake user data if not cached
    if (_cachedUser == null) {
      return _getFakeUser();
    }
    return _cachedUser;
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    _cachedUser = user;
  }

  @override
  Future<void> clearUserCache() async {
    _cachedUser = null;
  }

  @override
  Future<String?> getAuthToken() async {
    if (_authToken == null) return null;

    // Check if token is expired
    if (_tokenExpiry != null && DateTime.now().isAfter(_tokenExpiry!)) {
      await clearAuthToken();
      return null;
    }

    return _authToken;
  }

  @override
  Future<void> saveAuthToken(
    String token, {
    String? refreshToken,
    DateTime? expiresAt,
  }) async {
    _authToken = token;
    _tokenExpiry = expiresAt ?? DateTime.now().add(const Duration(days: 30));
  }

  @override
  Future<void> clearAuthToken() async {
    _authToken = null;
    _tokenExpiry = null;
  }

  // Fake user data
  UserModel _getFakeUser() {
    return UserModel(
      id: 'user_001',
      fullName: 'John Doe',
      phoneNumber: '1234567890',
      countryCode: '+1',
      profilePhotoUrl: 'https://via.placeholder.com/150',
      address: AddressModel(
        id: 'addr_001',
        country: 'United States',
        city: 'New York',
        latitude: 40.7128,
        longitude: -74.0060,
      ),
    );
  }
}
