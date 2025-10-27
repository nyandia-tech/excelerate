import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:excelerate_my_learning/mockdata.dart'; // Make sure this includes Course and CourseMaterial

Future<List<Course>> loadCoursesFromAssets() async {
  final jsonString = await rootBundle.loadString('assets/courses.json');
  final List<dynamic> jsonList = jsonDecode(jsonString);

  return jsonList.map((json) => Course(
    id: json['id'],
    title: json['title'],
    author: json['author'],
    description: json['description'],
    category: json['category'],
    progress: (json['progress'] ?? 0.0).toDouble(),
    isCertified: json['isCertified'] ?? false,
    rating: (json['rating'] ?? 0.0).toDouble(),
    materials: (json['materials'] as List).map((m) => CourseMaterial(
      title: m['title'],
      isCompleted: m['isCompleted'] ?? false,
    )).toList(),
  )).toList();
}