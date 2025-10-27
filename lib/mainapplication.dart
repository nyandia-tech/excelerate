import 'package:excelerate_my_learning/courselisting.dart';
import 'package:excelerate_my_learning/home.dart';
import 'package:excelerate_my_learning/login.dart';
import 'package:excelerate_my_learning/profile.dart';
import 'package:excelerate_my_learning/signup.dart';
import 'package:excelerate_my_learning/verification.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class ExcelerateApp extends StatelessWidget {
  const ExcelerateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate Learning',
      theme: ThemeData(
        primaryColor: exceleratePrimary,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: excelerateDark,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: exceleratePrimary,
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: excelerateDark,
          displayColor: excelerateDark,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: excelerateAccent,
          primary: exceleratePrimary,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/LoginScreen',
      routes: {
        '/LoginScreen': (context) => const LoginScreen(),
        '/SignUpScreen': (context) => const SignUpScreen(),
        '/HomeScreen': (context) => const HomeScreen(),
        '/CourseListingScreen': (context) => const CourseListingScreen(),
        '/MfaVerificationScreen': (context) => const MfaVerificationScreen(),
        '/UserProfileScreen': (context) => const UserProfileScreen(),
      },
    );
  }
}

// Custom Widget for Branded App Name
class ExcelerateLogo extends StatelessWidget {
  final double fontSize;
  final Color color;
  const ExcelerateLogo({super.key, this.fontSize = 32.0, this.color = excelerateDark});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          color: color,
        ),
        children: const <TextSpan>[
          TextSpan(text: 'E'),
          TextSpan(
            text: 'excelerate',
            style: TextStyle(color: exceleratePrimary),
          ),
        ],
      ),
    );
  }
}