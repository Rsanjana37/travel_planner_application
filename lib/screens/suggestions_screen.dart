import 'dart:math';
import 'package:flutter/material.dart';
import '../models/trip.dart';

class SuggestionsScreen extends StatelessWidget {
  final Trip trip;

  SuggestionsScreen({required this.trip});

  // Static data for accommodations, restaurants, and attractions with ratings
  final List<Map<String, dynamic>> accommodations = [
    {
      'imageUrl':
          'https://www.theindia.co.in/blog/wp-content/uploads/2024/07/praveg-ghoghla-beach-resort-diu-1200x676.jpg',
      'name': 'Amazing Resort',
      'rating': 5,
    },
    {
      'imageUrl':
          'https://cf.bstatic.com/xdata/images/hotel/max1024x768/173021092.jpg?k=cac3018d002a6850c92a989ee64709157635c82dea9d9ee97cda97c9d90defdf&o=&hp=1',
      'name': 'Wonderful Guesthouse',
      'rating': 4,
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2023/02/06/17/11/hotelroom-7772422_1280.jpg',
      'name': 'Fantastic Hotel',
      'rating': 3,
    },
    {
      'imageUrl':
          'https://media.architecturaldigest.com/photos/585ab4aa1f906f61574e6078/16:9/w_2580,c_limit/william-vale-penthouse-04.jpg',
      'name': 'Delightful Hotel',
      'rating': 5,
    },
  ];

  final List<Map<String, dynamic>> restaurants = [
    {
      'imageUrl':
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/74/49/bb/bazaar.jpg',
      'name': 'Fantastic Bistro',
      'rating': 4,
    },
    {
      'imageUrl':
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/74/49/38/jhind.jpg?w=600&h=-1&s=1',
      'name': 'Wonderful Diner',
      'rating': 3,
    },
    {
      'imageUrl':
          'https://i.natgeofe.com/n/04cf2a79-4a49-45eb-90f8-38356167690d/image00037.jpeg',
      'name': 'Delightful Bistro',
      'rating': 5,
    },
    {
      'imageUrl':
          'https://b.zmtcdn.com/data/collections/a7bf69f0d955766f9fe5ac026c2eaec0_1709815455.jpg',
      'name': 'Tres Gatos',
      'rating': 4,
    },
  ];

  final List<Map<String, dynamic>> attractions = [
    {
      'imageUrl':
          'https://www.columbiacommunities.in/wp-content/uploads/2023/12/shutterstock_1938868960-scaled.jpg',
      'name': 'Lovely Beach',
      'rating': 5,
    },
    {
      'imageUrl':
          'https://montgomeryparks.org/wp-content/uploads/2016/07/aberdeen-park-playground-e1702563603419.jpg',
      'name': 'Amazing Park',
      'rating': 3,
    },
    {
      'imageUrl':
          'https://www.nelincs.gov.uk/assets/uploads/2024/01/Weelsby-woods-area-page-1024x683.jpg',
      'name': 'Wonderful Parklands',
      'rating': 4,
    },
    {
      'imageUrl':
          'https://media.springernature.com/full/springer-static/image/art%3A10.1038%2Fs41477-019-0374-3/MediaObjects/41477_2019_374_Figa_HTML.jpg',
      'name': 'Charming Forest',
      'rating': 5,
    },
  ];

  // Function to get random suggestions
  List<Map<String, dynamic>> _getRandomSuggestions(
      List<Map<String, dynamic>> data) {
    final random = Random();
    final randomIndexes = <int>{};
    while (randomIndexes.length < 2) {
      randomIndexes.add(random.nextInt(data.length));
    }
    return randomIndexes.map((index) => data[index]).toList();
  }

  @override
  Widget build(BuildContext context) {
    final randomAccommodations = _getRandomSuggestions(accommodations);
    final randomRestaurants = _getRandomSuggestions(restaurants);
    final randomAttractions = _getRandomSuggestions(attractions);

    return Scaffold(
      appBar: AppBar(
        title: Text('Suggestions'),
      ),
      body: ListView(
        children: [
          _buildSuggestionCategory(
              context, 'Accommodations', randomAccommodations),
          _buildSuggestionCategory(context, 'Restaurants', randomRestaurants),
          _buildSuggestionCategory(context, 'Attractions', randomAttractions),
        ],
      ),
    );
  }

  Widget _buildSuggestionCategory(BuildContext context, String category,
      List<Map<String, dynamic>> suggestions) {
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
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            final rating = suggestion['rating'];

            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(4)),
                    child: Image.network(
                      suggestion['imageUrl']!,
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
                          suggestion['name']!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                index < rating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                                size: 18,
                              );
                            }),
                            SizedBox(width: 8),
                            Text(rating.toString()),
                          ],
                        ),
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
