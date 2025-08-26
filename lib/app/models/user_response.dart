

import 'package:raya_mobile/app/models/user.dart';

class UserResponse {
  UserResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json){
    return UserResponse(
      status: json['status'],
      message: json['message'],
      result: User.fromJson(json['result']),
    );
  }

  final bool status;
  final String message;
  final User? result;
}