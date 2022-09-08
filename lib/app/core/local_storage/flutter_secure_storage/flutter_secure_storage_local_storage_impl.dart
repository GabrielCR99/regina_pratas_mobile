import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../local_storage.dart';

class FlutterSecureStorageLocalStorageImpl implements LocalSecureStorage {
  FlutterSecureStorage get _instance => const FlutterSecureStorage();

  @override
  Future<void> clear() async => _instance.deleteAll();

  @override
  Future<bool> contains(String key) async => _instance.containsKey(key: key);

  @override
  Future<String?> read(String key) async => _instance.read(key: key);

  @override
  Future<void> remove(String key) async => _instance.delete(key: key);

  @override
  Future<void> write(String key, String value) async =>
      _instance.write(key: key, value: value);
}
