import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'day_planner_screen.dart';

class ItineraryScreen extends StatelessWidget {
  final Trip trip;

  ItineraryScreen({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Itinerary: ${trip.name}'),
      ),
      body: ListView.builder(
        itemCount: trip.endDate.difference(trip.startDate).inDays + 1,
        itemBuilder: (context, index) {
          final currentDate = trip.startDate.add(Duration(days: index));
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                  'Day ${index + 1}: ${currentDate.toString().substring(0, 10)}'),
              subtitle: Text('Tap to plan activities'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DayPlannerScreen(
                      trip: trip,
                      day: currentDate,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
