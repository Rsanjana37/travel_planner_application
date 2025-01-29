import 'package:flutter/material.dart';
import '../models/trip.dart';

class DayPlannerScreen extends StatefulWidget {
  final Trip trip;
  final DateTime day;

  DayPlannerScreen({required this.trip, required this.day});

  @override
  _DayPlannerScreenState createState() => _DayPlannerScreenState();
}

class _DayPlannerScreenState extends State<DayPlannerScreen> {
  late List<Activity> activities;
  TextEditingController _activityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    activities = widget.trip.getActivitiesForDay(widget.day);
  }

  void _addActivity() async {
    if (_activityController.text.isNotEmpty) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        setState(() {
          widget.trip.addActivity(
            widget.day,
            Activity(name: _activityController.text, time: selectedTime),
          );
          activities = widget.trip.getActivitiesForDay(widget.day);
          _activityController.clear();
        });
      }
    }
  }

  void _removeActivity(int index) {
    setState(() {
      activities.removeAt(index);
      widget.trip.dayPlans
          .firstWhere(
            (plan) =>
                plan.date.year == widget.day.year &&
                plan.date.month == widget.day.month &&
                plan.date.day == widget.day.day,
          )
          .activities = activities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day ${widget.day.day} Planner'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _activityController,
                    decoration: InputDecoration(
                      hintText: 'Enter activity',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(activities[index].time.format(context)),
                  title: Text(activities[index].name),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeActivity(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
