import 'package:flutter/material.dart';
import 'package:travel_planner/screens/day_planner_screen.dart';
import '../models/trip.dart';

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
            child: ListTile(
              title: Text(
                  'Day ${index + 1}: ${currentDate.toString().substring(0, 10)}'),
              subtitle: Text('Tap to add activities'),
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
