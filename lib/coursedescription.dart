import 'package:excelerate_my_learning/materials.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'mockdata.dart';

class CourseDescriptionScreen extends StatefulWidget {
  final Course course;
  const CourseDescriptionScreen({super.key, required this.course});

  @override
  State<CourseDescriptionScreen> createState() => _CourseDescriptionScreenState();
}

class _CourseDescriptionScreenState extends State<CourseDescriptionScreen> {

  void _showSimpleMessage(BuildContext context, String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? excelerateAccent : exceleratePrimary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

// Helper to force a UI update on the mock data (in a real app, this would update state management)
  void _toggleMaterialCompletion(CourseMaterial material) {
    setState(() {
// Find the material in the mock course and toggle its state
      final courseMaterial = widget.course.materials.firstWhere((m) => m.title == material.title);
      courseMaterial.isCompleted = !courseMaterial.isCompleted;

// Recalculate and update the course's overall progress
      widget.course.progress = widget.course.calculatedProgress;

// Check for completion/certification (simplified logic)
      if (widget.course.progress == 1.0 && !widget.course.isCertified) {
        widget.course.isCertified = true;
// L1547 fix applied (The previous structure of the function call was already clean)
        _showSimpleMessage(context, 'Congratulations! ${widget.course.title} is complete! You are now certified!');
      } else if (widget.course.progress < 1.0 && widget.course.isCertified) {
        widget.course.isCertified = false;
// L1550 fix applied (The previous structure of the function call was already clean)
        _showSimpleMessage(context, 'Certification removed as course progress dropped.', success: false);
      }
    }); // L1553: Ensure the setState block is correctly closed and followed by a semicolon if necessary.
  }

  @override
  Widget build(BuildContext context) {
    final progressPercentage = (widget.course.progress * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
        backgroundColor: excelerateDark,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Author: ${widget.course.author}',
                        style: TextStyle(fontSize: 16, color: excelerateDark.withValues(alpha: 179), fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 5),
                      Row( // NEW: Rating in Description Screen
                        children: [
                          CourseRating(rating: widget.course.rating, size: 22),
                          const SizedBox(width: 10),
                          Text(
                            '${widget.course.rating.toStringAsFixed(1)} (Based on reviews)',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: exceleratePrimary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.course.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),

// Progress Bar Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Course Progress',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: excelerateDark),
                          ),
                          Text(
                            '$progressPercentage%',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: exceleratePrimary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: widget.course.progress,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(exceleratePrimary),
                        minHeight: 12,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      const SizedBox(height: 20),

// Certification Badge
                      if (widget.course.isCertified)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: excelerateAccent.withValues(alpha: 38),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: excelerateAccent, width: 2),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.emoji_events, color: excelerateAccent, size: 24),
                              SizedBox(width: 10),
                              Text(
                                'Certified! Download Certificate',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: excelerateDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 20),

                      const Text(
                        'Course Materials',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: excelerateDark),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
// Course Materials List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return CourseMaterialListItem(
                  material: widget.course.materials[index],
                  index: index,
                  onTap: _toggleMaterialCompletion,
                );
              },
              childCount: widget.course.materials.length,
            ),
          ),
        ],
      ),
// Action button for the course
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (widget.course.progress < 1.0) {
                _showSimpleMessage(context, 'Start ${widget.course.title}!');
              }
              else if (widget.course.progress == 1.0) {
                _showSimpleMessage(context, 'continue ${widget.course.title}!');
              }
              else {
                _showSimpleMessage(context, 'You have completed ${widget.course.title}!');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.course.progress < 1.0 ? exceleratePrimary : excelerateDark,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              widget.course.progress == 0.0 ? 'Start Course' : (widget.course.progress < 1.0 ? 'Continue Learning' : 'Course Completed'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}