import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/features/authentication/presentation/authentication.controller.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(forgotPasswordScreenControllerProvider);
    ref.listen<AsyncValue<void>>(
      forgotPasswordScreenControllerProvider,
      (previousState, state) async {
        if (state.hasError && !state.isLoading) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(state.error.toString())));
        }
        if (state.asData != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text('The link has been sent to your email')));
        }
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
            ),
            const Text(
              "Forgot Password",
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: emailController,
                onChanged: (string) => {},
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            state.isLoading
                ? const CircularProgressIndicator()
                : Container(
                    margin:
                        const EdgeInsets.only(bottom: 30, left: 30, right: 30),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder()),
                      onPressed: () {
                        final String email = emailController.text;
                        confirmPasswordController.text;
                        ref
                            .read(
                                forgotPasswordScreenControllerProvider.notifier)
                            .forgotPassword(email);
                      },
                      child: const Text('Forgot Password'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
