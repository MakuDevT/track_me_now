import "package:dio/dio.dart";
import "package:go_router/go_router.dart";
import "package:track_me_now/common/utils/api.util.dart";
import "package:track_me_now/data/services/local/secure-storage.service.dart";
import "package:track_me_now/main.dart";

class BaseApiService {
  final SecureStorageService _secureStorageService = SecureStorageService();
  String baseUrl = '';
  late Dio dio;

  BaseApiService() {
    baseUrl = ApiUtil.getBaseUrl();
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    )..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            var token = await _secureStorageService.getToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
          onResponse: (response, handler) {
            return handler.next(response);
          },
          onError: (error, handler) {
            if (error.response?.statusCode == 403) {
              if (navigatorKey.currentContext != null) {
                SecureStorageService storage = SecureStorageService();
                storage.clearIsFirstLoggedIn();
                storage.clearDeviceId();
                storage.clearToken();
                GoRouter.of(navigatorKey.currentContext!).pushNamed('login');
              }
            }
            return handler.next(error);
          },
        ),
      );
  }
}
