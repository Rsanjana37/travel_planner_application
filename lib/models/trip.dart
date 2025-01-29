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
