import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/Dashboard/classes.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/Dashboard/message.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/home_view.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 3; // Default to "Message" tab

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
          nextPage = const Classes();
          break;
        case 2:
          nextPage = const Message(); // Current Page
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Header
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: const AssetImage(
                            'assets/images/profile.png'), // Your cartoon image
                        backgroundColor: const Color.fromARGB(0, 178, 169, 169),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Binita Acharya",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Deep black color for the name
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "binita@example.com",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(153, 67, 66, 66),
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Details
              Expanded(
                child: ListView(
                  children: const [
                    ProfileInfoCard(
                      icon: Icons.phone,
                      iconColor: Colors.blue,
                      title: "Phone Number",
                      value: "+1 234 567 890",
                    ),
                    ProfileInfoCard(
                      icon: Icons.location_on,
                      iconColor: Colors.green,
                      title: "Current Address",
                      value: "Maitidevi",
                    ),
                    ProfileInfoCard(
                      icon: Icons.school,
                      iconColor: Colors.orange,
                      title: "Course Enrolled",
                      value: "IELTS - Reading & Writing",
                    ),
                  ],
                ),
              ),
              // Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Edit Profile action
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        backgroundColor:
                            const Color.fromARGB(255, 225, 164, 31),
                        minimumSize: const Size(60, 45), // Small width button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Icon(Icons.edit, size: 24),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Logout action
                      },
                      icon: const Icon(Icons.logout, size: 20),
                      label: const Text("Logout"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(color: Colors.blue.shade800),
                        foregroundColor: Colors.blue.shade800,
                      ),
                    ),
                  ],
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

class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor; // Explicit color for the icon
  final String title;
  final String value;

  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.iconColor, // Pass the icon color
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    iconColor.withOpacity(0.1), // Light background for the icon
              ),
              child: Icon(
                icon,
                size: 26.0,
                color: iconColor, // Explicitly set the icon color
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Set explicit text color
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black
                          .withOpacity(0.7), // Set explicit text color
                    ),
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
