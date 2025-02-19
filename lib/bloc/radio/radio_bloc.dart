import 'package:bloc/bloc.dart';
import 'package:radio_player/radio_player.dart';
import 'package:raya_mobile/bloc/radio/radio_events.dart';
import 'package:raya_mobile/bloc/radio/radio_state.dart';
import 'package:raya_mobile/radio/radio_player.dart';

class RadioPlayerBloc extends Bloc<RadioPlayerBaseEvent, RadioPlayerBaseState> {
  RadioPlayerBloc() : super(RadioPlayerInitState()) {
    on<RadioPlayerInitEvent>(initRadio);
    on<RadioPlayerEvent>(playRadio);
  }

  Future<void> initRadio(
      RadioPlayerBaseEvent event, Emitter<RadioPlayerBaseState> emit) async {
    emit(RadioPlayerInitState());
  }

  Future<void> playRadio(
      RadioPlayerBaseEvent event, Emitter<RadioPlayerBaseState> emit) async {
    emit(RadioPlayerState(
        isRadioPlaying: !state.isRadioPlaying, metadata: null));
    // listenServices(emit);
  }

  void listenServices(Emitter<RadioPlayerBaseState> emit) {}
}
