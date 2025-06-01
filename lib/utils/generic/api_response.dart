import 'package:dio/dio.dart';
import 'package:raya_mobile/app/network/api_constants.dart';
import 'package:raya_mobile/app/network/api_failure.dart';
import 'package:raya_mobile/utils/generic/api_result_data.dart';
import 'package:raya_mobile/utils/status_codes.dart';

class ApiResponse<T> {
  ApiResponse({
    required this.statusCode,
    required this.message,
    this.data,
});
  
  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return ApiResponse(
        statusCode: json['statusCode'] as int? ?? 0,
        message: json['message'] as String? ?? '',
      data: json['result'] != null ? fromJson(json['result']) : null,
    );
  }

  factory ApiResponse.fromJsonResponse(
      Response<dynamic> response, T Function(Map<String, dynamic>) fromJson) {
    return ApiResponse(
      statusCode: response.statusCode ?? 0,
      message: response.statusMessage ?? '',
      data: response.data != null ? fromJson(response.data) : null,
    );
  }

  final int statusCode;
  final String message;
  final T? data;

  Result<T> toResult() {
    if (statusCode == StatusCodes.success.code || statusCode == StatusCodes.created.code) {
      if (data != null) {
        return Result.success(data as T);
      } else {
        return Result.failure(Failure(statusCode, noDataReceivedMessage));
      }
    } else {
      return Result.failure(Failure(statusCode, message));
    }
  }
}