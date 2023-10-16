import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me_now/features/authentication/data/authentication.repository.dart';
import 'package:track_me_now/features/authentication/presentation/authentication.controller.dart';

import '../../authentication/change-password.screen.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          ChangePasswordScreen(),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(authenticationScreenControllerProvider.notifier)
                  .signOut();
              context.pushReplacementNamed('login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
