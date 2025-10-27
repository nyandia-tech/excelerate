// ignore: file_names
import 'package:excelerate_my_learning/home.dart';
import 'package:flutter/material.dart';
import 'package:excelerate_my_learning/main.dart';
import 'package:excelerate_my_learning/mockdata.dart';
class MyLearningScreen extends StatelessWidget {
  const MyLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final learningCourses = mockCourses.where((c) => c.progress > 0).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Learning Progress'),
        backgroundColor: excelerateDark,
      ),
      body: learningCourses.isEmpty
          ? const Center(
        child: Text(
          'You haven\'t started any courses yet!',
          style: TextStyle(fontSize: 18, color: excelerateDark),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: learningCourses.length,
        itemBuilder: (context, index) {
          final course = learningCourses[index];
          return CourseProgressCard(course: course);
        },
      ),
    );
  }
}

class MyCertificatesScreen extends StatelessWidget {
  const MyCertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final certifiedCourses = mockCourses.where((c) => c.isCertified).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Certificates'),
        backgroundColor: excelerateDark,
      ),
      body: certifiedCourses.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, size: 80, color: excelerateAccent),
            const SizedBox(height: 10),
            const Text(
              'No certificates earned yet.',
              style: TextStyle(fontSize: 18, color: excelerateDark),
            ),
            const Text(
              'Keep learning to earn your first one!',
              style: TextStyle(fontSize: 16, color: excelerateDark),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: certifiedCourses.length,
        itemBuilder: (context, index) {
          final course = certifiedCourses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: const Icon(Icons.verified, color: excelerateAccent, size: 30),
              title: Text(
                'Certificate of Completion: ${course.title}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: excelerateDark),
              ),
              subtitle: Text('Issued by Excelerate\nInstructor: ${course.author}'),
              trailing: const Icon(Icons.download, color: exceleratePrimary),
              onTap: () {
                _showSimpleMessage(context, 'Certificate Download', 'Simulating download of certificate for ${course.title}.');
              },
            ),
          );
        },
      ),
    );
  }

  void _showSimpleMessage(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: const TextStyle(color: exceleratePrimary, fontWeight: FontWeight.bold)),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: exceleratePrimary)),
          ),
        ],
      ),
    );
  }
}

// NEW SCREEN: User Profile with Log Out
