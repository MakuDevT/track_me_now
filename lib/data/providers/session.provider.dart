import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionNotifier extends StateNotifier<bool> {
  SessionNotifier() : super(false);

  void hasLoggedInBefore() {
    state = true;
  }
}

final sessionProvider =
    StateNotifierProvider<SessionNotifier, bool>((ref) => SessionNotifier());
