import 'package:sqflite/sqflite.dart';

import '../../models/user_model.dart';
import 'database_service/database_service.dart';

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
  final DatabaseService _databaseService;

  UserLocalDataSourceImpl(this._databaseService);

  @override
  Future<UserModel?> getCachedUser() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('users', limit: 1);

    if (maps.isEmpty) return null;

    return UserModel.fromDbMap(maps.first);
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    final db = await _databaseService.database;
    await db.insert(
      'users',
      user.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> clearUserCache() async {
    final db = await _databaseService.database;
    await db.delete('users');
  }

  @override
  Future<String?> getAuthToken() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('auth_tokens', limit: 1);

    if (maps.isEmpty) return null;

    final expiresAt = maps.first['expiresAt'] as int;
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiresAt);

    // Check if token is expired
    if (DateTime.now().isAfter(expiryDate)) {
      await clearAuthToken();
      return null;
    }

    return maps.first['token'] as String;
  }

  @override
  Future<void> saveAuthToken(
    String token, {
    String? refreshToken,
    DateTime? expiresAt,
  }) async {
    final db = await _databaseService.database;
    final expiryMillis =
        (expiresAt ?? DateTime.now().add(const Duration(days: 30)))
            .millisecondsSinceEpoch;

    await db.insert(
      'auth_tokens',
      {
        'id': 1,
        'token': token,
        'refreshToken': refreshToken,
        'expiresAt': expiryMillis,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> clearAuthToken() async {
    final db = await _databaseService.database;
    await db.delete('auth_tokens');
  }
}
