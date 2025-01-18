import 'package:flutter/material.dart';
import '../models/trip.dart';

class BudgetScreen extends StatelessWidget {
  final Trip trip;

  BudgetScreen({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget: ${trip.name}'),
      ),
      body: Center(
        child: Text('Budget tracker coming soon!'),
      ),
    );
  }
}
