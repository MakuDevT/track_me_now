import 'package:dio/dio.dart';
import 'package:track_me_now/data/models/room/room.model.dart';
import 'package:track_me_now/data/services/remote/base-api.service.dart';

class RoomApiService extends BaseApiService {
  static final RoomApiService instance = RoomApiService._internal();

  factory RoomApiService() {
    return instance;
  }

  RoomApiService._internal();

  Future<Room> getRoomById(String roomId) async {
    try {
      final response = await dio.get(
        '/room?id=$roomId',
      );

      return Room.fromJson(response.data['data']);
    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Room>> searchRoom(List<String> participants) async {
    try {
      final response = await dio.post(
        '/room/search',
        data: {
          "participants": participants,
        },
      );

      return response.data['data']
          .map<Room>((room) => Room.fromJson(room))
          .toList();
    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Room> createRoom(List<String> participants) async {
    try {
      final response = await dio.post(
        '/room/create',
        data: {
          "participants": participants,
        },
      );

      return Room.fromJson(response.data['data']);
    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}
