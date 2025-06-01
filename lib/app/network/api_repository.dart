import 'package:dio/dio.dart';
import 'package:raya_mobile/app/network/api_dio_wrapper.dart';
import 'package:raya_mobile/app/network/api_constants.dart';
import 'package:raya_mobile/app/network/api_resp_handler.dart';
import 'package:raya_mobile/app/network/api_utils.dart';
import 'package:raya_mobile/utils/generic/api_response.dart';

class ApiRepository {
  final DioWrapper dio = DioWrapper();

  Future<ApiResponse<T>> performRequest<T>({
    required RequestType requestType,
    required RequestMethod requestMethod,
    dynamic data,
    dynamic paramsData,
  }) async {
    final path = getUrl(requestType, data, paramsData);
    var response = Response<dynamic>(requestOptions: RequestOptions());
    try {
      switch (requestMethod) {
        case RequestMethod.get:
          response = await dio.get(path);
        case RequestMethod.post:
          response = await dio.post(path, data: data);
        case RequestMethod.put:
          response = await dio.put(path, data: data);
        case RequestMethod.getError:
          throw UnsupportedError('Request method not supported');
      }
      return handleResponse<T>(requestType, response);
    } catch (error) {
      return handleResponse<T>(RequestType.getError, response, error: error);
    }
  }
}
