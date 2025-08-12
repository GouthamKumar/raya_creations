import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raya_mobile/AudioRooms/audio_rooms.dart';
import 'package:raya_mobile/about/about_screen.dart';
import 'package:raya_mobile/audio/audio.dart';
import 'package:raya_mobile/bloc/bottom_tab/bloc.dart';
import 'package:raya_mobile/bloc/bottom_tab/states.dart';
import 'package:raya_mobile/bloc/radio/radio_bloc.dart';
import 'package:raya_mobile/bloc/radio/radio_events.dart';
import 'package:raya_mobile/home/home_screen.dart';
import 'package:raya_mobile/podcast/podcast_screen.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';
import 'package:raya_mobile/util/utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    super.initState();
    context.read<RadioPlayerBloc>().add(RadioPlayerInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomTabBloc, BottomTabBaseState>(
      listener: (context, state) {
        if (state is BottomTabChangeState) {
          setState(() {
            selectedIndex = state.tab.index;
            pageController.jumpToPage(selectedIndex);
          });
        }
      },
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            HomeScreen(),
            PodcastScreen(),
            AudioRooms(),
            AboutScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColorPalette.appSecondaryColor,
          selectedItemColor: AppColorPalette.appBarColor,
          unselectedItemColor: AppColorPalette.appColorWhite,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.radio_outlined), label: "Radio"),
            BottomNavigationBarItem(
                icon: Icon(Icons.podcasts_outlined), label: "Podcast"),
            BottomNavigationBarItem(
                icon: Icon(Icons.mic_external_on_outlined),
                label: "Audio Rooms"),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle_outlined),
                label: "Account"),
          ],
          onTap: onItemTapped,
          currentIndex: selectedIndex,
        ),
      ),
    );
  }
}
