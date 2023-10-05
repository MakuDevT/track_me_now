import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rxdart/rxdart.dart';
import 'package:track_me_now/data/services/local/secure-storage.service.dart';

class AuthRepository {
  final SecureStorageService storage = SecureStorageService();
  final Dio _dio = Dio();
  final String _baseUrl = 'http://localhost:4000';

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
            uid: responseData['id']);
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

      print('Registration Successful: ${response.data}');
    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOutUser() async {
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
  final String token;
  const AppUser({this.uid, this.email, required this.token});
}

class InMemoryStore<T> {
  final BehaviorSubject<T> _subject;

  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);
  Stream<T> get stream => _subject.stream;
  T get value => _subject.value;
  set value(T value) => _subject.add(value);

  void close() => _subject.close();
}