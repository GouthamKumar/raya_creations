class Podcast {
  Podcast({
    required this.podcastInfo,
    required this.podcastTags,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      podcastInfo: PodcastInfo.fromJson(json['info']),
      podcastTags: (json['tags'] as List)
          .map((i) => PodcastTags.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  final PodcastInfo podcastInfo;
  final List<PodcastTags> podcastTags;
}

class PodcastInfo {
  PodcastInfo({
    required this.id,
    required this.albumId,
    required this.name,
    required this.description,
    required this.languageId,
    required this.podcastUrl,
    required this.status,
    required this.imagePath,
    required this.languageName,
  });

  factory PodcastInfo.fromJson(Map<String, dynamic> json) {
    return PodcastInfo(
      id: json['id'],
      albumId: json['album_id'],
      name: json['name'],
      description: json['description'],
      languageId: json['language_id'],
      podcastUrl: json['poadcast_url'],
      status: json['status'],
      imagePath: json['image_path'],
      languageName: json['languageName'],
    );
  }

  final String id;
  final String albumId;
  final String name;
  final String? description;
  final String? languageId;
  final String? podcastUrl;
  final String status;
  final String? imagePath;
  final String? languageName;

  String toJson() {
    return '{"id": $id, "albumId": $albumId, "name": $name, "description": $description, "languageId": $languageId, "podcastUrl": $podcastUrl, "status": $status, "imagePath": $imagePath, "languageName": $languageName}';
  }
}

class PodcastTags {
  PodcastTags({
    required this.id,
    required this.name,
  });

  factory PodcastTags.fromJson(Map<String, dynamic> json) {
    return PodcastTags(
      id: json['id'],
      name: json['name'],
    );
  }
  final String name;
  final String id;
}


class PodcastList {
  PodcastList({
    required this.podcasts,
  });

  factory PodcastList.fromJson(List podcastList) {
    return PodcastList(
      podcasts: podcastList
          .map((i) => Podcast.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
  final List<Podcast> podcasts;
}