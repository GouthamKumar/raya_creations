import 'package:dio/dio.dart';
import 'package:raya_mobile/app/models/albums.dart';
import 'package:raya_mobile/app/models/audio_rooms_response.dart';
import 'package:raya_mobile/app/models/banners.dart';
import 'package:raya_mobile/app/models/podcasts.dart';
import 'package:raya_mobile/app/models/user_response.dart';
import 'package:raya_mobile/app/network/api_constants.dart';
import 'package:raya_mobile/utils/generic/api_response.dart';
import 'package:raya_mobile/utils/status_codes.dart';

ApiResponse<T> handleResponse<T>(
  RequestType requestType,
  Response<dynamic> response, {
  dynamic error,
}) {
  switch (requestType) {
    case RequestType.getPodcastAlbums:
      return ApiResponse<T>(
        statusCode:
            response.statusCode ?? StatusCodes.unexpectedServerError.code,
        message: response.statusMessage ?? errorDefault,
        data: Albums.fromJson(response.data as Map<String, dynamic>) as T,
      );
    case RequestType.getPodCasts:
      return ApiResponse<T>(
        statusCode:
            response.statusCode ?? StatusCodes.unexpectedServerError.code,
        message: response.statusMessage ?? errorDefault,
        data: Podcasts.fromJson(response.data as Map<String, dynamic>) as T,
      );
    case RequestType.getBanners:
      return ApiResponse<T>(
        statusCode:
            response.statusCode ?? StatusCodes.unexpectedServerError.code,
        message: response.statusMessage ?? errorDefault,
        data: Banners.fromJson(response.data as Map<String, dynamic>) as T,
      );
    case RequestType.getError:
      if (error is DioException) {
        if (error.response != null) {
          final responseStatus = error.response!;
          return handleError(
            requestType,
            responseStatus.statusMessage,
            responseStatus.statusCode ?? StatusCodes.unexpectedServerError.code,
          );
        } else {
          return handleError(
            requestType,
            errorDefault,
            StatusCodes.unexpectedServerError.code,
          );
        }
      } else {
        return handleError(
          requestType,
          errorDefault,
          StatusCodes.unexpectedServerError.code,
        );
      }
    case RequestType.postCheckUser:
      return ApiResponse<T>(
        statusCode:
            response.statusCode ?? StatusCodes.unexpectedServerError.code,
        message: response.statusMessage ?? errorDefault,
        data: UserResponse.fromJson(response.data as Map<String, dynamic>) as T,
      );
    case RequestType.postRegisterUser:
      return ApiResponse<T>(
        statusCode:
        response.statusCode ?? StatusCodes.unexpectedServerError.code,
        message: response.statusMessage ?? errorDefault,
        data: UserResponse.fromJson(response.data as Map<String, dynamic>) as T,
      );
    case RequestType.postLoginUser:
      return ApiResponse<T>(
        statusCode:
        response.statusCode ?? StatusCodes.unexpectedServerError.code,
        message: response.statusMessage ?? errorDefault,
        data: UserResponse.fromJson(response.data as Map<String, dynamic>) as T,
      );
    case RequestType.getAudios:
      return ApiResponse<T>(
        statusCode:
        response.statusCode ?? StatusCodes.unexpectedServerError.code,
        message: response.statusMessage ?? errorDefault,
        data: AudioResponse.fromJson(response.data as Map<String, dynamic>) as T,
      );
  }
}

ApiResponse<T> handleError<T>(
  RequestType requestType,
  dynamic error,
  int statusCode,
) {
  return ApiResponse<T>(
    statusCode: statusCode,
    message: error.toString(),
  );
}
