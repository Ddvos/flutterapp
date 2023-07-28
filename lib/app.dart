import 'package:flutter/material.dart';
import 'screens/homescreen/homescreen.dart';
import 'style.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home screen',
      home: const HomeScreen(),
      theme: appTheme,
    );
  }
}
