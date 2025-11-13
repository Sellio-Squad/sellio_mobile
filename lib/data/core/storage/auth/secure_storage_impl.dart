import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/error/exceptions.dart';
import '../storage_keys.dart';
import 'auth_storage.dart';


class SecureStorageImpl implements AuthStorage {
  final FlutterSecureStorage _storage;

  SecureStorageImpl({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> saveToken(String token) async {
    try {
      await _storage.write(
        key: StorageKeys.authToken,
        value: token,
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to save token: ${e.toString()}',
      );
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _storage.read(key: StorageKeys.authToken);
    } catch (e) {
      throw CacheException(
        message: 'Failed to retrieve token: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      await _storage.delete(key: StorageKeys.authToken);
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear token: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    try {
      await _storage.write(
        key: StorageKeys.refreshToken,
        value: token,
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to save refresh token: ${e.toString()}',
      );
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: StorageKeys.refreshToken);
    } catch (e) {
      throw CacheException(
        message: 'Failed to retrieve refresh token: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> saveUserId(String userId) async {
    try {
      await _storage.write(
        key: StorageKeys.userId,
        value: userId,
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to save user ID: ${e.toString()}',
      );
    }
  }

  @override
  Future<String?> getUserId() async {
    try {
      return await _storage.read(key: StorageKeys.userId);
    } catch (e) {
      throw CacheException(
        message: 'Failed to retrieve user ID: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear storage: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> hasValidSession() async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      return token != null && token.isNotEmpty &&
          userId != null && userId.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}