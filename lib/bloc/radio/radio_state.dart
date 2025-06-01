// class RadioPlayerBloc extends<RadioPlayerEvent>
import 'package:equatable/equatable.dart';
import 'package:radio_player/radio_player.dart';

abstract class RadioPlayerBaseState extends Equatable {
  const RadioPlayerBaseState(this.isRadioPlaying, this.isMusicPlaying,
      this.selectedSong, this.selectedAlbum, this.metadata);
  final bool isRadioPlaying;
  final bool isMusicPlaying;
  final int selectedSong;
  final String selectedAlbum;
  final List<String>? metadata;
  @override
  List<Object> get props => [
        isRadioPlaying,
        isMusicPlaying,
        selectedSong,
        selectedAlbum,
        metadata ?? []
      ];
}

class RadioPlayerInitState extends RadioPlayerBaseState {
  RadioPlayerInitState(
      {bool isRadioPlaying = false,
      bool isMusicPlaying = false,
      RadioPlayer? radioPlayer,
      int selectedSong = 0,
      String selectedAlbum = '',
      List<String>? metadata = const []})
      : super(isRadioPlaying, isMusicPlaying, selectedSong, selectedAlbum,
            metadata ?? []);

  @override
  List<Object> get props => [
        isRadioPlaying,
        isMusicPlaying,
        selectedSong,
        selectedAlbum,
        metadata ?? []
      ];
}

class RadioPlayerState extends RadioPlayerBaseState {
  RadioPlayerState(
      {bool isRadioPlaying = false,
      bool isMusicPlaying = false,
      int selectedSong = 0,
      String selectedAlbum = '',
      List<String>? metadata = const []})
      : super(isRadioPlaying, isMusicPlaying, selectedSong, selectedAlbum,
            metadata ?? []);

  @override
  List<Object> get props => [
        isRadioPlaying,
        isMusicPlaying,
        selectedSong,
        selectedAlbum,
        metadata ?? []
      ];
}
