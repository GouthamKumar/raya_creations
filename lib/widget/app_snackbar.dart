import 'package:flutter/material.dart';
import 'package:raya_mobile/widget/app_fonts.dart';

displaySnackBar(String content,BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: getAppRegularText(content,14),
  ));
}