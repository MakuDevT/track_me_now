import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtil {
  static final DeviceUtil instance = DeviceUtil._internal();

  factory DeviceUtil() {
    return instance;
  }

  DeviceUtil._internal();

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String?> getModel() async {
    if (Platform.isAndroid) {
      var info = await _deviceInfo.androidInfo;
      return info.model;
    } else if (Platform.isIOS) {
      var info = await _deviceInfo.iosInfo;
      return info.model;
    }
    return null;
  }

  Future<String?> getDeviceId() async {
    if (Platform.isAndroid) {
      var info = await _deviceInfo.androidInfo;
      return info.id;
    } else if (Platform.isIOS) {
      var info = await _deviceInfo.iosInfo;
      return info.identifierForVendor;
    }
    return null;
  }
}
