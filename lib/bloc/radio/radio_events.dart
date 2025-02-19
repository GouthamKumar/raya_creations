import 'package:equatable/equatable.dart';

abstract class RadioPlayerBaseEvent extends Equatable {
  const RadioPlayerBaseEvent();
}

class RadioPlayerInitEvent extends RadioPlayerBaseEvent {
  const RadioPlayerInitEvent({this.isRadioPlaying = false});
  final bool isRadioPlaying;

  @override
  List<Object?> get props => [isRadioPlaying];
}

class RadioPlayerEvent extends RadioPlayerBaseEvent {
  const RadioPlayerEvent({this.isRadioPlaying = false});
  final bool isRadioPlaying;

  @override
  List<Object?> get props => [isRadioPlaying];
}
