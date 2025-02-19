import 'package:flutter/material.dart';
import 'package:raya_mobile/about/about_screen.dart';
import 'package:raya_mobile/app_dashboard/dashboard.dart';
import 'package:raya_mobile/home/home_screen.dart';

class RootConstants {
  static const String root = "/";
  static const String home = "/home";
  static const String about = '/about';
}

Map<String, WidgetBuilder> routes = {
  RootConstants.root: (_) => DashboardScreen(),
  RootConstants.home: (_) => HomeScreen(),
  RootConstants.about: (_) => AboutScreen(),
};
