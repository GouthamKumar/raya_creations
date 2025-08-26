import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raya_mobile/bloc/radio/radio_bloc.dart';
import 'package:raya_mobile/bloc/radio/radio_events.dart';
import 'package:raya_mobile/bloc/radio/radio_state.dart';
import 'package:raya_mobile/radio/radio_player.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/util/radioplayer_bloc_utils.dart';
import 'package:raya_mobile/util/visualizer.dart';
import 'package:raya_mobile/widget/app_divider.dart';
// import 'package:raya_mobile/widget/app_divider.dart';
import 'package:raya_mobile/widget/app_fonts.dart';
import 'package:raya_mobile/widget/banner_item.dart';
// import 'package:raya_mobile/widget/banner_item.dart';
// import 'package:raya_mobile/widget/shimmer_basic.dart';
import 'package:radio_player/radio_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String>? metadata;

  @override
  void initState() {
    super.initState();
    print("Hello HomeScreen init");
  }

  void handleRadioPlayer() {
    initRadioPlayer();
    getRadioHandler().stateStream.listen((value) {
      print("Value is $value");
    });

    // getRadioHandler().metadataStream.listen((value) {
    //   setState(() {
    //     metadata = value;
    //   });
    // });
  }

  String getSingers() {
    if (metadata != null) {
      return metadata?[0] ?? '';
    } else {
      return '';
    }
  }

  String getSongName() {
    if (metadata != null) {
      return metadata?[1] ?? 'Raya Radio';
    } else {
      return 'Raya Radio';
    }
  }

  void stopAudioPlayer() {
    getAudioHandler().stop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RadioPlayerBloc, RadioPlayerBaseState>(
      listener: (context, state) {
        if (state is RadioPlayerInitState) {
          handleRadioPlayer();
        }
        if (state is RadioPlayerState) {
          print("Hello Player");
        }
      },
      child: BlocBuilder<RadioPlayerBloc, RadioPlayerBaseState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColorPalette.appSecondaryColor,
            appBar: AppBar(
              backgroundColor: AppColorPalette.appSecondaryColor,
              title: Image.asset(
                'images/appbar_logo_white.png',
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    getVerticalDivider(10),
                    BannerItem(),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black45,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            'images/radio.png',
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          if (state.isRadioPlaying)
                            SizedBox(
                              width: 200,
                              child: MiniMusicVisualizer(
                                color: AppColorPalette.appPrimary,
                                width: 4,
                                height: 70,
                                radius: 2,
                                animate: true,
                                barCount: 30,
                                shadows: [
                                  BoxShadow(color: AppColorPalette.appPrimary),
                                  BoxShadow(
                                      color: AppColorPalette.appSecondaryColor),
                                ],
                              ),
                            ),
                          _button(
                              state.isRadioPlaying
                                  ? Icons.stop_circle_outlined
                                  : Icons.play_circle_outline_outlined,
                              () => playButtonHandler(state)),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    getAppBoldTextSizeColor(
                        'Radio Schedule', 18, AppColorPalette.appBgColor),
                    SizedBox(
                      height: 8,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'images/radio_banner.png',
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void playButtonHandler(RadioPlayerBaseState state) {
    print("playButtonHandler ${state.isRadioPlaying}");
    getRadioHandler().play;
    state.isRadioPlaying == true
        ? getRadioHandler().pause()
        : getRadioHandler().play();
    handleRadioPlay_Stop(context);
    stopAudioPlayer();
  }

  IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
        icon: Icon(
          iconData,
          color: AppColorPalette.appPrimary,
        ),
        iconSize: 70.0,
        onPressed: onPressed,
      );
}
