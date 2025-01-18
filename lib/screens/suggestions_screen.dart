import 'package:flutter/material.dart';
import '../models/trip.dart';

class SuggestionsScreen extends StatelessWidget {
  final Trip trip;

  SuggestionsScreen({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suggestions: ${trip.name}'),
      ),
      body: ListView(
        children: [
          _buildSuggestionCategory('Accommodations'),
          _buildSuggestionCategory('Restaurants'),
          _buildSuggestionCategory('Attractions'),
        ],
      ),
    );
  }

  Widget _buildSuggestionCategory(String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Suggestion ${index + 1}'),
              subtitle: Text('Description of the suggestion'),
              onTap: () {
                // TODO: Implement suggestion details
              },
            );
          },
        ),
        Divider(),
      ],
    );
  }
}
