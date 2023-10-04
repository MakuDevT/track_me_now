import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/models/user/user.model.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier()
      : super(User(email: 'test@gmail.com', name: 'Rick Sanchez', userId: '1'));

  void initialize(User user) {
    state = user;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
