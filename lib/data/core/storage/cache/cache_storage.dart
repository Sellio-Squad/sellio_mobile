
abstract class CacheStorage {
  Future<void> save<T>(String key, T data);

  Future<T?> get<T>(String key);

  Future<void> remove(String key);

  Future<void> clear();

  Future<bool> has(String key);
}
