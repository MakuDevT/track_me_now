import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me_now/features/authentication/presentation/authentication.controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.requestId});
  final String? requestId;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Change Password"),
            TextField(
              controller: newPasswordController,
              onChanged: (string) => {},
              decoration: const InputDecoration(labelText: 'New Password'),
            ),
            TextField(
              controller: confirmNewPasswordController,
              onChanged: (string) => {},
              decoration:
                  const InputDecoration(labelText: 'Confirm New Password'),
            ),
            Consumer(builder: (context, ref, child) {
              final state = ref.watch(resetPasswordScreenControllerProvider);
              ref.listen<AsyncValue<void>>(
                resetPasswordScreenControllerProvider,
                (previousState, state) async {
                  if (state.hasValue) {
                    context.pushReplacementNamed('login');
                  }

                  if (state.hasError && !state.isLoading) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(state.error.toString())));
                  }
                },
              );
              return state.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        final String newPassword = newPasswordController.text;
                        final String confirmNewPassword =
                            confirmNewPasswordController.text;
                        ref
                            .read(
                                authenticationScreenControllerProvider.notifier)
                            .resetPassword(widget.requestId ?? "", newPassword,
                                confirmNewPassword);
                      },
                      child: const Text('Change Password'),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
