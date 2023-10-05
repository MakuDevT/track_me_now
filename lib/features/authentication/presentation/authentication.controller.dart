import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/features/authentication/data/registration.repository.dart';

class RegisterScreenController extends StateNotifier<AsyncValue<void>> {
  RegisterScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));
  final AuthRepository authRepository;

  Future<void> register(
      String email, String password, String confirmPassword) async {
    state = const AsyncValue<void>.loading();
    if (password != confirmPassword) {
      state =
          AsyncValue<void>.error("Password not matched", StackTrace.current);
      return;
    }
    state = await AsyncValue.guard(
        () => authRepository.registerUser(email, password));
  }

  Future<void> login(
      String email, String password) async {
    state = const AsyncValue<void>.loading();
    state =
        await AsyncValue.guard(() => authRepository.loginUser(email, password));
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

final registerScreenControllerProvider = StateNotifierProvider.autoDispose<
    RegisterScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return RegisterScreenController(authRepository: authRepository);
});
