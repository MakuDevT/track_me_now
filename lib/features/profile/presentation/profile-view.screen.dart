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
    return SingleChildScrollView(
      child: Column(
        children: [
          ChangePasswordScreen(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: const Divider(
              height: 20,
              color: Colors.blueAccent,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder()),
              onPressed: () {
                ref
                    .read(authenticationScreenControllerProvider.notifier)
                    .signOut();
                context.pushReplacementNamed('login');
              },
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
