import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raya_mobile/AudioRooms/widgets/audio_room_row.dart';
import 'package:raya_mobile/app/models/aduio_room.dart';
import 'package:raya_mobile/repo/audio_repo.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/widget/app_fonts.dart';

class AudioRooms extends StatefulWidget {
  const AudioRooms({super.key});

  @override
  State<AudioRooms> createState() => _AudioRoomsState();
}

class _AudioRoomsState extends State<AudioRooms> {
  List<AudioRoom?> audioRooms = [];
  final AudioRoomsRepo audioRoomsRepo = AudioRoomsRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    final roomResult = await audioRoomsRepo.getAudioRooms();
    if (roomResult.data?.room != null) {
      setState(() {
        audioRooms = roomResult.data?.room ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorPalette.appSecondaryColor,
      appBar: AppBar(
        backgroundColor: AppColorPalette.appSecondaryColor,
        title: Image.asset(
          'images/appbar_logo_white.png',
          fit: BoxFit.fill,
        ),
      ),
      body: Container(
        child: audioRooms.isNotEmpty ?
        ListView.builder(
          itemCount: audioRooms.length,
          itemBuilder: (context, index) {
            return AudioRoomRow(config: audioRooms[index]!);
          },
          // children: [
          //   AudioRoomRow(),
          // ],
        ) : const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
