import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raya_mobile/bloc/radio/radio_bloc.dart';
import 'package:raya_mobile/bloc/radio/radio_events.dart';

void handleRadioPlay_Stop(BuildContext context) {
  context.read<RadioPlayerBloc>().add(RadioPlayerEvent());
}

void handleMusicPlayAndStop(BuildContext context, bool isMusicPlaying,
    int selectedSong, String selectedAlbum) {
  context.read<RadioPlayerBloc>().add(MusicPlayerEvent(
      isMusicPlaying: isMusicPlaying,
      selectedSong: selectedSong,
      selectedAlbum: selectedAlbum));
}
