import "package:dio/dio.dart";
import "package:track_me_now/common/utils/api.util.dart";
import "package:track_me_now/data/services/local/secure-storage.service.dart";

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
            //TODO: Reneable this commented logic once login is implemented
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
          onResponse: (response, handler) {
            return handler.next(response);
          },
          // onError: (error, handler) {
          //   Future.delayed(Duration.zero, () {
          //     showDialog(
          //       context: Globals.navigatorKey.currentContext!,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: const Text('API Call'),
          //           content:
          //               const Text('Error occurred during API call execution.'),
          //           actions: <Widget>[
          //             TextButton(
          //               child: const Text('Close'),
          //               onPressed: () {},
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   });

          //   return handler.next(error);
          // },
        ),
      );
  }
}
