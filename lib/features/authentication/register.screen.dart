import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';
import 'package:track_me_now/features/authentication/presentation/authentication.controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(authenticationScreenControllerProvider);
    ref.listen<AsyncValue<void>>(
      authenticationScreenControllerProvider,
      (previousState, state) async {
        if (state.hasValue) {
          context.goNamed('home');
        }

        if (state.hasError && !state.isLoading) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(state.error.toString())));
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
            const Text("SignUp"),
            TextField(
              controller: emailController,
              onChanged: (string) => {},
              decoration: const InputDecoration(labelText: 'Email Address'),
            ),
            TextField(
              controller: passwordController,
              onChanged: (string) => {},
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: confirmPasswordController,
              onChanged: (string) => {},
              decoration: const InputDecoration(labelText: 'Confirm Password'),
            ),
            state.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      final String email = emailController.text;
                      final String password = passwordController.text;
                      final String confirmPassword =
                          confirmPasswordController.text;
                      ref
                          .read(authenticationScreenControllerProvider.notifier)
                          .register(email, password, confirmPassword);
                    },
                    child: const Text('Register'),
                  ),
          ],
        ),
      ),
    );
  }
}
