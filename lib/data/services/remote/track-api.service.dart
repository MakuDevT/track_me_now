import 'package:dio/dio.dart';
import 'package:track_me_now/data/models/track/track.model.dart';
import 'package:track_me_now/data/services/remote/base-api.service.dart';

class TrackApiService extends BaseApiService {
  static final TrackApiService instance = TrackApiService._internal();

  factory TrackApiService() {
    return instance;
  }

  TrackApiService._internal();

  Future<Track> createTrack(String deviceId, double lat, double lng) async {
    try {
      final response = await dio.post(
        '/track/create',
        data: {
          "deviceId": deviceId,
          "latitude": lat.toString(),
          "longitude": lng.toString()
        },
      );

      return Track.fromJson(response.data['data']);
    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}
