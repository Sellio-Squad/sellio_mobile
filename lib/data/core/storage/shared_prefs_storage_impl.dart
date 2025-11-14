import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'storage_service.dart';

class SharedPrefsStorageImpl implements StorageService {
  final SharedPreferences _prefs;

  SharedPrefsStorageImpl(this._prefs);

  @override
  Future<void> save<T>(String key, T value) async {
    try {
      if (value is String) {
        await _prefs.setString(key, value);
      } else if (value is int) {
        await _prefs.setInt(key, value);
      } else if (value is bool) {
        await _prefs.setBool(key, value);
      } else if (value is double) {
        await _prefs.setDouble(key, value);
      } else if (value is List<String>) {
        await _prefs.setStringList(key, value);
      } else {
        await _prefs.setString(key, jsonEncode(value));
      }
    } catch (e) {
      throw Exception('Cache save failed: $e');
    }
  }

  @override
  Future<T?> get<T>(String key) async {
    try {
      if (!_prefs.containsKey(key)) return null;

      if (T == String) return _prefs.getString(key) as T?;
      if (T == int) return _prefs.getInt(key) as T?;
      if (T == bool) return _prefs.getBool(key) as T?;
      if (T == double) return _prefs.getDouble(key) as T?;
      if (T == List<String>) return _prefs.getStringList(key) as T?;

      final jsonStr = _prefs.getString(key);
      if (jsonStr == null) return null;

      return jsonDecode(jsonStr) as T;
    } catch (e) {
      throw Exception('Cache read failed: $e');
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      await _prefs.remove(key);
    } catch (e) {
      throw Exception('Cache remove failed: $e');
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _prefs.clear();
    } catch (e) {
      throw Exception('Cache clear failed: $e');
    }
  }

  @override
  Future<bool> has(String key) async {
    return _prefs.containsKey(key);
  }
}
