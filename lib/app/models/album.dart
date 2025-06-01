class Album {
  Album({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.status,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
      imagePath: json['image_path'],
      status: json['status'],
    );
  }

  final String id;
  final String name;
  final String imagePath;
  final String status;

  String toJson() {
    return '{"id": $id, "name": $name, "imagePath": $imagePath, "status": $status}';
  }
}

class AlbumList {
  AlbumList({
    required this.albums,
  });

  factory AlbumList.fromJson(List albumList) {
    return AlbumList(
      albums: albumList
          .map((i) => Album.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  final List<Album> albums;
}
