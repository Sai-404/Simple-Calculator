import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

setLightTheme() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFF9F9F9),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

setDarkTheme() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xFF22252D),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF2A2D37),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}
