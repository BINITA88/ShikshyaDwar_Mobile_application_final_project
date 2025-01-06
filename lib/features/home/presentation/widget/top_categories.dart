import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the image URLs and their corresponding titles
    final List<Map<String, dynamic>> categoryData = [
      {
        "image": 'assets/images/c2.png', // Local image
        "title": 'Country 1',
      },
      {
        "image": 'assets/images/c3.png', // Local image
        "title": 'Country 2',
      },
      {
        "image": 'assets/images/c5.png', // Local image
        "title": 'Country 3',
      },
      {
        "image": 'assets/images/c6.png', // Local image
        "title": 'Country 4',
      },
      {
        "image": 'assets/images/c4.png', // Local image
        "title": 'Country 5',
      },
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: categoryData.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 90,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Selected: ${categoryData[index]["title"]}')),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      categoryData[index]['image'], // Use Image.asset here
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          );
        },
      ),
    );
  }
}
