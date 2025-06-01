import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raya_mobile/about/about_screen.dart';
import 'package:raya_mobile/bloc/radio/radio_bloc.dart';
import 'package:raya_mobile/bloc/radio/radio_events.dart';
import 'package:raya_mobile/home/home_screen.dart';
import 'package:raya_mobile/podcast/podcast_screen.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    _controller.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    super.initState();
    context.read<RadioPlayerBloc>().add(RadioPlayerInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: const [
          HomeScreen(),
          PodcastScreen(),
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
              icon: Icon(Icons.info_outlined), label: "About"),
        ],
        onTap: onItemTapped,
        currentIndex: selectedIndex,
      ),
    );
  }
}
