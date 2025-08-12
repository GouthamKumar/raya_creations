

import 'package:flutter/material.dart';
import 'package:raya_mobile/app/models/user.dart';
import 'package:raya_mobile/app_dashboard/dashboard.dart';
import 'package:raya_mobile/util/app_local_data.dart';

String reverseStringUsingCodeUnits(String input) {
  return String.fromCharCodes(input.codeUnits.reversed);
}

saveUser(User user) {
  saveUserDetails(user);
  loginStatus(GlobalValues.GLOBAL_CONST_YES);
}

final PageController pageController = PageController(
  initialPage: 0,
);
int selectedIndex = 0;