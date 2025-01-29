import 'package:flutter/material.dart';
import 'dart:math';
import '../models/trip.dart';
import 'day_planner_screen.dart';

class ItineraryScreen extends StatelessWidget {
  final Trip trip;
  final List<String> imageUrls = [
    'https://t4.ftcdn.net/jpg/01/16/61/93/360_F_116619399_YA611bKNOW35ffK0OiyuaOcjAgXgKBui.jpg',
    'https://t3.ftcdn.net/jpg/01/76/33/14/360_F_176331484_nLHY9EoW0ETwPZaS9OBXPGbCJhT70GZe.jpg',
    'https://lajolla.com/nitropack_static/qjIMPjNnWKMPNOkdSPGMqXckjXGVLtvg/assets/images/optimized/rev-a739b3e/lajolla.com/wp-content/uploads/2021/06/Best-San-Diego-Hotels-With-Pools-Your-Ultimate-Guide-1024x576.jpg',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmVhY2h8ZW58MHx8MHx8fDA%3D',
    'https://images.unsplash.com/photo-1724398932228-7acec186bdc2?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
    'https://img-cdn.inc.com/image/upload/f_webp,q_auto,c_fit/images/panoramic/getty_522735456_249841.jpg',
  ];

  ItineraryScreen({required this.trip});

  String getRandomImage() {
    final random = Random();
    return imageUrls[random.nextInt(imageUrls.length)];
  }

  String _getActivityPreview(List<Activity> activities) {
    if (activities.isEmpty) {
      return 'Tap to add activities';
    } else if (activities.length == 1) {
      return '1 activity planned';
    } else {
      return '${activities.length} activities planned';
    }
  }

  @override
  Widget build(BuildContext context) {
    final randomImage = getRandomImage();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Itinerary',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(randomImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final currentDate = trip.startDate.add(Duration(days: index));
                final activities = trip.getActivitiesForDay(currentDate);
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      'Day ${index + 1}: ${currentDate.toString().substring(0, 10)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_getActivityPreview(activities)),
                    onTap: () {},
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
              childCount: trip.endDate.difference(trip.startDate).inDays + 1,
            ),
          ),
        ],
      ),
    );
  }
}
