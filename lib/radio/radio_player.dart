import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_player/radio_player.dart';

final RadioPlayer _radioPlayer = RadioPlayer();

initRadioPlayer() async {
  _radioPlayer.setChannel(
    title: 'Radio Player',
    url: 'https://s3.radio.co/s162c52c51/listen',
    imagePath: 'https://rayacreations.com/raya_logo.png',
  );
}

RadioPlayer getRadioHandler() {
  return _radioPlayer;
}

final AudioPlayer _audioPlayer = AudioPlayer();

initAudioPlayer(List<AudioSource> audioSources) async {
  await _audioPlayer.setAudioSources(
    audioSources, initialIndex: 0, initialPosition: Duration.zero,
    shuffleOrder: DefaultShuffleOrder(), // Customise the shuffle algorithm
  );
}

AudioPlayer getAudioHandler() {
  return _audioPlayer;
}
