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
  int _selectedIndex = 3; // Default to "Profile" tab

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
          nextPage = const Message();
          break;
        default:
          nextPage = const Profile(); // Current Page
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
        title: Text(
          "Profile",
          style: theme.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
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
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/images/profile_pic.png'),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "John Doe",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: const Color.fromARGB(255, 18, 18, 18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "john.doe@example.com",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color.fromARGB(255, 13, 13, 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                        padding: const EdgeInsets.all(10),
                        minimumSize: const Size(50, 40), // Small width button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Icon(Icons.edit, size: 20),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Logout action
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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

// Profile Info Card Widget
class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.2),
            ),
            child: Icon(
              icon,
              size: 24.0,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
