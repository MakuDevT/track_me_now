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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
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
                    : Container(
                        margin: const EdgeInsets.only(
                            bottom: 30, left: 30, right: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder()),
                          onPressed: () {
                            final String newPassword =
                                newPasswordController.text;
                            final String confirmNewPassword =
                                confirmNewPasswordController.text;
                            ref
                                .read(resetPasswordScreenControllerProvider
                                    .notifier)
                                .resetPassword(widget.requestId ?? "",
                                    newPassword, confirmNewPassword);
                          },
                          child: const Text('Change Password'),
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
