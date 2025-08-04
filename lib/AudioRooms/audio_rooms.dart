

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raya_mobile/AudioRooms/widgets/audio_room_row.dart';
import 'package:raya_mobile/widget/app_fonts.dart';

class AudioRooms extends StatefulWidget {
  const AudioRooms({super.key});

  @override
  State<AudioRooms> createState() => _AudioRoomsState();
}

class _AudioRoomsState extends State<AudioRooms> {
  List audioRooms = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    try {
      String configString =
      await rootBundle.loadString('assets/config/config.json');
      final configs = jsonDecode(configString);
      setState(() {
        for(final config in configs) {
          audioRooms.add(config);
        }
      });
    } catch (e) {
      print('No Rooms');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getAppBoldTextSize('Audio Rooms', 22),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: audioRooms.length,
          itemBuilder: (context, index) {
            return AudioRoomRow(config: audioRooms[index]);
          },
          // children: [
          //   AudioRoomRow(),
          // ],
        ),
      ),
    );
  }
}
