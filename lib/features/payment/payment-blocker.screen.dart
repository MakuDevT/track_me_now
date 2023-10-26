import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/common/widgets/display/backdrop.widget.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:track_me_now/features/authentication/presentation/authentication.controller.dart';
import 'package:track_me_now/features/payment/presentation/payment.controller.dart';

class PaymentBlockerScreen extends ConsumerStatefulWidget {
  const PaymentBlockerScreen({super.key});

  @override
  PaymentBlockerScreenState createState() => PaymentBlockerScreenState();
}

class PaymentBlockerScreenState extends ConsumerState<PaymentBlockerScreen> {
  @override
  Widget build(BuildContext context) {
    return Backdrop(
      color: Colors.blueAccent.withOpacity(.9),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(48),
        child: Card(
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer_off,
                              size: 48,
                              color: Colors.blue[800],
                              shadows: [
                                Shadow(
                                    color: Colors.amber[800]!,
                                    offset: const Offset(2, 2))
                              ],
                            ),
                            const SizedBox(height: 24),
                            RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  text:
                                      'Looks like your trial expires\nor you need to renew your subscription.',
                                ))
                          ],
                        ))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => UsePaypal(
                                  sandboxMode: true,
                                  clientId:
                                      "Ae1xRQh4G6n4LYoo5U0nkWehZHX8WdfEgI8QThHxgbSF_YpgSEKc-KVp6QRcOcuJdJj4oNevyBA24XlO",
                                  secretKey:
                                      "EHcK-tU0FEprCc7EnQTnTvhkcMR10m4cv4w7H5LlBKoOhGCq8L_7JxUgkjdLnZu1oJPQXwFhoVDrGyox",
                                  returnURL: "https://samplesite.com/return",
                                  cancelURL: "https://samplesite.com/cancel",
                                  transactions: const [
                                    {
                                      "amount": {
                                        "total": '500',
                                        "currency": "PHP",
                                        "details": {
                                          "subtotal": '500',
                                          "shipping": '0',
                                          "shipping_discount": 0
                                        }
                                      },
                                      "description":
                                          "The payment transaction description.",
                                      "item_list": {
                                        "items": [
                                          {
                                            "name": "Track",
                                            "quantity": 1,
                                            "price": '500',
                                            "currency": "PHP"
                                          }
                                        ],
                                      }
                                    }
                                  ],
                                  note:
                                      "Contact us for any questions on your order.",
                                  onSuccess: (Map params) async {
                                    final Map<dynamic, dynamic> responseData =
                                        params;
                                    await ref
                                        .read(
                                            paymentBlockScreenControllerProvider
                                                .notifier)
                                        .paypalPayment(
                                            responseData['data']['id'],
                                            500,
                                            'success');
                                    await ref
                                        .read(
                                            authenticationScreenControllerProvider
                                                .notifier)
                                        .updateTrial();
                                  },
                                  onError: (error) {
                                    ref
                                        .read(
                                            paymentBlockScreenControllerProvider
                                                .notifier)
                                        .paypalPayment('', 0, 'Error');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content: Text(
                                                'Failed to perform transaction. Try again.')));
                                  },
                                  onCancel: (params) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content: Text(
                                                'Transaction cancelled. Try again.')));
                                  }),
                            ),
                          );
                        },
                        child: const Text('Pay Now'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
