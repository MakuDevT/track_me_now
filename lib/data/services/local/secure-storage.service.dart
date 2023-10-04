import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService extends FlutterSecureStorage {
  Future<void> saveToken(String token) async {
    return write(key: 'token', value: token);
  }

  Future<String?> getToken() {
    return read(key: 'token');
  }

  Future<void> clearToken() async {
    return delete(key: 'token');
  }
}
