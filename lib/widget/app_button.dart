

import 'package:flutter/material.dart';

IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
  icon: Icon(iconData),
  iconSize: 64.0,
  onPressed: onPressed,
);