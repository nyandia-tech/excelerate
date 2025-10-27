import 'package:excelerate_my_learning/coursedescription.dart';
import 'package:excelerate_my_learning/learning&certification.dart';
import 'package:excelerate_my_learning/mainapplication.dart';
import 'package:flutter/material.dart';
import 'package:excelerate_my_learning/main.dart';
import 'package:excelerate_my_learning/mockdata.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inProgressCourses = mockCourses.where((c) => c.progress > 0 && c.progress < 1.0).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: excelerateDark,
        title: const ExcelerateLogo(fontSize: 24, color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              _showSimpleMessage(context, 'Notifications', 'No new notifications.');
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome Back, ${mockUserProfile.firstName}!',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: excelerateDark),
            ),
            const SizedBox(height: 10),
            const Text(
              'What would you like to excelerate today?',
              style: TextStyle(fontSize: 16, color: excelerateDark),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ActionCard(
                    icon: Icons.school,
                    label: 'My Learning',
                    color: exceleratePrimary,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyLearningScreen()));
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ActionCard(
                    icon: Icons.card_membership,
                    label: 'My Certificates',
                    color: excelerateAccent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCertificatesScreen()));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            const Text(
              'Continue Learning',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: excelerateDark),
            ),
            const SizedBox(height: 15),
            inProgressCourses.isEmpty
                ? const Text('You currently have no courses in progress. Start a new one below!', style: TextStyle(fontStyle: FontStyle.italic))
                : Column(
              children: inProgressCourses
                  .map((course) => CourseProgressCard(course: course))
                  .toList(),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.search),
                label: const Text('Explore All Courses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pushNamed(context, '/CourseListingScreen');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: excelerateDark,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
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

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: excelerateDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseProgressCard extends StatelessWidget {
  final Course course;
  const CourseProgressCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDescriptionScreen(course: course),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: excelerateDark),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CourseRating(rating: course.rating, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    course.rating.toStringAsFixed(1), // Removed unnecessary interpolation
                    style: TextStyle(fontSize: 14, color: excelerateDark.withValues(alpha: 179)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: course.progress,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(exceleratePrimary),
                minHeight: 10,
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(height: 8),
              Text(
                '${(course.progress * 100).toStringAsFixed(0)}% Complete',
                style: TextStyle(color: excelerateDark.withValues(alpha: 179)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}