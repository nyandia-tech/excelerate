import 'package:excelerate_my_learning/entryscreen.dart';
import 'package:excelerate_my_learning/learning&certification.dart';
import 'package:excelerate_my_learning/login.dart';
import 'package:excelerate_my_learning/profile.dart';
import 'package:excelerate_my_learning/signup.dart';
import 'package:flutter/material.dart';
import 'package:excelerate_my_learning/coursedescription.dart';
import 'package:excelerate_my_learning/courselisting.dart';
import 'package:excelerate_my_learning/home.dart';
import 'package:excelerate_my_learning/materials.dart';
import 'package:excelerate_my_learning/mockdata.dart';
import 'package:excelerate_my_learning/verification.dart';

// --- 1. COLOR DEFINITIONS ---
// Primary Color: #eb4c32
const Color exceleratePrimary = Color(0xFFEB4C32);
// Secondary/Accent Color: #4be2f5
const Color excelerateAccent = Color(0xFF4BE2F5);
// Dark Background Color: #04444c
const Color excelerateDark = Color(0xFF04444C);

void main() {
  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  const MainApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=>EntryScreen(),
        '/LoginScreen':(context)=>LoginScreen(),
        '/SignUpScreen':(context)=>SignUpScreen(),
        '/HomeScreen': (context) => HomeScreen(),
        '/CourseListingScreen': (context) => CourseListingScreen(),
        '/CourseDescriptionScreen': (context) => CourseDescriptionScreen(course: mockCourses[0],),
        '/learning_certification': (context) => MyLearningScreen(),
        '/materials': (context) => CourseMaterialListItem(material: mockCourses[0].materials[0], index: 0, onTap: (CourseMaterial p1) {  },),
        '/verification': (context) => MfaVerificationScreen(),
        '/profile': (context) => UserProfileScreen(),
        // Add more routes as needed
      },
    );
  }
}
