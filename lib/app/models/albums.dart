import 'package:raya_mobile/app/models/album.dart';

class Albums {
  Albums({
    required this.status,
    required this.message,
    required this.arrAlbum,
  });

  factory Albums.fromJson(Map<String, dynamic> json){
    return Albums(
      status: json['status'],
      message: json['message'],
      arrAlbum: AlbumList.fromJson((json['result']) as List).albums,
    );
  }

  final bool status;
  final String message;
  final List<Album> arrAlbum;

  String toJson() {
    return '{"Albums:" ${arrAlbum.map((album) => album.toJson()).toList()} "message": $message }';
  }
}
