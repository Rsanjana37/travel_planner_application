import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'itinerary_screen.dart';
import 'budget_screen.dart';
import 'suggestions_screen.dart';

class TripScreen extends StatelessWidget {
  final Trip trip;

  TripScreen({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                trip.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.7),
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              background: Image.network(
                trip.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildInfoCard(context),
              _buildOptionCard(
                context,
                'Itinerary',
                Icons.calendar_today,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItineraryScreen(trip: trip)),
                ),
              ),
              _buildOptionCard(
                context,
                'Budget',
                Icons.attach_money,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BudgetScreen(trip: trip)),
                ),
              ),
              _buildOptionCard(
                context,
                'Suggestions',
                Icons.lightbulb_outline,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SuggestionsScreen(trip: trip)),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8.0),
            Text(
              'Start Date: ${trip.startDate.toString().substring(0, 10)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'End Date: ${trip.endDate.toString().substring(0, 10)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Duration: ${trip.endDate.difference(trip.startDate).inDays + 1} days',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
