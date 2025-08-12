import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:raya_mobile/app/models/aduio_room.dart';
import 'package:raya_mobile/util/app_local_data.dart';

class Audio extends StatefulWidget {
  const Audio({super.key});

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  late RtcEngine engine;
  List<int> remoteUids = [];
  bool joined = false;
  bool isBroadcaster = true;
  bool muted = false;
  bool cameraOff = false;
  AudioRoom? config;
  String userId = '';


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
  }

  // Requests microphone permission
  Future<void> requestPermissions() async {
    await [Permission.microphone].request();
  }

  // Set up the Agora RTC engine instance
  Future<void> initializeAgoraVoiceSDK(String appId) async {
    engine = createAgoraRtcEngine();
    await engine.initialize( RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));
  }

  void setupEventHandlers() {
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint('Local user ${connection.localUid} joined');
          setState(() => joined = true);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          setState(() => remoteUids.add(remoteUid));
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left");
          setState(() => remoteUids.remove(remoteUid));
        },
      ),
    );
  }

  Future<void> joinChannel(String token, String channel, int uid) async {
    await engine.joinChannel(
      token: token,
      channelId: channel,
      options: const ChannelMediaOptions(
        autoSubscribeAudio: true, // Automatically subscribe to all audio streams
        publishMicrophoneTrack: true, // Publish microphone-captured audio
        // Use clientRoleBroadcaster to act as a host or clientRoleAudience for audience
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
      uid: uid,
    );
  }

  Future<void> initAgora() async {
    final appId = 'a2362899740a483d999ddee8b5f06e48';
    final channelName = config?.title ?? ''; //'genAITalk'; //
    final token = config?.agora_token ?? ''; //'007eJxTYJB6ES5ytdOP8fw0mfnbFO+3Jeeds5rTVWiefTlxk7X58mIFhkQjYzMjC0tLcxODRBML4xRLS8uUlNRUiyTTNAOzVBOLLI7ZGQ2BjAwvSsVYGRkgEMTnZEhPzXP0DEnMyWZgAACP6B+p'; //
    final uid = int.parse(userId);

    await requestPermissions();
    await initializeAgoraVoiceSDK(appId);
    setupEventHandlers();
    await joinChannel(token, channelName, uid);

    //
    // engine = createAgoraRtcEngine();
    // await engine.initialize(RtcEngineContext(appId: appId, channelProfile: ChannelProfileType.channelProfileCommunication));
    //
    // engine.registerEventHandler(RtcEngineEventHandler(
    //   onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
    //     print('Local user ${connection.localUid} joined');
    //     setState(() => joined = true);
    //   },
    //   onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
    //
    //   },
    //   onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
    //
    //   },
    // ));
    //
    // await engine.setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
    // await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    //
    // await engine.enableVideo();
    //
    // await engine.joinChannel(
    //   token: token,
    //   channelId: channelName,
    //   uid: uid,
    //   options: const ChannelMediaOptions(
    //       autoSubscribeVideo: false,
    //       autoSubscribeAudio: true,
    //       publishCameraTrack: false,
    //       publishMicrophoneTrack: true,
    //       clientRoleType: ClientRoleType.clientRoleBroadcaster,
    //       audienceLatencyLevel:
    //       AudienceLatencyLevelType.audienceLatencyLevelUltraLowLatency),
    // );
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
      role: isBroadcaster ? ClientRoleType.clientRoleBroadcaster : ClientRoleType.clientRoleAudience,
    );
  }

  void onLeaveChannel() async {
    await engine.leaveChannel();
    setState(() {
      joined = false;
      remoteUids.clear();
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

  // Widget _buildVideoGrid() {
  //   final views = <Widget>[];
  //   if (_isBroadcaster && _joined) views.add(_localView());
  //   for (var uid in _remoteUids) {
  //     views.add(_videoView(uid));
  //   }
  //
  //   return GridView.builder(
  //     itemCount: views.length,
  //     padding: EdgeInsets.all(8),
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: views.length <= 2 ? 1 : 2,
  //       mainAxisSpacing: 8,
  //       crossAxisSpacing: 8,
  //     ),
  //     itemBuilder: (context, index) => Container(
  //       decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
  //       child: views[index],
  //     ),
  //   );
  // }

  Widget buildUserGrid() {
    final users = [0, ...remoteUids]; // Include local user (0)
    return GridView.builder(
      itemCount: users.length,
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final uid = users[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              uid == 0 ? 'You' : 'User $uid',
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      },
    );
  }

  Widget buildToolbar() {
    if (!isBroadcaster) return SizedBox.shrink();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
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
          child: Text(isBroadcaster ? 'Switch to Audience' : 'Become Broadcaster'),
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
    }
    return Scaffold(
      appBar: AppBar(title: Text('Agora Group Live Stream')),
      body: Stack(
        children: [
          buildUserGrid(),
          buildToolbar(),
          // _buildSwitchRole(),
        ],
      ),
    );
  }
}
