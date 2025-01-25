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
          _buildSuggestionCategory(context, 'Accommodations'),
          _buildSuggestionCategory(context, 'Restaurants'),
          _buildSuggestionCategory(context, 'Attractions'),
        ],
      ),
    );
  }

  Widget _buildSuggestionCategory(BuildContext context, String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            category,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: trip.suggestions[category]!.length,
          itemBuilder: (context, index) {
            final suggestion = trip.suggestions[category]![index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(4)),
                    child: Image.network(
                      suggestion.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          suggestion.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                index < suggestion.rating.floor()
                                    ? Icons.star
                                    : index < suggestion.rating
                                        ? Icons.star_half
                                        : Icons.star_border,
                                color: Colors.amber,
                                size: 18,
                              );
                            }),
                            SizedBox(width: 8),
                            Text(suggestion.rating.toStringAsFixed(1)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(suggestion.description),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Divider(),
      ],
    );
  }
}
