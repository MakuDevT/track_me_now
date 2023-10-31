import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/models/register/register.model.dart';
import 'package:track_me_now/features/authentication/change-password.screen.dart';
import 'package:track_me_now/features/authentication/data/authentication.repository.dart';

import '../../../data/services/local/secure-storage.service.dart';

class AuthenticationController extends StateNotifier<AsyncValue<void>> {
  AuthenticationController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));
  final AuthRepository authRepository;
  final SecureStorageService storage = SecureStorageService();
  Register userData = const Register();

  Future<void> firstLoggedIn() async {
    // state = const AsyncValue<void>.loading();
    var isFirstLoggedIn = true;
    storage.saveToken(isFirstLoggedIn.toString());
    // state = const AsyncValue<void>.data(null);
  }

  Future<void> register(
      String email, String password, String confirmPassword) async {
    state = const AsyncValue<void>.loading();
    if (password != confirmPassword) {
      state =
          AsyncValue<void>.error("Password not matched", StackTrace.current);
      return;
    }
    state = await AsyncValue.guard<Register>(() {
      return authRepository
          .registerUser({'email': email, 'password': password});
    });
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue<void>.loading();

    var user = await AsyncValue.guard<Register>(
        () => authRepository.loginUser(email, password));
    if (user.hasValue) {
      user.whenData((value) {
        userData = value;
        state = const AsyncValue<void>.data(null);
      });
    } else {
      state = AsyncValue<void>.error('No Token', StackTrace.current);
      throw Exception("No Token");
    }
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

  Future<void> forgotPassword(String email) async {
    if (email.isEmpty) {
      state = AsyncValue<void>.error("Email is Empty", StackTrace.current);
      return;
    }
    state = const AsyncValue<void>.loading();
    state = await AsyncValue.guard<void>(
        () => authRepository.forgotPassword(email));
  }

  Future<void> resetPassword(
      String id, String password, String confirmPassword) async {
    if (id == "") {
      state = AsyncValue<void>.error("ID is empty", StackTrace.current);
      return;
    } else if (password.isEmpty || confirmPassword.isEmpty) {
      state = AsyncValue<void>.error("fields are empty", StackTrace.current);
      return;
    } else if (password != confirmPassword) {
      state = AsyncValue<void>.error(
          "New password and confirm password doesn't match",
          StackTrace.current);
      return;
    }
    state = const AsyncValue<void>.loading();
    state = await AsyncValue.guard<void>(
        () => authRepository.resetPassword(id, password));
  }

  Future<bool> getUserInfo() async {
    state = const AsyncValue<void>.loading();
    String? token = await storage.getToken();
    if (token != null) {
      var user = await AsyncValue.guard<Register>(
          () => authRepository.getUserInfo(token));
      if (user.error is DioException) {
        return false;
      }
      if (user.hasValue) {
        user.whenData((value) {
          userData = value;
          state = const AsyncValue<void>.data(null);
        });
      }
    } else {
      state = AsyncValue<void>.error('No Token', StackTrace.current);
      throw Exception("No Token");
    }
    return true;
  }

  Future<void> updateTrial() async {
    state = const AsyncValue<void>.loading();
    String? token = await storage.getToken();
    if (token != null) {
      var user = await AsyncValue.guard<Register>(
          () => authRepository.updateTrial(token));
      if (user.hasValue) {
        user.whenData((value) {
          userData = value;
          state = const AsyncValue<void>.data(null);
        });
      }
    } else {
      throw Exception("No Token");
    }
  }

  Future<void> signOut() async {
    try {
      state = const AsyncValue<void>.loading();
      await authRepository.signOutUser();
      storage.saveIsFirstLoggedIn('false');
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

final forgotPasswordScreenControllerProvider =
    StateNotifierProvider<AuthenticationController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthenticationController(authRepository: authRepository);
});

final registerScreenControllerProvider =
    StateNotifierProvider<AuthenticationController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthenticationController(authRepository: authRepository);
});

final loginScreenControllerProvider =
    StateNotifierProvider<AuthenticationController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthenticationController(authRepository: authRepository);
});

final resetPasswordScreenControllerProvider =
    StateNotifierProvider<AuthenticationController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthenticationController(authRepository: authRepository);
});
