import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

// const String appId = "a2362899740a483d999ddee8b5f06e48";
// const String channelName = "leadersTalk";
// const String token =
//     "007eJxTYLDXYd2ZED/JNWzF26Kg75veatmuSq/7vVV6WlL37t/bjc4qMCQaGZsZWVhampsYJJpYGKdYWlqmpKSmWiSZphmYpZpYCLfmZDQEMjJ4TlvHzMgAgSA+N0NOamJKalFxSGJONgMDAFkhIpA="; // Leave blank if not using token
// const int uid = 0; // 0 means auto-generated

class Audio extends StatefulWidget {
  const Audio({super.key});

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  // int? _remoteUid; // Stores remote user ID
  // bool _localUserJoined =
  //     false; // Indicates if local user has joined the channel
  // late RtcEngine _engine; // Stores Agora RTC Engine instance
  // @override
  // void initState() {
  //   super.initState();
  //   _startLiveStreaming();
  // }
  //
  // // Initializes Agora SDK
  // Future<void> _startLiveStreaming() async {
  //   await _requestPermissions();
  //   await _initializeAgoraVideoSDK();
  //   await _setupLocalVideo();
  //   _setupEventHandlers();
  //   await _joinChannel();
  // }
  //
  // // Requests microphone and camera permissions
  // Future<void> _requestPermissions() async {
  //   await [Permission.microphone, Permission.camera].request();
  // }
  //
  // // Set up the Agora RTC engine instance
  // Future<void> _initializeAgoraVideoSDK() async {
  //   _engine = createAgoraRtcEngine();
  //   await _engine.initialize(const RtcEngineContext(
  //     appId: appId,
  //     channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
  //   ));
  // }
  //
  // // Enables and starts local video preview
  // Future<void> _setupLocalVideo() async {
  //   await _engine.enableVideo();
  //   await _engine.startPreview();
  // }
  //
  // // Register an event handler for Agora RTC
  // void _setupEventHandlers() {
  //   _engine.registerEventHandler(
  //     RtcEngineEventHandler(
  //       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
  //         debugPrint("Local user ${connection.localUid} joined");
  //         setState(() => _localUserJoined = true);
  //       },
  //       onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
  //         debugPrint("Remote user $remoteUid joined");
  //         setState(() => _remoteUid = remoteUid);
  //       },
  //       onUserOffline: (RtcConnection connection, int remoteUid,
  //           UserOfflineReasonType reason) {
  //         debugPrint("Remote user $remoteUid left ");
  //         setState(() => _remoteUid = null);
  //       },
  //     ),
  //   );
  // }
  //
  // // Join a channel
  // Future<void> _joinChannel() async {
  //   await _engine.joinChannel(
  //     token: token,
  //     channelId: channelName,
  //     options: const ChannelMediaOptions(
  //         autoSubscribeVideo: true,
  //         autoSubscribeAudio: true,
  //         publishCameraTrack: true,
  //         publishMicrophoneTrack: true,
  //         clientRoleType: ClientRoleType.clientRoleBroadcaster,
  //         audienceLatencyLevel:
  //             AudienceLatencyLevelType.audienceLatencyLevelUltraLowLatency),
  //     uid: uid,
  //   );
  // }
  //
  // @override
  // void dispose() {
  //   _cleanupAgoraEngine();
  //   super.dispose();
  // }
  //
  // // Leaves the channel and releases resources
  // Future<void> _cleanupAgoraEngine() async {
  //   await _engine.leaveChannel();
  //   await _engine.release();
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Agora Interactive Live Streaming')),
  //     body: Stack(
  //       children: [
  //         Center(child: _remoteVideo()),
  //         Align(
  //           alignment: Alignment.topLeft,
  //           child: SizedBox(
  //             width: 100,
  //             height: 150,
  //             child: Center(
  //               child: _localUserJoined
  //                   ? _localVideo()
  //                   : const CircularProgressIndicator(),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // // Displays remote video view
  // Widget _localVideo() {
  //   return AgoraVideoView(
  //     controller: VideoViewController(
  //       rtcEngine: _engine,
  //       canvas: const VideoCanvas(
  //         uid: 0,
  //         renderMode: RenderModeType.renderModeHidden,
  //       ),
  //     ),
  //   );
  // }
  //
  // // Displays remote video view
  // Widget _remoteVideo() {
  //   if (_remoteUid != null) {
  //     return AgoraVideoView(
  //       controller: VideoViewController.remote(
  //         rtcEngine: _engine,
  //         canvas: VideoCanvas(uid: _remoteUid),
  //         connection: const RtcConnection(channelId: channelName),
  //       ),
  //     );
  //   } else {
  //     return const Text(
  //       'Waiting for remote user to join...',
  //       textAlign: TextAlign.center,
  //     );
  //   }
  // }



  late RtcEngine engine;
  List<int> remoteUids = [];
  bool joined = false;
  bool isBroadcaster = true;
  bool muted = false;
  bool cameraOff = false;
  Map<String, dynamic> config = {};


  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      initAgora();
    });

  }

  Future<void> initAgora() async {
    final appId = config['appId'];
    final channelName = config['channelName'];
    final token = config['rtcToken'];
    final uid = config['uid'] as int? ?? 0;
    await [Permission.microphone, Permission.camera].request();

    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(appId: appId));

    engine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        print('Local user ${connection.localUid} joined');
        setState(() => joined = true);
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        setState(() => remoteUids.add(remoteUid));
      },
      onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
        setState(() => remoteUids.remove(remoteUid));
      },
    ));

    await engine.setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await engine.enableVideo();

    await engine.joinChannel(
      token: token,
      channelId: channelName,
      uid: uid,
      options: const ChannelMediaOptions(
          autoSubscribeVideo: false,
          autoSubscribeAudio: true,
          publishCameraTrack: false,
          publishMicrophoneTrack: true,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          audienceLatencyLevel:
          AudienceLatencyLevelType.audienceLatencyLevelUltraLowLatency),
    );
  }

  void onToggleMute() {
    setState(() => muted = !muted);
    engine.muteLocalAudioStream(muted);
  }

  void onToggleCamera() {
    setState(() => cameraOff = !cameraOff);
    engine.muteLocalVideoStream(cameraOff);
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
        padding: const EdgeInsets.only(bottom: 24.0),
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
            FloatingActionButton(
              onPressed: onToggleCamera,
              backgroundColor: cameraOff ? Colors.grey : Colors.white,
              child: Icon(
                cameraOff ? Icons.videocam_off : Icons.videocam,
                color: cameraOff ? Colors.white : Colors.black,
              ),
            ),
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
    if (config.isEmpty) {
      config = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
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
