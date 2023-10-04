import "package:dio/dio.dart";
import 'package:track_me_now/data/models/device/device.model.dart';
import "package:track_me_now/data/services/remote/base-api.service.dart";

class DeviceApiService extends BaseApiService {
  static final DeviceApiService instance = DeviceApiService._internal();

  factory DeviceApiService() {
    return instance;
  }

  DeviceApiService._internal();

  Future<List<Device>> getUserDevices() async {
    try {
      final response = await dio.get(
        '/device/connected',
      );

      return response.data['data']
          .map<Device>((device) => Device.fromJson(device))
          .toList();
    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Device> getUserDevice(String deviceId) async {
    try {
      final response = await dio.get(
        '/device/connected?id=$deviceId',
      );

      return Device.fromJson(response.data['data']);
    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Device> creteUserDevice(String macAddress) async {
    try {
      final response = await dio.post(
        '/device/create',
        data: {"macAddress": macAddress},
      );

      return Device.fromJson(response.data['data']);
    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}
