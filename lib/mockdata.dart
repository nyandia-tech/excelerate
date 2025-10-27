import 'package:flutter/material.dart';

// Course Material Model
class CourseMaterial {
  final String title;
  bool isCompleted;
  CourseMaterial({required this.title, this.isCompleted = false});
}

class Course {
  final String id;
  final String title;
  final String author;
  final String description;
  final String category;
  double progress; // 0.0 to 1.0
  bool isCertified;
  List<CourseMaterial> materials;
  double rating; // Course Rating (e.g., 4.5)

  Course({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.category,
    this.progress = 0.0,
    this.isCertified = false,
    required this.materials,
    this.rating = 0.0,
  });

  double get calculatedProgress {
    if (materials.isEmpty) return 0.0;
    int completed = materials.where((m) => m.isCompleted).length;
    return completed / materials.length;
  }
}

// User Profile Model
class UserProfile {
  String firstName;
  String lastName;
  String otherName;
  String gender;
  String email;
  String countryCode;
  String phoneNumber;

  UserProfile({
    this.firstName = 'userFirstName',
    this.lastName = 'userLastName',
    this.otherName = '',
    this.gender = 'Not Specified',
    this.email = 'user@excelerate.com',
    this.countryCode = '+254',
    this.phoneNumber = '0712345678',
  });

  String get fullName => '$firstName $lastName';

  // ✅ Convert to JSON
  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'otherName': otherName,
    'gender': gender,
    'email': email,
    'countryCode': countryCode,
    'phoneNumber': phoneNumber,
  };

  // ✅ Create from JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    otherName: json['otherName'] ?? '',
    gender: json['gender'] ?? '',
    email: json['email'] ?? '',
    countryCode: json['countryCode'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
  );
}

// Mock Database/State
UserProfile mockUserProfile = UserProfile(); // Mock User Profile State

List<Course> mockCourses = [
  Course(
    id: 'C101',
    title: 'Advanced UI/UX with Flutter',
    author: 'Prof.Mary Nyandia',
    description: 'Master custom widgets, implicit animations, and responsive design patterns in Flutter.',
    category: 'Development',
    progress: 0.6,
    rating: 4.7,
    materials: [
      CourseMaterial(title: 'Introduction to Custom Painters', isCompleted: true),
      CourseMaterial(title: 'Implicit Animations Deep Dive', isCompleted: true),
      CourseMaterial(title: 'Building Responsive Layouts', isCompleted: false),
      CourseMaterial(title: 'State Management with Provider', isCompleted: false),
    ],
  ),
  Course(
    id: 'C102',
    title: 'Data Science with Python',
    author: 'Sir.Benedict Okang',
    description: 'A comprehensive guide to data cleaning, analysis, and visualization using Python and Pandas.',
    category: 'Data Science',
    progress: 1.0,
    isCertified: true,
    rating: 4.9,
    materials: [
      CourseMaterial(title: 'Setting up the Environment', isCompleted: true),
      CourseMaterial(title: 'Pandas for Data Manipulation', isCompleted: true),
      CourseMaterial(title: 'Data Visualization with Matplotlib', isCompleted: true),
      CourseMaterial(title: 'Introduction to Machine Learning', isCompleted: true),
    ],
  ),
  Course(
    id: 'C103',
    title: 'Digital Marketing Fundamentals',
    author: 'Dr.Antonina Obillo',
    description: 'Learn the essentials of SEO, SEM, and social media strategy.',
    category: 'Business',
    progress: 0.2,
    rating: 4.2,
    materials: [
      CourseMaterial(title: 'What is Digital Marketing?', isCompleted: true),
      CourseMaterial(title: 'SEO Basics', isCompleted: false),
      CourseMaterial(title: 'Creating Ad Campaigns', isCompleted: false),
    ],
  ),

  Course(
    id: 'C104',
    title: '7 Fundamental Recipes of Success',
    author: 'Business Mogul Enock',
    description: 'How to transform your life from rags to riches using 7 tried and tested principles of success.',
    category: 'Business',
    progress: 0.0,
    rating: 5.0,
    materials: [
      CourseMaterial(title: 'My Life in the Slums of Nairobi', isCompleted: false),
      CourseMaterial(title: 'How I Overcame Poverty Mentality', isCompleted: false),
      CourseMaterial(title: 'Climbing the Ladder of Success', isCompleted: false),
      CourseMaterial(title: '7 Lessons that became 7 Recipes of Success', isCompleted: false),
      CourseMaterial(title: 'How You Can Apply the 7 Principles as a Recipe to Your Success', isCompleted: false),
    ],
  ),
];

// Utility Widget for Course Rating
class CourseRating extends StatelessWidget {
  final double rating;
  final double size;
  const CourseRating({super.key, required this.rating, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: Colors.amber, size: size);
        } else if (index < rating && rating % 1 != 0) {
          return Icon(Icons.star_half, color: Colors.amber, size: size);
        } else {
          return Icon(Icons.star_border, color: Colors.amber, size: size);
        }
      }),
    );
  }
}