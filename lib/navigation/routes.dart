import 'package:flutter/material.dart';
import 'package:raya_mobile/AudioRooms/audio_rooms.dart';
import 'package:raya_mobile/about/about_screen.dart';
import 'package:raya_mobile/album_details/album_details.dart';
import 'package:raya_mobile/app_dashboard/dashboard.dart';
import 'package:raya_mobile/audio/audio.dart';
import 'package:raya_mobile/home/home_screen.dart';
import 'package:raya_mobile/podcast/podcast_screen.dart';

class RootConstants {
  static const String root = "/";
  static const String home = "/home";
  static const String about = '/about';
  static const String podcast = '/podcast';
  static const String albumDetails = '/albumDetails';
  static  const String audio = '/audio';
  static const String audioRooms = '/audioRooms';
}

Map<String, WidgetBuilder> routes = {
  RootConstants.root: (_) => DashboardScreen(),
  RootConstants.home: (_) => HomeScreen(),
  RootConstants.about: (_) => AboutScreen(),
  RootConstants.podcast: (_) => PodcastScreen(),
  RootConstants.albumDetails: (_) => AlbumDetailsScreen(),
  RootConstants.audio: (_) => Audio(),
  RootConstants.audioRooms: (_) => AudioRooms(),
};
