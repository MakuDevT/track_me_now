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
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.51,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text(
              "Change Password",
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  TextField(
                    controller: currentPasswordController,
                    onChanged: (string) => {},
                    decoration: const InputDecoration(
                      labelText: 'Current Password',
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
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: newPasswordController,
                    onChanged: (string) => {},
                    decoration: const InputDecoration(
                      labelText: 'New Password',
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
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: confirmNewPasswordController,
                    onChanged: (string) => {},
                    decoration: const InputDecoration(
                      labelText: 'Confirm New Password',
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
                ],
              ),
            ),
            const SizedBox(
              height: 30,
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
                  : Container(
                      margin: const EdgeInsets.only(
                           left: 30, right: 30),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder()),
                        onPressed: () {
                          final String currentPassword =
                              currentPasswordController.text;
                          final String newPassword = newPasswordController.text;
                          final String confirmNewPassword =
                              confirmNewPasswordController.text;
                          ref
                              .read(authenticationScreenControllerProvider
                                  .notifier)
                              .changePassword(currentPassword,
                                  confirmNewPassword, newPassword);
                        },
                        child: const Text('Change Password'),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
