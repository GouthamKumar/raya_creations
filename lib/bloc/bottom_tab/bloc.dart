import 'package:bloc/bloc.dart';
import 'package:raya_mobile/bloc/bottom_tab/events.dart';
import 'package:raya_mobile/bloc/bottom_tab/states.dart';

class BottomTabBloc extends Bloc<BottomTabBaseEvent, BottomTabBaseState> {
  BottomTabBloc() : super(const BottomTabInitState()) {
    on<BottomTabChangeEvent>(changeTab);
    }

  Future<void> changeTab(BottomTabChangeEvent event, Emitter<BottomTabBaseState> emit)  async {
    emit(const BottomTabInitState());
    emit(BottomTabChangeState(event.tab));
  }
}