import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/Dashboard/message.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/Dashboard/profile.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/home_view.dart';
import 'package:shikshyadwar_mobile_application_project/core/common/my_card.dart';

class Classes extends StatefulWidget {
  const Classes({super.key});

  @override
  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  int _selectedIndex = 1; // Default to "Classes" tab

  void _onNavBarTap(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      Widget nextPage;
      switch (index) {
        case 0:
          nextPage = const HomepageView();
          break;
        case 1:
          nextPage = const Classes(); // Current Page
          break;
        case 2:
          nextPage = const Message();
          break;
        case 3:
          nextPage = const Profile();
          break;
        default:
          nextPage = const HomepageView();
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> products = [
      {
        "image": "assets/images/reading.png",
        "title": "IELTS Preparation",
        "date": "Jan 10, 2024",
        "duration": "2 Months"
      },
      {
        "image": "assets/images/pte.png",
        "title": "PTE Classes",
        "date": "Feb 15, 2024",
        "duration": "1 Month"
      },
      {
        "image": "assets/images/reading.png",
        "title": "SAT Preparation",
        "date": "Mar 1, 2024",
        "duration": "3 Months"
      },
      {
        "image": "assets/images/pte.png",
        "title": "TOEFL Training",
        "date": "Apr 10, 2024",
        "duration": "1.5 Months"
      },
    ];

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Classes",
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommended Classes",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle 'View All' action
                      },
                      child: const Text("View All"),
                    ),
                  ],
                ),
              ),
              // Product List Section
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, i) {
                    var product = products[i];
                    return MyCart(
                      image: product["image"]!,
                      title: product["title"]!,
                      date: product["date"]!,
                      duration: product["duration"]!,
                      onPressed: () {
                        // Handle 'Add to Schedule' button press
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme.appBarTheme.backgroundColor,
        selectedItemColor: theme.colorScheme.onSecondary,
        unselectedItemColor: theme.colorScheme.onPrimary.withOpacity(0.5),
        onTap: _onNavBarTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
