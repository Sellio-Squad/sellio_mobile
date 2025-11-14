import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
      throw Exception('Failed to save token: $e');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _storage.read(key: StorageKeys.authToken);
    } catch (e) {
      throw Exception('Failed to read token: $e');
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      await _storage.delete(key: StorageKeys.authToken);
    } catch (e) {
      throw Exception('Failed to clear token: $e');
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
      throw Exception('Failed to save refresh token: $e');
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: StorageKeys.refreshToken);
    } catch (e) {
      throw Exception('Failed to read refresh token: $e');
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
      throw Exception('Failed to save user ID: $e');
    }
  }

  @override
  Future<String?> getUserId() async {
    try {
      return await _storage.read(key: StorageKeys.userId);
    } catch (e) {
      throw Exception('Failed to read user ID: $e');
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw Exception('Failed to clear storage: $e');
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