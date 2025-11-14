import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'cache_storage.dart';

class SharedPrefsStorageImpl implements CacheStorage {
  final SharedPreferences _prefs;

  const SharedPrefsStorageImpl(this._prefs);

  @override
  Future<void> save<T>(String key, T data) async {
    try {
      if (data is String) {
        await _prefs.setString(key, data);
      } else if (data is int) {
        await _prefs.setInt(key, data);
      } else if (data is bool) {
        await _prefs.setBool(key, data);
      } else if (data is double) {
        await _prefs.setDouble(key, data);
      } else if (data is List<String>) {
        await _prefs.setStringList(key, data);
      } else {
        await _prefs.setString(key, jsonEncode(data));
      }
    } catch (e) {
      throw Exception(
       'Failed to save data: ${e.toString()}',
      );
    }
  }

  @override
  Future<T?> get<T>(String key) async {
    try {
      if (!_prefs.containsKey(key)) return null;

      if (T == String) {
        return _prefs.getString(key) as T?;
      } else if (T == int) {
        return _prefs.getInt(key) as T?;
      } else if (T == bool) {
        return _prefs.getBool(key) as T?;
      } else if (T == double) {
        return _prefs.getDouble(key) as T?;
      } else {
        final jsonString = _prefs.getString(key);
        if (jsonString == null) return null;
        return jsonDecode(jsonString) as T;
      }
    } catch (e) {
      throw Exception(
        'Failed to retrieve data: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      await _prefs.remove(key);
    } catch (e) {
      throw Exception(
        'Failed to remove data: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _prefs.clear();
    } catch (e) {
      throw Exception(
        'Failed to clear storage: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> has(String key) async {
    return _prefs.containsKey(key);
  }
}