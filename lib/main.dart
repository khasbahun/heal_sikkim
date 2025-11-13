import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';

void main() => runApp(HealSikkimApp());

class HealSikkimApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heal Sikkim Physiotherapy Clinic',
      theme: ThemeData(
        primaryColor: Brand.primary,
        scaffoldBackgroundColor: Brand.bg,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(backgroundColor: Brand.primary, elevation: 0),
      ),
      home: HomeScreen(),
    );
  }
}