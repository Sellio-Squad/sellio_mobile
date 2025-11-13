abstract class AuthStorage {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();

  Future<void> saveRefreshToken(String token);
  Future<String?> getRefreshToken();

  Future<void> saveUserId(String userId);
  Future<String?> getUserId();

  Future<void> clearAll();
  Future<bool> hasValidSession();
}