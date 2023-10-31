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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Forgot Password"),
            TextField(
              controller: emailController,
              onChanged: (string) => {},
              decoration: const InputDecoration(labelText: 'Email Address'),
            ),
            state.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      final String email = emailController.text;
                      confirmPasswordController.text;
                      ref
                          .read(forgotPasswordScreenControllerProvider.notifier)
                          .forgotPassword(email);
                    },
                    child: const Text('Forgot Password'),
                  ),
          ],
        ),
      ),
    );
  }
}
