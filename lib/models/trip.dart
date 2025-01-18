import 'package:flutter/material.dart';

class Activity {
  String name;
  TimeOfDay time;

  Activity({required this.name, required this.time});
}

class DayPlan {
  DateTime date;
  List<Activity> activities;

  DayPlan({required this.date, required this.activities});
}

class Trip {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String imageUrl;
  List<DayPlan> dayPlans;

  Trip({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
    List<DayPlan>? dayPlans,
  }) : dayPlans = dayPlans ?? [];

  void addActivity(DateTime date, Activity activity) {
    DayPlan? dayPlan = dayPlans.firstWhere(
      (plan) =>
          plan.date.year == date.year &&
          plan.date.month == date.month &&
          plan.date.day == date.day,
      orElse: () {
        final newPlan = DayPlan(date: date, activities: []);
        dayPlans.add(newPlan);
        return newPlan;
      },
    );
    dayPlan.activities.add(activity);
    dayPlan.activities.sort((a, b) =>
        a.time.hour * 60 + a.time.minute - (b.time.hour * 60 + b.time.minute));
  }

  List<Activity> getActivitiesForDay(DateTime date) {
    return dayPlans
        .firstWhere(
          (plan) =>
              plan.date.year == date.year &&
              plan.date.month == date.month &&
              plan.date.day == date.day,
          orElse: () => DayPlan(date: date, activities: []),
        )
        .activities;
  }
}
