import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me_now/data/services/local/secure-storage.service.dart';
import 'package:track_me_now/features/authentication/presentation/authentication.controller.dart';
import 'package:track_me_now/features/payment/data/payment.repository.dart';

class PaymentController extends StateNotifier<AsyncValue<void>> {
  PaymentController({required this.paymentRepository})
      : super(const AsyncValue<void>.data(null));
  final PaymentRepository paymentRepository;
  final SecureStorageService storage = SecureStorageService();

  Future<void> paypalPayment(String code, num amount, String status) async {
    String? token = await storage.getToken();
    if (token != null) {
      state = await AsyncValue.guard<void>(() {
        return paymentRepository.paypalPayment(
            {'code': code, 'amount': amount, 'status': status}, token);
      });
    }

    print(">>>>> ${state}");
  }
}

final paymentBlockScreenControllerProvider =
    StateNotifierProvider<PaymentController, AsyncValue<void>>((ref) {
  final paymentRepository = ref.watch(paymentProvider);
  return PaymentController(paymentRepository: paymentRepository);
});
