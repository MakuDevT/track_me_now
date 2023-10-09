import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rxdart/rxdart.dart';
import 'package:track_me_now/common/utils/api.util.dart';
import 'package:track_me_now/data/services/local/secure-storage.service.dart';

class AuthRepository {
  final SecureStorageService storage = SecureStorageService();
  final Dio _dio = Dio();
  final String _baseUrl = ApiUtil.getBaseUrl(noSuffix: true);

  final _authState = InMemoryStore<AppUser?>(null);
  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  Future<void> registerUser(String email, String password) async {
    try {
      Response response = await _dio.post('$_baseUrl/api/auth/register', data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = response.data['data'];
        storage.saveToken(responseData['token']);
        _authState.value = AppUser(
          token: responseData['token'],
          email: responseData['email'],
          uid: responseData['id'],
          trialDue: responseData['trialDue'],
          isActive: responseData['isActive'],
          isAdmin: responseData['isAdmin'],
          isSubscribed: responseData['isSubscribed'],
        );
      }
    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post('$_baseUrl/api/auth/login', data: {
        'email': email,
        'password': password,
      });
      final Map<String, dynamic> responseData = response.data['data'];
      storage.saveToken(responseData['token']);

      print('Registration Successful: ${response.data}');
    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOutUser() async {
    storage.clearToken();
    storage.clearDeviceId();
    _authState.value = null;
  }

  void dispose() => _authState.close();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final auth = AuthRepository();
  ref.onDispose(() => auth.dispose());
  return auth;
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});

class AppUser {
  final String? uid;
  final String? email;
  final String? trialDue;
  final String token;
  final bool? isActive;
  final bool? isSubscribed;
  final bool? isAdmin;

  const AppUser({
    this.uid,
    this.email,
    this.trialDue,
    required this.token,
    this.isActive,
    this.isSubscribed,
    this.isAdmin,
  });
}

class InMemoryStore<T> {
  final BehaviorSubject<T> _subject;

  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);
  Stream<T> get stream => _subject.stream;
  T get value => _subject.value;
  set value(T value) => _subject.add(value);

  void close() => _subject.close();
}
