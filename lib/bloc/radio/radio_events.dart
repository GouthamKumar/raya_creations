import 'package:equatable/equatable.dart';

abstract class RadioPlayerBaseEvent extends Equatable {
  const RadioPlayerBaseEvent();
}

class RadioPlayerInitEvent extends RadioPlayerBaseEvent {
  const RadioPlayerInitEvent(
      {this.isRadioPlaying = false, this.isMusicPlaying = false});
  final bool isRadioPlaying;
  final bool isMusicPlaying;

  @override
  List<Object?> get props => [isRadioPlaying, isMusicPlaying];
}

class RadioPlayerEvent extends RadioPlayerBaseEvent {
  const RadioPlayerEvent(
      {this.isRadioPlaying = false, this.isMusicPlaying = false});
  final bool isRadioPlaying;
  final bool isMusicPlaying;

  @override
  List<Object?> get props => [isRadioPlaying, isMusicPlaying];
}

class MusicPlayerEvent extends RadioPlayerBaseEvent {
  const MusicPlayerEvent(
      {this.isRadioPlaying = false,
      required this.isMusicPlaying,
      required this.selectedSong,
      required this.selectedAlbum});
  final bool isRadioPlaying;
  final bool isMusicPlaying;
  final int selectedSong;
  final String selectedAlbum;

  @override
  List<Object?> get props =>
      [isRadioPlaying, isMusicPlaying, selectedSong, selectedAlbum];
}
