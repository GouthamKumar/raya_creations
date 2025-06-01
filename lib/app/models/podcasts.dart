import 'package:raya_mobile/app/models/podcast.dart';

class Podcasts {
  Podcasts({
    required this.status,
    required this.message,
    required this.arrPodcasts,
  });

  factory Podcasts.fromJson(Map<String, dynamic> json){
    return Podcasts(
      status: json['status'],
      message: json['message'],
      arrPodcasts: PodcastList.fromJson((json['result']) as List).podcasts,
    );
  }

  final bool status;
  final String message;
  final List<Podcast> arrPodcasts;

}