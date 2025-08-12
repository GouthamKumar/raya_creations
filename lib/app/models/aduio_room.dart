class AudioRoom {
  AudioRoom({
    required this.id,
    required this.title,
    this.description,
    this.max_participants,
    this.max_audiance,
    this.agora_token,
    this.status,
    this.created_at,
});

  factory AudioRoom.fromJson(Map<String, dynamic> json) {
    return AudioRoom(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      max_participants: json['max_participants'],
      max_audiance: json['max_audiance'],
      agora_token: json['agora_token'],
      status: json['status'],
      created_at: json['created_at'],
    );
  }

  final String id;
  final String title;
  final String? description;
  final String? max_participants;
  final String? max_audiance;
  final String? agora_token;
  final String? status;
  final String? created_at;
}

class AudioRoomList {
  AudioRoomList({
    required this.audioRooms,
  });

  factory AudioRoomList.fromJson(List list) {
    return AudioRoomList(
      audioRooms: list
          .map((i) => AudioRoom.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  final List<AudioRoom> audioRooms;
}
