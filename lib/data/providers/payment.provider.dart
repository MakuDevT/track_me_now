import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/models/register/register.model.dart';
import 'package:track_me_now/data/services/remote/payment-api.service.dart';

class PaymentNotifier extends StateNotifier {
  PaymentNotifier() : super(null);

  Future<Register> startTrial() async {
    try {
      var user = await PaymentApiService().startTrial();
      return user;
    } catch (err) {
      throw Exception("Failed to start trial");
    }
  }
}

final paymentProvider = StateNotifierProvider<PaymentNotifier, void>((ref) {
  return PaymentNotifier();
});
