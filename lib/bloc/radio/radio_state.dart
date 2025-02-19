// class RadioPlayerBloc extends<RadioPlayerEvent>
import 'package:equatable/equatable.dart';
import 'package:radio_player/radio_player.dart';

abstract class RadioPlayerBaseState extends Equatable {
  const RadioPlayerBaseState(this.isRadioPlaying, this.metadata);
  final bool isRadioPlaying;
  final List<String>? metadata;
  @override
  List<Object> get props => [isRadioPlaying, metadata ?? []];
}

class RadioPlayerInitState extends RadioPlayerBaseState {
  RadioPlayerInitState(
      {bool isRadioPlaying = false,
      RadioPlayer? radioPlayer,
      List<String>? metadata = const []})
      : super(isRadioPlaying, metadata ?? []);

  List<Object> get props => [isRadioPlaying];
}

class RadioPlayerState extends RadioPlayerBaseState {
  RadioPlayerState(
      {bool isRadioPlaying = false, List<String>? metadata = const []})
      : super(isRadioPlaying, metadata ?? []);
}
