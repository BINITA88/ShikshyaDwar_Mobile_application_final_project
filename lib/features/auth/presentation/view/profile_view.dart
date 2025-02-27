import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // Dummy user data
  String name = "John Doe";
  String email = "johndoe@example.com";
  String phoneNumber = "+123 456 7890";
  String address = "123, Main Street, New York, USA";
  String country = "Nepal"; // New Field
  String bookedCourse = "IELTS"; // Dummy booked course
  String profileImage = "assets/images/pro.jpg"; // Local Asset Image

  // Controllers for editing profile fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = name;
    _emailController.text = email;
    _phoneController.text = phoneNumber;
    _addressController.text = address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture with Fallback Image
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(profileImage),
                onBackgroundImageError: (exception, stackTrace) {
                  setState(() {
                    profileImage = "assets/images/default_avatar.png";
                  });
                },
              ),
            ),
            const SizedBox(height: 16),

            // User Details
            _buildProfileDetail("Name", name),
            _buildProfileDetail("Email", email),
            _buildProfileDetail("Phone", phoneNumber),
            _buildProfileDetail("Address", address),
            _buildProfileDetail("Country", country), // Added country field

            const SizedBox(height: 20),

            // Booked Course Section
            GestureDetector(
              onTap: () => _showBookedCourseDialog(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.pink[800]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.book_online, color: Colors.pink),
                    Text(
                      "Booked Course: $bookedCourse",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Edit Profile Button
            ElevatedButton.icon(
              onPressed: () => _editProfile(),
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[800],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper Widget to Display Profile Details
  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.person, color: Colors.pink[800]),
          const SizedBox(width: 10),
          Text(
            "$label: ",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  /// Show Booked Course Details in Dialog
  void _showBookedCourseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Booked Course"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.school, size: 50, color: Colors.pink),
            const SizedBox(height: 10),
            Text(
              "Course: $bookedCourse",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Start Date: 10th March 2025\nDuration: 2 Months",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  /// Edit Profile Functionality (Allows Changing User Data)
  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEditableField("Name", _nameController),
            _buildEditableField("Email", _emailController),
            _buildEditableField("Phone", _phoneController),
            _buildEditableField("Address", _addressController),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                name = _nameController.text;
                email = _emailController.text;
                phoneNumber = _phoneController.text;
                address = _addressController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  /// Helper Widget for Editable Fields
  Widget _buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
