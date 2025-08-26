import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raya_mobile/bloc/bottom_tab/bloc.dart';
import 'package:raya_mobile/bloc/bottom_tab/events.dart';
import 'package:raya_mobile/bloc/bottom_tab/states.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorPalette.appSecondaryColor,
      body: Center(
        child: FittedBox(
          fit: BoxFit.fill,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  100.0), // Set corner radius to 10.0
              color:
              AppColorPalette.appSecondaryColor, // Set background color
            ),
            child: Image.asset(
              "images/raya_logo.png",
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
