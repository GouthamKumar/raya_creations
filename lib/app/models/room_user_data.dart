class RoomUserData {
  RoomUserData({
    required this.roomUsers,
  });

  factory RoomUserData.fromJson(Map<String, dynamic> json) {
    return RoomUserData(
      roomUsers: List<RoomUser>.from(
          json['data'].map((x) => RoomUser.fromJson(x as Map<String, dynamic>))),
    );
  }
  final List<RoomUser?> roomUsers;
}

class RoomUser {
  RoomUser({
    required this.room_name,
    required this.user_id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image_path,
    required this.role_id,
  });

  factory RoomUser.fromJson(Map<String, dynamic> json) {
    return RoomUser(
      room_name: json['room_name'],
      user_id: json['user_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image_path: json['image_path'],
      role_id: json['role_id'],
    );
  }

  final String room_name;
  final String user_id;
  final String name;
  final String? email;
  final String? phone;
  final String? image_path;
  final String? role_id;
}
