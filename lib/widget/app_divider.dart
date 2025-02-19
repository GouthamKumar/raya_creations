import 'package:flutter/material.dart';

Widget getVerticalDividerSmall() {
  return const SizedBox(
    height: 5,
  );
}

Widget getVerticalDividerMedium() {
  return const SizedBox(
    height: 10,
  );
}

Widget getVerticalDividerLarge() {
  return const SizedBox(
    height: 20,
  );
}

Widget getVerticalDivider(double requiredHeight) {
  return SizedBox(
    height: requiredHeight,
  );
}

Widget getDividerLine(double requiredHeight) {
  return SizedBox(
    height: requiredHeight,

  );
}

Widget getDividerCustom(double requiredHeight,double requiredWidth) {
  return SizedBox(
    height: requiredHeight,
    width: requiredWidth,
  );
}

