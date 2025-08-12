import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raya_mobile/bloc/bottom_tab/bloc.dart';
import 'package:raya_mobile/bloc/bottom_tab/events.dart';
import 'package:raya_mobile/bloc/bottom_tab/states.dart';

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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Image.asset("images/raya_logo.png"),
      ),
    );
  }
}
