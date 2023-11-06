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
  bool _passwordVisible = true;
  bool _passwordVisible2 = true;
  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
    _passwordVisible2 = true;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
              ),
              Image.asset('assets/images/logo.png', height: 72),
              const Text(
                "Reset Password",
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
                      obscureText: _passwordVisible,
                      controller: newPasswordController,
                      onChanged: (string) => {},
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        isDense: true,
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      obscureText: _passwordVisible2,
                      controller: confirmNewPasswordController,
                      onChanged: (string) => {},
                      decoration: InputDecoration(
                        labelText: 'Confirm New Password',
                        isDense: true,
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible2
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible2 = !_passwordVisible2;
                            });
                          },
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
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
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
                            child: const Text('Reset Password'),
                          ),
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
