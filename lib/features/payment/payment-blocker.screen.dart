import 'package:flutter/material.dart';
import 'package:track_me_now/common/widgets/display/backdrop.widget.dart';

class PaymentBlockerScreen extends StatelessWidget {
  const PaymentBlockerScreen({super.key});

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
                          //TODO: Redirect to payment page
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
