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
  bool _passwordVisible = true;
  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(loginScreenControllerProvider);

    ref.listen<AsyncValue<void>>(
      loginScreenControllerProvider,
      (previousState, state) async {
        if (state.hasValue) {
          await ref.read(deviceListProvider.notifier).initialize();
          context.goNamed('home');
        }

        if (state.hasError && !state.isLoading) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Column(
                children: [
                  Text(state.error.toString()),
                ],
              )));
        }
      },
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
              ),
              const Text(
                "Track Me Now",
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
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      obscureText: _passwordVisible,
                      controller: passwordController,
                      onChanged: (string) => {},
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
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
                      height: 30,
                    ),
                  ],
                ),
              ),
              state.isLoading
                  ? Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: const CircularProgressIndicator())
                  : Container(
                      margin: const EdgeInsets.only(
                          bottom: 30, left: 30, right: 30),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder()),
                        onPressed: () {
                          final String email = emailController.text;
                          final String password = passwordController.text;
                          ref
                              .read(loginScreenControllerProvider.notifier)
                              .login(email, password);
                        },
                        child: const Text('login'),
                      ),
                    ),
              Container(
                child: GestureDetector(
                  onTap: () => {context.pushNamed('register')},
                  child: const Text(
                    "Register Account",
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: const Divider(
                  height: 20,
                  color: Colors.blueAccent,
                ),
              ),
              GestureDetector(
                onTap: () => {context.pushNamed('forgotPassword')},
                child: Container(child: const Text("Forgot Password")),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                "Developed by ChnChn, ET AL",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
