import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'mockdata.dart';

Future<String> get _coursePath async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/courses.json';
}

Future<void> saveCourses(List<Course> courses) async {
  final file = File(await _coursePath);
  final List<Map<String, dynamic>> jsonList = courses.map((course) => {
    'id': course.id,
    'title': course.title,
    'author': course.author,
    'description': course.description,
    'category': course.category,
    'progress': course.progress,
    'isCertified': course.isCertified,
    'rating': course.rating,
    'materials': course.materials.map((m) => {
      'title': m.title,
      'isCompleted': m.isCompleted,
    }).toList(),
  }).toList();

  await file.writeAsString(jsonEncode(jsonList));
}

Future<List<Course>> loadSavedCourses() async {
  try {
    final file = File(await _coursePath);
    final contents = await file.readAsString();
    final List<dynamic> jsonList = jsonDecode(contents);

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
  } catch (e) {
    return []; // If no saved file exists yet
  }
}