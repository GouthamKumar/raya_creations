import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum BottomTab {
  radio,
  podcast,
  audioRooms,
  account
}

@immutable
abstract class BottomTabBaseState extends Equatable {
  const BottomTabBaseState();

  @override
  List<Object> get props => [];
}

class BottomTabInitState extends BottomTabBaseState {
  const BottomTabInitState();
  @override
  List<Object> get props => [];
}

class BottomTabChangeState extends BottomTabBaseState {
  const BottomTabChangeState(this.tab);

  final BottomTab tab;

  @override
  List<Object> get props => [tab];
}