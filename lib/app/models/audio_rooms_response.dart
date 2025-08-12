
import 'package:raya_mobile/app/models/aduio_room.dart';

class AudioResponse {
  AudioResponse({
    required this.status,
    required this.message,
    required this.room,
  });

  factory AudioResponse.fromJson(Map<String, dynamic> json){
    return AudioResponse(
      status: json['status'],
      message: json['message'],
      room: AudioRoomList.fromJson((json['result']) as List).audioRooms,
    );
  }

  final bool status;
  final String message;
  final List<AudioRoom?> room;

}