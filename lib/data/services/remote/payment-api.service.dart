import 'package:dio/dio.dart';
import 'package:track_me_now/data/models/register/register.model.dart';
import 'package:track_me_now/data/services/remote/base-api.service.dart';

class PaymentApiService extends BaseApiService {
  static final PaymentApiService instance = PaymentApiService._internal();

  factory PaymentApiService() {
    return instance;
  }

  PaymentApiService._internal();

  Future<Register> startTrial() async {
    try {
      final response = await dio.patch(
        '/user/trial',
      );

      return Register.fromJson(response.data['data']);
    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}
