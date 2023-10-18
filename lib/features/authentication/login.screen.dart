import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';
import 'package:track_me_now/features/authentication/presentation/authentication.controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(authenticationScreenControllerProvider);

    ref.listen<AsyncValue<void>>(
      authenticationScreenControllerProvider,
      (previousState, state) async {
        if (state.hasValue) {
          await ref.read(deviceListProvider.notifier).initialize();
          await ref
              .read(authenticationScreenControllerProvider.notifier)
              .getUserInfo();
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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Track Me Now"),
            const Text("Enter Credentials"),
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
            GestureDetector(
              onTap: () => {context.pushNamed('register')},
              child: Text("register account"),
            ),
            state.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      final String email = emailController.text;
                      final String password = passwordController.text;
                      ref
                          .read(authenticationScreenControllerProvider.notifier)
                          .login(email, password);
                    },
                    child: const Text('login'),
                  ),
          ],
        ),
      ),
    );
  }
}
