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
  bool _passwordVisible = true;
  bool _passwordVisible2 = true;
  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
    _passwordVisible2 = true;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(registerScreenControllerProvider);
    ref.listen<AsyncValue<void>>(
      registerScreenControllerProvider,
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              const Text(
                "Register",
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
                    TextField(
                      controller: confirmPasswordController,
                      onChanged: (string) => {},
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
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
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 350,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            icon: const Icon(Icons.close),
                                            tooltip: 'Exit Modal',
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                            "We don’t sell your personal data to advertisers, and we don’t share information that directly identifies you (such as your name, email address or other contact information) with advertisers unless you give us specific permission."),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                            " Instead, advertisers can tell us things like the kind of audience they want to see their ads, and we show those ads to people who may be interested. We provide advertisers with reports about the performance of their ads that help them understand how people are interacting with their content."),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text:
                                      "By clicking Sign Up, you agree to our ",
                                ),
                                TextSpan(
                                  text: "Terms, Privacy Policy",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              state.isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                      margin: const EdgeInsets.only(
                          bottom: 30, left: 30, right: 30),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder()),
                        onPressed: () {
                          final String email = emailController.text;
                          final String password = passwordController.text;
                          final String confirmPassword =
                              confirmPasswordController.text;
                          ref
                              .read(registerScreenControllerProvider.notifier)
                              .register(email, password, confirmPassword);
                        },
                        child: const Text('Sign Up'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
