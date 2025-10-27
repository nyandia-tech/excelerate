import 'package:flutter/material.dart';
import 'main.dart';
import 'mockdata.dart';

class CourseMaterialListItem extends StatelessWidget {
  final CourseMaterial material;
  final int index;
  final Function(CourseMaterial) onTap;

  const CourseMaterialListItem({
    super.key,
    required this.material,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: () => onTap(material),
        leading: CircleAvatar(
          backgroundColor: material.isCompleted ? excelerateAccent : exceleratePrimary.withValues(alpha: 25),
          child: Text(
            (index + 1).toString(), // Removed unnecessary interpolation
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: material.isCompleted ? excelerateDark : exceleratePrimary,
            ),
          ),
        ),
        title: Text(
          material.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: excelerateDark,
            decoration: material.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: material.isCompleted
            ? const Icon(Icons.check_circle, color: excelerateAccent)
            : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
      ),
    );
  }
}