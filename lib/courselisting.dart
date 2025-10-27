import 'package:flutter/material.dart';
import 'mockdata.dart';
import 'course_loader.dart'; // <-- Import the loader
import 'coursedescription.dart';
import 'main.dart'; // For excelerate colors

class CourseListingScreen extends StatefulWidget {
  const CourseListingScreen({super.key});

  @override
  State<CourseListingScreen> createState() => _CourseListingScreenState();
}

class _CourseListingScreenState extends State<CourseListingScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  List<Course> _courses = [];

  final List<String> categories = [
    'All',
    'Development',
    'Data Science',
    'Business',
    'Design',
    'Marketing'
  ];

  @override
  void initState() {
    super.initState();
    loadCoursesFromAssets().then((loadedCourses) {
      setState(() {
        _courses = loadedCourses;
      });
    });
  }

  List<Course> get _filteredCourses {
    return _courses.where((course) {
      final matchesSearch =
          course.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || course.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Courses'),
        backgroundColor: excelerateDark,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: const Icon(Icons.search, color: exceleratePrimary),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                contentPadding: const EdgeInsets.all(15.0),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? 16.0 : 8.0,
                      right: index == categories.length - 1 ? 16.0 : 0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    selectedColor: exceleratePrimary,
                    disabledColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : excelerateDark,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Expanded(
            child: _filteredCourses.isEmpty
                ? const Center(
                    child: Text(
                      'No courses found for your search criteria.',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: excelerateDark),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _filteredCourses.length,
                    itemBuilder: (context, index) {
                      return CourseListItem(course: _filteredCourses[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class CourseListItem extends StatelessWidget {
  final Course course;
  const CourseListItem({super.key, required this.course});

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
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: excelerateDark),
              ),
              const SizedBox(height: 4),
              Text(
                'By ${course.author}',
                style: TextStyle(
                    fontSize: 14, color: excelerateDark.withAlpha(179)),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  CourseRating(rating: course.rating, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    course.rating.toStringAsFixed(1),
                    style: const TextStyle(
                        fontSize: 14,
                        color: excelerateDark,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                course.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              if (course.progress > 0)
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: course.progress,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            exceleratePrimary),
                        minHeight: 5,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${(course.progress * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                          color: exceleratePrimary,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              if (course.isCertified)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: excelerateAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'CERTIFIED',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: excelerateDark),
                  ),
                ),
              if (course.progress == 0)
                Text(
                  '${course.materials.length} lessons',
                  style: TextStyle(
                      fontSize: 14, color: excelerateDark.withAlpha(179)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}