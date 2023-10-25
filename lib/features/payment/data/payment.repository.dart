import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/common/utils/api.util.dart';
import 'package:track_me_now/data/services/local/secure-storage.service.dart';

class PaymentRepository {
  final Dio _dio = Dio();
  final String _baseUrl = ApiUtil.getBaseUrl(noSuffix: true);

  Future<void> paypalPayment(Map<String, dynamic> body, String token) async {
    try {
      Response response = await _dio.post('$_baseUrl/api/transaction/create',
          data: body,
          options: Options(headers: {'Authorization': 'Bearer $token'}));

    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}

final paymentProvider = Provider<PaymentRepository>((ref) {
  final payment = PaymentRepository();
  return payment;
});
