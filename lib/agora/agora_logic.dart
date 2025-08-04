import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';


enum ProductName {
  videoCalling,
  voiceCalling,
  interactiveLiveStreaming,
  broadcastStreaming
}

class AgoraManager {
  ProductName currentProduct = ProductName.voiceCalling;

  late RtcEngine agoraEngine;



}