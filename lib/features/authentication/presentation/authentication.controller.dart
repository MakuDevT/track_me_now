import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/models/register/register.model.dart';
import 'package:track_me_now/features/authentication/data/authentication.repository.dart';

import '../../../data/services/local/secure-storage.service.dart';

class AuthenticationController extends StateNotifier<AsyncValue<void>> {
  AuthenticationController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));
  final AuthRepository authRepository;
  final SecureStorageService storage = SecureStorageService();

  Future<void> register(
      String email, String password, String confirmPassword) async {
    state = const AsyncValue<void>.loading();
    if (password != confirmPassword) {
      state =
          AsyncValue<void>.error("Password not matched", StackTrace.current);
      return;
    }
    state = await AsyncValue.guard<Register>(() =>
        authRepository.registerUser({'email': email, 'password': password}));
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue<void>.loading();
    state = await AsyncValue.guard<void>(
        () => authRepository.loginUser(email, password));
  }

  Future<void> changePassword(String currentPassword, String confirmNewPassword,
      String newPassword) async {
    state = const AsyncValue<void>.loading();
    if (confirmNewPassword != newPassword) {
      state = AsyncValue<void>.error(
          "New Password not matched", StackTrace.current);
      return;
    }
    String? token = await storage.getToken();
    if (token != null) {
      state = await AsyncValue.guard<void>(() => authRepository.changePassword({
            'currentPassword': currentPassword,
            'newPassword': newPassword,
          }, token));

      if (state.asData != null) {
        state =
            await AsyncValue.guard<void>(() => authRepository.signOutUser());
      }
    }
  }

  Future<Register> getUserInfo() async {
    state = const AsyncValue<void>.loading();
    String? token = await storage.getToken();
    if (token != null) {
      var user = await authRepository.getUserInfo(token);
      return user;
    }
    throw Exception("No token");
  }

  Future<void> signOut() async {
    try {
      state = const AsyncValue<void>.loading();
      await authRepository.signOutUser();
      state = const AsyncValue<void>.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue<void>.error(e, stackTrace);
    }
  }
}

final authenticationScreenControllerProvider =
    StateNotifierProvider<AuthenticationController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthenticationController(authRepository: authRepository);
});
