import 'package:flutter/material.dart';

class Lesson {
  final String title;
  final String duration;
  const Lesson(this.title, this.duration);
}

class Course {
  final String id;
  final String title;
  final String category;
  final String instructor;
  final String description;
  final String level;
  final double rating;
  final int students;
  final double price; // in INR, 0 = free
  final int hours;
  final IconData icon;
  final Color color;
  final List<Lesson> lessons;
  final List<String> outcomes;

  const Course({
    required this.id,
    required this.title,
    required this.category,
    required this.instructor,
    required this.description,
    required this.level,
    required this.rating,
    required this.students,
    required this.price,
    required this.hours,
    required this.icon,
    required this.color,
    required this.lessons,
    required this.outcomes,
  });

  String get priceLabel => price == 0 ? 'Free' : '₹${price.toStringAsFixed(0)}';
}
