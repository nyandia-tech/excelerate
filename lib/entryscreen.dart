// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:excelerate_my_learning/mockdata.dart';
import 'package:excelerate_my_learning/user_storage.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserLogin();
  }

  Future<void> _checkUserLogin() async {
    UserProfile? profile = await loadUserProfile();
    if (profile != null) {
      // ✅ User exists, go to home
      Navigator.pushReplacementNamed(context, '/HomeScreen');
    } else {
      // ❌ No user, go to sign-up
      Navigator.pushReplacementNamed(context, '/SignUpScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Loading spinner while checking
      ),
    );
  }
}