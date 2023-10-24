import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me_now/features/authentication/presentation/authentication.controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Change Password"),
          TextField(
            controller: currentPasswordController,
            onChanged: (string) => {},
            decoration: const InputDecoration(labelText: 'Current Password'),
          ),
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
            final state = ref.watch(authenticationScreenControllerProvider);
            ref.listen<AsyncValue<void>>(
              authenticationScreenControllerProvider,
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
                      final String currentPassword =
                          currentPasswordController.text;
                      final String newPassword = newPasswordController.text;
                      final String confirmNewPassword =
                          confirmNewPasswordController.text;
                      ref
                          .read(authenticationScreenControllerProvider.notifier)
                          .changePassword(
                              currentPassword, confirmNewPassword, newPassword);
                    },
                    child: const Text('Change Password'),
                  );
          }),
        ],
      ),
    );
  }
}
