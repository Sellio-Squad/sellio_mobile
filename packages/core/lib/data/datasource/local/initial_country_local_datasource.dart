import 'dart:io';

abstract class InitialCountryLocalDataSource {
  Future<String?> getCountryCode();
}

class InitialCountryLocalDataSourceImpl
    implements InitialCountryLocalDataSource {
  @override
  Future<String?> getCountryCode() {
    final locale = Platform.localeName;
    final parts = locale.split('_');
    if (parts.length >= 2) {
      return Future.value(parts[1].toUpperCase());
    }
    return Future.value(null);
  }
}
