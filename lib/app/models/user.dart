class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image_path,
    required this.role_id,
    required this.roleName,
});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image_path: json['image_path'],
      role_id: json['role_id'],
      roleName: json['roleName'],
    );
  }

  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? image_path;
  final String? role_id;
  final String? roleName;
}
