import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:raya_mobile/app/models/aduio_room.dart';
import 'package:raya_mobile/app/models/room_user_data.dart';
import 'package:raya_mobile/app/models/user.dart';
import 'package:raya_mobile/app/network/api_constants.dart';
import 'package:raya_mobile/repo/audio_repo.dart';
import 'package:raya_mobile/repo/users_repo.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/util/app_local_data.dart';
import 'package:raya_mobile/widget/app_fonts.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Audio extends StatefulWidget {
  const Audio({super.key});

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  late RtcEngine engine;
  List<User?> arrAudienceis = [];
  bool joined = false;
  bool isBroadcaster = true;
  bool muted = false;
  bool cameraOff = false;
  AudioRoom? config;
  String userId = '';
  String userRole = '';
  List<String> listHeader = [
    'Participants',
    'Audience',
  ];
  final UsersRepo usersRepo = UsersRepo();
  List<User?> arrParticipants = [];

  @override
  void initState() {
    super.initState();
    getSavedData();
    Timer(Duration(seconds: 1), () {
      initAgora();
    });
  }

  getSavedData() async {
    userId = await savedUserId() ?? '0';
    userRole = await savedUserRole() ?? '4';
    setState(() {});
  }

  void getUserInfo(String userId) async {
    final userInfo = await usersRepo.getUserInfo(userId);
    if (userInfo.data?.result != null) {
      final user = userInfo.data?.result;
      if (user?.role_id == '4') {
        setState(() {
          arrParticipants.add(user);
        });
      } else {
        setState(() {
          arrAudienceis.add(user);
        });
      }
    }
  }

  void removeUser(String userId) {
    for (final user in arrAudienceis) {
      if (user?.id == userId) {
        setState(() {
          arrAudienceis.remove(user);
        });
      }
    }

    for (final user in arrParticipants) {
      if (user?.id == userId) {
        setState(() {
          arrAudienceis.remove(user);
        });
      }
    }
  }

  // void getRoomParticipants() async {
  //   final roomResult = await audioRoomsRepo.getParticipantsByRoomId(config?.id ?? '1');
  //   if (roomResult.data?.result?.roomUsers != null) {
  //     setState(() {
  //       participants = roomResult.data?.result?.roomUsers ?? [];
  //     });
  //   }
  // }

  // Requests microphone permission
  Future<void> requestPermissions() async {
    await [Permission.microphone].request();
  }

  // Set up the Agora RTC engine instance
  Future<void> initializeAgoraVoiceSDK(String appId) async {
    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));
  }

  void setupEventHandlers() {
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint('Local user ${connection.localUid} joined');
          getUserInfo('${connection.localUid}');
          setState(() => joined = true);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          getUserInfo('$remoteUid');
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left");
          removeUser('$remoteUid');
        },
      ),
    );
  }

  Future<void> joinChannel(String token, String channel, int uid) async {
    await engine.joinChannel(
      token: token,
      channelId: channel,
      options: const ChannelMediaOptions(
        autoSubscribeAudio:
            true, // Automatically subscribe to all audio streams
        publishMicrophoneTrack: true, // Publish microphone-captured audio
        // Use clientRoleBroadcaster to act as a host or clientRoleAudience for audience
        clientRoleType: userRoleId == '4'
            ? ClientRoleType.clientRoleBroadcaster
            : ClientRoleType.clientRoleAudience,
      ),
      uid: uid,
    );
  }

  Future<void> initAgora() async {
    final appId = 'a2362899740a483d999ddee8b5f06e48';
    final channelName = config?.title ?? ''; //'genAITalk'; //
    final token = config?.agora_token ??
        ''; //'007eJxTYJB6ES5ytdOP8fw0mfnbFO+3Jeeds5rTVWiefTlxk7X58mIFhkQjYzMjC0tLcxODRBML4xRLS8uUlNRUiyTTNAOzVBOLLI7ZGQ2BjAwvSsVYGRkgEMTnZEhPzXP0DEnMyWZgAACP6B+p'; //
    final uid = int.parse(userId);

    await requestPermissions();
    await initializeAgoraVoiceSDK(appId);
    setupEventHandlers();
    await joinChannel(token, channelName, uid);
  }

  void onToggleMute() {
    setState(() => muted = !muted);
    engine.muteLocalAudioStream(muted);
  }

  void onToggleCamera() {
    // setState(() => cameraOff = !cameraOff);
    // engine.muteLocalVideoStream(cameraOff);
  }

  void onSwitchRole() async {
    setState(() => isBroadcaster = !isBroadcaster);
    await engine.setClientRole(
      role: isBroadcaster
          ? ClientRoleType.clientRoleBroadcaster
          : ClientRoleType.clientRoleAudience,
    );
  }

  void onLeaveChannel() async {
    await engine.leaveChannel();
    setState(() {
      joined = false;
      arrAudienceis.clear();
    });
    Navigator.pop(context);
  }

  Widget videoView(int uid, String channelName) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: engine,
        canvas: VideoCanvas(uid: uid),
        connection: RtcConnection(channelId: channelName),
      ),
    );
  }

  Widget localView() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: engine,
        canvas: VideoCanvas(uid: 0),
      ),
    );
  }

  Widget buildUserGrid() {
    final audienceList =
        arrAudienceis; // Include local user (0) // userRole == '5' ? [0, ...arrAudienceis] :
    final participantsList =
        arrParticipants; // Include local user (0) // userRole == '4' ? [0, ...arrParticipants] :
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, listIndex) {
        return StickyHeader(
          header: Container(
            height: 38.0,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.centerLeft,
            child: getAppBoldTextSizeColor(
                listHeader[listIndex], 18, AppColorPalette.appBgColor),
          ),
          content: Container(
            child: GridView.builder(
              itemCount:
                  listIndex == 0 ? arrParticipants.length : audienceList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                if (listIndex == 0) {
                  final participant = participantsList[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: getAppRegularText(participant?.name ?? '', 13),
                    ),
                  );
                } else {
                  final uid = audienceList[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: getAppRegularText(uid?.name ?? '', 13),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
      shrinkWrap: true,
    );
  }

  /*

   */

  Widget buildToolbar() {
    if (!isBroadcaster) return SizedBox.shrink();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // if(userRole == '4')...[
            //
            // ],
            FloatingActionButton(
              onPressed: onToggleMute,
              backgroundColor: muted ? Colors.red : Colors.white,
              child: Icon(
                muted ? Icons.mic_off : Icons.mic,
                color: muted ? Colors.white : Colors.black,
              ),
            ),
            FloatingActionButton(
              onPressed: onLeaveChannel,
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.call_end, color: Colors.white),
            ),
            // FloatingActionButton(
            //   onPressed: onToggleCamera,
            //   backgroundColor: cameraOff ? Colors.grey : Colors.white,
            //   child: Icon(
            //     cameraOff ? Icons.videocam_off : Icons.videocam,
            //     color: cameraOff ? Colors.white : Colors.black,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRole() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: onSwitchRole,
          child:
              Text(isBroadcaster ? 'Switch to Audience' : 'Become Broadcaster'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    engine.leaveChannel();
    engine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (config == null) {
      config = ModalRoute.of(context)?.settings.arguments as AudioRoom;
      // getRoomParticipants();
    }
    return Scaffold(
      backgroundColor: AppColorPalette.appSecondaryColor,
      appBar: AppBar(title: Text(config?.title ?? '')),
      body: (arrParticipants.isNotEmpty || arrAudienceis.isNotEmpty)
          ? Stack(
        children: [
          // getAppBoldTextSizeColor( , 16, AppColorPalette.appBgColor),
          // SizedBox(height: 20,),
          buildUserGrid(),
          buildToolbar(),
          // _buildSwitchRole(),
        ],
      ) : const Center(child: CircularProgressIndicator( color: Colors.white,)) ,
    );
  }
}
