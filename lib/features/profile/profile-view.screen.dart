import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me_now/features/authentication/data/registration.repository.dart';
import 'package:track_me_now/features/authentication/presentation/authentication.controller.dart';

class ProfileViewScreen extends ConsumerStatefulWidget {
  const ProfileViewScreen({super.key});

  @override
  ProfileViewScreenState createState() => ProfileViewScreenState();
}

class ProfileViewScreenState extends ConsumerState<ProfileViewScreen> {
  @override
  Widget build(BuildContext context) {
    // ref.listen(authStateChangesProvider, (previousState, state) {
    //   state.whenData((value) => {print(value?.email)});
    // });
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Profile View Screen'),
          ElevatedButton(
            onPressed: () {
              ref.read(registerScreenControllerProvider.notifier).signOut();
              context.goNamed('login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
