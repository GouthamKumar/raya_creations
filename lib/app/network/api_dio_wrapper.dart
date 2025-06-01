import 'dart:async';

import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:raya_mobile/app/network/api_constants.dart';
import 'package:raya_mobile/app/network/api_error_handler.dart';
import 'package:raya_mobile/app/network/api_utils.dart';

class DioWrapper {
  factory DioWrapper() {
    return _instance;
  }

  DioWrapper._internal() {
    _initializeCompleter = Completer();
    _initializeDio().then((_) {
      _isInitialized = true;
      _initializeCompleter.complete();
    });
  }

  void reinitialize() {
    _initializeDio();
  }

  static final DioWrapper _instance = DioWrapper._internal();

  final Dio dio = Dio();
  late final Completer<void> _initializeCompleter;
  // final SecureStorage secureStorage = SecureStorage();

  bool _isInitialized = false;

  Future<void> _initializeDio() async {
    // final deviceId = await checkDeviceId();
    // final sessionToken =
    // await secureStorage.getSecureString(key: anetSessionToken);
    // final userName = await getUserName();
    // final authorizationString = '$userName:$sessionToken:$deviceId';
    final url = getEnvUrl();
    final customChecker = InternetConnectionChecker.createInstance(
      addresses: [
        AddressCheckOption(uri: Uri.parse(url)),
      ],
    );

    bool isConnected = true; //await customChecker.hasConnection;

    // Clear existing interceptors
    dio.interceptors.clear();

    // Reset and configure dio options
    dio.options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: connectionTimeout),
      receiveTimeout: const Duration(seconds: receiveTimeout),
      headers: {
        apiAccessKey: apiAccessKeyValue,
      },
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add any additional request configuration here if needed
          if (isConnected) {
            return handler.next(options);
            // final isTrusted = await CheckServerTrustRepo().isServerTrusted(url);
            // printCurlCommand(options);
            // // validate ssl pinning
            // if (isTrusted) {
            //   // Update the authorization header for each request
            //   final updatedAuthString = await _getUpdatedAuthorizationString();
            //   options.headers[authorization] = 'Session $updatedAuthString';
            //   return handler.next(options);
            // } else {
            //   return handler.reject(
            //     DioException(
            //       requestOptions: options,
            //       response: Response(
            //         requestOptions: options,
            //         statusCode: ResponseCode.untrustedServer,
            //         statusMessage: ResponseMessage.untrustedServer,
            //       ),
            //       error: ResponseMessage.untrustedServer,
            //     ),
            //   );
            // }
          } else {
            return handler.reject(
              DioException(
                requestOptions: options,
                response: Response(
                  requestOptions: options,
                  statusCode: ResponseCode.noInternetConnection,
                  statusMessage: ResponseMessage.noInternetConnection,
                ),
                error: ResponseMessage.noInternetConnection,
              ),
            );
          }
        },
        onResponse: (response, handler) {
          // Handle the response if needed
          return handler.next(response);
        },
        onError: (error, handler) async {
          // Check if the error status code is 401 (Unauthorized)
          return handler.next(error);
        },
      ),
    );
  }

  // Future<String> _getUpdatedAuthorizationString() async {
  //   // final deviceId = await checkDeviceId();
  //   // final sessionToken = await secureStorage.getSecureString(key: anetSessionToken);
  //   // final userName = await getUserName();
  //   // final authorizationString = '$userName:$sessionToken:$deviceId';
  //   // return base64String(authorizationString);
  // }

  Future<Response> get(String url) async {
    await _ensureInitialized();
    final response = await dio.get(url);
    return response;
  }

  Future<Response> post(
      String url, {
        required dynamic data,
      }) async {
    await _ensureInitialized();
    final response = await dio.post(url, data: data);
    return response;
  }

  Future<Response> put(
      String url, {
        required dynamic data,
      }) async {
    await _ensureInitialized();
    final response = await dio.put(url, data: data);
    return response;
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await _initializeCompleter.future;
    }
  }
}
