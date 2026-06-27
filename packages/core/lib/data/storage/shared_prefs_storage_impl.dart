import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'storage_service.dart';

class SharedPrefsStorageImpl implements StorageService {
  final SharedPreferences _prefs;

  SharedPrefsStorageImpl(this._prefs);

  @override
  Future<void> save<T>(String key, T value) async {
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
  }

  @override
  Future<T?> get<T>(String key) async {
    if (!_prefs.containsKey(key)) return null;

    if (T == String) {
      return _prefs.getString(key) as T?;
    } else if (T == int) {
      return _prefs.getInt(key) as T?;
    } else if (T == bool) {
      return _prefs.getBool(key) as T?;
    } else if (T == double) {
      return _prefs.getDouble(key) as T?;
    } else if (T == List<String>) {
      return _prefs.getStringList(key) as T?;
    }

    return _prefs.get(key) as T?;
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }

  @override
  Future<bool> has(String key) async {
    return _prefs.containsKey(key);
  }
}
