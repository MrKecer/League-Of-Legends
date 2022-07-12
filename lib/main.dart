import 'package:flutter/material.dart';
import 'package:leagueoflegends/screens/character.dart';

import 'models/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeClass.darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'League of Legends',
      home: character(),
    );
  }
}
