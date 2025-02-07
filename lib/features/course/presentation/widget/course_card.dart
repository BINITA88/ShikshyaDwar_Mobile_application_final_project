import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

class CourseCard extends StatelessWidget {
  final CourseEntity course;

  const CourseCard({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                course.courseImage,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),

            // Course Name
            Text(
              course.courseName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 5),

            // Instructor & Duration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Instructor: ${course.instructor}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                Text(
                  "Duration: ${course.duration}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),

            SizedBox(height: 8),

            // Course Price
            Text(
              "Price: \$${course.coursePrice}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
            ),

            SizedBox(height: 8),

            // Course Description
            Text(
              course.courseDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),

            SizedBox(height: 10),

            // Category & Enroll Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category: ${course.category.toString()}",
                  style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle course enrollment
                  },
                  child: Text("Enroll"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
