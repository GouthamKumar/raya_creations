import 'package:flutter/material.dart';
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
