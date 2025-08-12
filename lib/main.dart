import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raya_mobile/bloc/bottom_tab/bloc.dart';
import 'package:raya_mobile/bloc/radio/radio_bloc.dart';
import 'package:raya_mobile/navigation/routes.dart';
import 'package:raya_mobile/radio/radio_player.dart';
import 'package:raya_mobile/splash/splash_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> appInit() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('App Initilized');
      initializeDefault();
    });
  }

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp();
    print('Initialized default app $app');
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: appInit(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            const roots = RootConstants.root;
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => RadioPlayerBloc()),
                BlocProvider(create: (_) => BottomTabBloc()),
              ],
              child: MaterialApp(
                title: 'Raya',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                initialRoute: roots,
                routes: routes,
              ),
            );
          }
          return const MaterialApp(
            title: 'Raya',
            home: SplashPage(),
          );
        });
  }
}
