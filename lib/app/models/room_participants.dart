import 'package:raya_mobile/app/models/room_user_data.dart';

class RoomParticipants {
  RoomParticipants({
    required this.status,
    required this.message,
    required this.result,
  });

  factory RoomParticipants.fromJson(Map<String, dynamic> json){
    return RoomParticipants(
      status: json['status'],
      message: json['message'],
      result: RoomUserData.fromJson(json['result']),
    );
  }

  final bool status;
  final String message;
  final RoomUserData? result;
}