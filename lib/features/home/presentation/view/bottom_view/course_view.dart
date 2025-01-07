import 'package:flutter/material.dart';

class CourseView extends StatelessWidget {
  const CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample course data
    final List<Map<String, String>> courses = [
      {
        "image": "assets/images/reading.png",
        "title": "IELTS Reading",
        "date": "Jan 15, 2024",
        "duration": "6 Weeks"
      },
      {
        "image": "assets/images/pte.png",
        "title": "IELTS Writing",
        "date": "Feb 1, 2024",
        "duration": "8 Weeks"
      },
      {
        "image": "assets/images/speaking.png",
        "title": "IELTS Speaking",
        "date": "Mar 1, 2024",
        "duration": "4 Weeks"
      },
      {
        "image": "assets/images/listening.png",
        "title": "IELTS Listening",
        "date": "Apr 1, 2024",
        "duration": "4 Weeks"
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search courses...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 24),

              // Active Courses Section
              const Text(
                "Active Courses",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2, // Show only first 2 courses as active
                  itemBuilder: (context, index) {
                    var course = courses[index];
                    return MyCart(
                      image: course["image"]!,
                      title: course["title"]!,
                      date: course["date"]!,
                      duration: course["duration"]!,
                      onPressed: () {
                        // Handle course selection
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Available Courses Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Available Courses",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle view all
                    },
                    child: const Text("View All"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    var course = courses[index];
                    return MyCart(
                      image: course["image"]!,
                      title: course["title"]!,
                      date: course["date"]!,
                      duration: course["duration"]!,
                      onPressed: () {
                        // Handle course selection
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MyCart widget (in case you need it)
class MyCart extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String duration;
  final VoidCallback onPressed;

  const MyCart({
    super.key,
    required this.image,
    required this.title,
    required this.date,
    required this.duration,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Starts: $date',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Duration: $duration',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
