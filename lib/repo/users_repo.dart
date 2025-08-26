import 'package:raya_mobile/app/models/user_response.dart';
import 'package:raya_mobile/app/network/api_constants.dart';
import 'package:raya_mobile/app/network/api_repository.dart';
import 'package:raya_mobile/util/utils.dart';
import 'package:raya_mobile/utils/generic/api_result_data.dart';

class UsersRepo {
  final ApiRepository apiRepository = ApiRepository();

  Future<Result<UserResponse>> checkUse(String mobileNumber) async {
    final response = await apiRepository.performRequest<UserResponse>(
        requestType: RequestType.postCheckUser,
        requestMethod: RequestMethod.post,
        data: {'username': mobileNumber});
    return response.toResult();
  }

  Future<Result<UserResponse>> registerUser(String mobileNumber, String name, String email, ) async {
    final response = await apiRepository.performRequest<UserResponse>(
        requestType: RequestType.postRegisterUser,
        requestMethod: RequestMethod.post,
        data: {
          'phone': mobileNumber,
          'password': reverseStringUsingCodeUnits(mobileNumber),
          'name': name,
          'email': email,
          'role_id': '5',
          'status': 'ACTIVE',
          'token': 'xyz'
        });
    return response.toResult();
  }

  Future<Result<UserResponse>> loginUser(String mobileNumber, String name, String email, ) async {
    final response = await apiRepository.performRequest<UserResponse>(
        requestType: RequestType.postRegisterUser,
        requestMethod: RequestMethod.post,
        data: {
          'username': mobileNumber,
          'password': reverseStringUsingCodeUnits(mobileNumber),
          'role_id': userRoleId,
        });
    return response.toResult();
  }

  Future<Result<UserResponse>> getUserInfo(String userId) async {
    final response = await apiRepository.performRequest<UserResponse>(
        requestType: RequestType.getUserInfo,
        requestMethod: RequestMethod.get,
        data: {
          'id': userId,
        });
    return response.toResult();
  }
}