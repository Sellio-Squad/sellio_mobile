abstract class StorageService {
  Future<void> save<T>(String key, T value);
  Future<T?> get<T>(String key);
  Future<void> remove(String key);
  Future<void> clear();
  Future<bool> has(String key);
}
