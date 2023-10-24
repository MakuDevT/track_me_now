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

  Future<void> saveDeviceId(String deviceId) async {
    return write(key: 'deviceId', value: deviceId);
  }

  Future<String?> getDeviceId() {
    return read(key: 'deviceId');
  }

  Future<void> clearDeviceId() async {
    return delete(key: 'deviceId');
  }

  Future<void> saveIsFirstLoggedIn(String val) async {
    return write(key: 'isFirstLoggedIn', value: val);
  }

  Future<String?> getIsFirstLoggedIn() {
    return read(key: 'isFirstLoggedIn');
  }

  Future<void> clearIsFirstLoggedIn() async {
    return delete(key: 'isFirstLoggedIn');
  }
}
