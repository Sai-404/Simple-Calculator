import 'package:Calculator/pages/home.dart';
import 'package:Calculator/services/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModal(),
      child: Consumer(builder: (context, ThemeModal themeModal, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Home(),
        );
      }),
    );
  }
}
