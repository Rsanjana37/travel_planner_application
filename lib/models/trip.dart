import 'package:flutter/material.dart';
import 'dart:math';

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

class Suggestion {
  final String name;
  final String description;
  final double rating;
  final String imageUrl;

  Suggestion({
    required this.name,
    required this.description,
    required this.rating,
    required this.imageUrl,
  });

  factory Suggestion.random(String category) {
    final random = Random();
    final adjectives = [
      'Amazing',
      'Wonderful',
      'Fantastic',
      'Charming',
      'Delightful'
    ];
    final nouns = {
      'Accommodations': ['Hotel', 'Resort', 'Apartment', 'Guesthouse', 'Villa'],
      'Restaurants': ['Restaurant', 'Bistro', 'Café', 'Diner', 'Eatery'],
      'Attractions': ['Museum', 'Park', 'Monument', 'Gallery', 'Theater'],
    };

    final name =
        '${adjectives[random.nextInt(adjectives.length)]} ${nouns[category]![random.nextInt(nouns[category]!.length)]}';
    final description =
        'This ${category.toLowerCase()} offers a unique experience with its ${adjectives[random.nextInt(adjectives.length)].toLowerCase()} atmosphere and exceptional service.';
    final rating =
        (random.nextInt(30) + 30) / 10; // Random rating between 3.0 and 5.0

    return Suggestion(
      name: name,
      description: description,
      rating: rating,
      imageUrl:
          'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
    );
  }
}

class Expense {
  final String id;
  final String category;
  final String description;
  final double amount;
  final DateTime date;

  Expense({
    required this.id,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
  });
}

class Trip {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String imageUrl;
  List<DayPlan> dayPlans;
  Map<String, List<Suggestion>> suggestions;
  List<Expense> expenses;
  double budget;

  Trip({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
    List<DayPlan>? dayPlans,
    this.budget = 0,
  })  : dayPlans = dayPlans ?? [],
        suggestions = {
          'Accommodations':
              List.generate(3, (_) => Suggestion.random('Accommodations')),
          'Restaurants':
              List.generate(3, (_) => Suggestion.random('Restaurants')),
          'Attractions':
              List.generate(3, (_) => Suggestion.random('Attractions')),
        },
        expenses = [];

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

  void removeActivity(DateTime date, int index) {
    DayPlan? dayPlan = dayPlans.firstWhere(
      (plan) =>
          plan.date.year == date.year &&
          plan.date.month == date.month &&
          plan.date.day == date.day,
      orElse: () => DayPlan(date: date, activities: []),
    );

    if (index >= 0 && index < dayPlan.activities.length) {
      dayPlan.activities.removeAt(index);
    }
  }

  void updateActivities(DateTime date, List<Activity> updatedActivities) {
    int index = dayPlans.indexWhere(
      (plan) =>
          plan.date.year == date.year &&
          plan.date.month == date.month &&
          plan.date.day == date.day,
    );

    if (index != -1) {
      dayPlans[index].activities = updatedActivities;
    } else {
      dayPlans.add(DayPlan(date: date, activities: updatedActivities));
    }
  }

  void regenerateSuggestions() {
    suggestions = {
      'Accommodations':
          List.generate(3, (_) => Suggestion.random('Accommodations')),
      'Restaurants': List.generate(3, (_) => Suggestion.random('Restaurants')),
      'Attractions': List.generate(3, (_) => Suggestion.random('Attractions')),
    };
  }

  void addExpense(Expense expense) {
    expenses.add(expense);
  }

  double getTotalExpenses() {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  double getRemainingBudget() {
    return budget - getTotalExpenses();
  }

  void setBudget(double newBudget) {
    budget = newBudget;
  }
}
