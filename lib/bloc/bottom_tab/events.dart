
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raya_mobile/bloc/bottom_tab/states.dart';

@immutable
abstract class BottomTabBaseEvent extends Equatable {
  const BottomTabBaseEvent();
}

class BottomTabChangeEvent extends BottomTabBaseEvent {
  const BottomTabChangeEvent({this.tab = BottomTab.radio});
  final BottomTab tab;
  @override
  List<Object> get props => [tab];
}