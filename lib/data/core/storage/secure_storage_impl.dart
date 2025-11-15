import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'storage_service.dart';

class SecureStorageImpl implements StorageService {
  final FlutterSecureStorage _storage;

  SecureStorageImpl({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> save<T>(String key, T value) async {
    try {
      if (value is String) {
        await _storage.write(key: key, value: value);
      } else {
        await _storage.write(key: key, value: jsonEncode(value));
      }
    } catch (e) {
      throw Exception('Secure save failed: $e');
    }
  }

  @override
  Future<T?> get<T>(String key) async {
    try {
      final data = await _storage.read(key: key);
      if (data == null) return null;

      if (T == String) {
        return data as T;
      } else {
        return jsonDecode(data) as T;
      }
    } catch (e) {
      throw Exception('Secure read failed: $e');
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw Exception('Secure remove failed: $e');
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw Exception('Secure clear failed: $e');
    }
  }

  @override
  Future<bool> has(String key) async {
    final value = await _storage.read(key: key);
    return value != null;
  }
}
