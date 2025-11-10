import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/address_model.dart';
import '../../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel?> getCachedUser();

  Future<void> cacheUser(UserModel user);

  Future<void> clearUserCache();

  Future<String?> getAuthToken();

  Future<String?> getRefreshToken();

  Future<void> saveAuthToken(String token,
      {String? refreshToken, DateTime? expiresAt});

  Future<void> clearAuthToken();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences _sharedPreferences;

  // Keys for SharedPreferences
  static const String _cachedUserKey = 'cached_user';
  static const String _authTokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiryKey = 'token_expiry';

  UserLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final userJson = _sharedPreferences.getString(_cachedUserKey);
      if (userJson == null) {
        return null;
      }

      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final userJson = json.encode(user.toJson());
      await _sharedPreferences.setString(_cachedUserKey, userJson);
    } catch (e) {
      // Handle error silently or log it
    }
  }

  @override
  Future<void> clearUserCache() async {
    try {
      await _sharedPreferences.remove(_cachedUserKey);
    } catch (e) {
      // Handle error silently or log it
    }
  }

  @override
  Future<String?> getAuthToken() async {
    try {
      final token = _sharedPreferences.getString(_authTokenKey);
      if (token == null) {
        return null;
      }

      // Check if token is expired
      final expiryTimestamp = _sharedPreferences.getInt(_tokenExpiryKey);
      if (expiryTimestamp != null) {
        final expiry = DateTime.fromMillisecondsSinceEpoch(expiryTimestamp);
        if (DateTime.now().isAfter(expiry)) {
          await clearAuthToken();
          return null;
        }
      }

      return token;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return _sharedPreferences.getString(_refreshTokenKey);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveAuthToken(
    String token, {
    String? refreshToken,
    DateTime? expiresAt,
  }) async {
    try {
      await _sharedPreferences.setString(_authTokenKey, token);

      if (refreshToken != null) {
        await _sharedPreferences.setString(_refreshTokenKey, refreshToken);
      }

      final expiry = expiresAt ?? DateTime.now().add(const Duration(days: 30));
      await _sharedPreferences.setInt(
        _tokenExpiryKey,
        expiry.millisecondsSinceEpoch,
      );
    } catch (e) {
      // Handle error silently or log it
    }
  }

  @override
  Future<void> clearAuthToken() async {
    try {
      await _sharedPreferences.remove(_authTokenKey);
      await _sharedPreferences.remove(_refreshTokenKey);
      await _sharedPreferences.remove(_tokenExpiryKey);
    } catch (e) {
      // Handle error silently or log it
    }
  }
}
