import 'package:flutter/material.dart';
import 'package:travel_planner/screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(TravelPlannerApp());
}

class TravelPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Planner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: SplashScreen(),
    );
  }
}
