import 'package:flutter/material.dart';
import 'package:travel_planner/screens/add_trip_screen.dart';
import 'package:travel_planner/screens/edit_trip_screen.dart';
import '../models/trip.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Trip> trips = [
    Trip(
      name: 'Paris Getaway',
      startDate: DateTime(2023, 7, 1),
      endDate: DateTime(2023, 7, 7),
      imageUrl:
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=1000&q=80',
    ),
    Trip(
      name: 'Tokyo Adventure',
      startDate: DateTime(2023, 8, 15),
      endDate: DateTime(2023, 8, 25),
      imageUrl:
          'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=1000&q=80',
    ),
  ];

  void _addNewTrip() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTripScreen()),
    );

    if (result != null && result is Trip) {
      setState(() {
        trips.add(result);
      });
    }
  }

  _edittrip(Trip trip, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTripScreen(trip: trip)),
    );

    if (result != null && result is Trip) {
      setState(() {
        trips[index] = result; // Update the trip in the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Trips'),
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          return _buildTripCard(context, trips[index], index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTrip,
        child: Icon(Icons.add),
        tooltip: 'Add new trip',
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, Trip trip, index) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                trip.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '${trip.startDate.toString().substring(0, 10)} - ${trip.endDate.toString().substring(0, 10)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      textStyle: WidgetStateProperty.all(TextStyle(fontWeight: FontWeight.bold)),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                    ),
                    onPressed: () => {_edittrip(trip, index)},
                    child: Text("Edit Trip"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
