import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(TravelPlannerApp());
}

class TravelPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 14.0),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
