// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_state.dart';

// class ProfileView extends StatefulWidget {
//   const ProfileView({super.key});

//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   String getRoleLabel(int role) {
//     switch (role) {
//       case 0:
//         return "Student "; // ✅ Shows "Student (User)"
//       case 2:
//         return "Instructor "; // ✅ Shows "Instructor (User)"
//       default:
//         return "Unknown Role"; // Handle unexpected values
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<AuthBloc, AuthState>(
//         builder: (context, state) {
//           if (state is AuthUsersLoaded && state.users.isNotEmpty) {
//             // Assume first user in list is the logged-in user (modify logic if needed)
//             AuthEntity user = state.users.first;

//             return Column(
//               children: [
//                 const SizedBox(height: 20),
//                 _buildProfileImage(user),
//                 const SizedBox(height: 15),
//                 _buildUserInfoTile(Icons.person, "Name", user.name),
//                 _buildUserInfoTile(Icons.email, "Email", user.email),
//                 _buildUserInfoTile(Icons.phone, "Phone", user.contactNo),
//                 _buildUserInfoTile(
//                     Icons.school, "Role", getRoleLabel(user.role)),
//                 const SizedBox(height: 30),
//                 _buildEditProfileButton(),
//                 const SizedBox(height: 10),
//                 _buildLogoutButton(context),
//               ],
//             );
//           } else if (state is AuthLoadingUsers) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             return const Center(child: Text("Failed to load user data"));
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildProfileImage(AuthEntity user) {
//     String imageUrl = (user.image != null && user.image!.isNotEmpty)
//         ? "${ApiEndpoints.imageUrl}/${user.image}"
//             .trim() // ✅ Fix duplicate 'profile/'
//         : "https://via.placeholder.com/150"; // Default placeholder

//     print("User Image URL: '$imageUrl'"); // Debugging

//     return CircleAvatar(
//       radius: 50,
//       backgroundColor: Colors.grey.shade300,
//       backgroundImage: NetworkImage(imageUrl),
//     );
//   }

//   /// **🔹 User Information Tile**
//   Widget _buildUserInfoTile(IconData icon, String title, String value) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.pink.shade400),
//       title: Text(
//         title,
//         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//       ),
//       subtitle: Text(
//         value,
//         style: const TextStyle(fontSize: 14, color: Colors.black87),
//       ),
//     );
//   }

//   /// **🔹 Edit Profile Button**
//   Widget _buildEditProfileButton() {
//     return ElevatedButton.icon(
//       onPressed: () {
//         // Navigate to Edit Profile Screen (To Be Implemented)
//       },
//       icon: const Icon(Icons.edit, color: Colors.white),
//       label: const Text("Edit Profile"),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.pink.shade400,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       ),
//     );
//   }

//   /// **🔹 Logout Button**
//   Widget _buildLogoutButton(BuildContext context) {
//     return TextButton.icon(
//       onPressed: () {
//         // Implement Logout Logic (Clear Token, Navigate to Login Screen)
//       },
//       icon: const Icon(Icons.logout, color: Colors.redAccent),
//       label: const Text(
//         "Logout",
//         style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_state.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final List<Map<String, dynamic>> _courses = [
    {
      'name': 'Abroad Study Counselling',
      'icon': '🌍',
      'color': Colors.teal,
    },
  ];

  String getRoleLabel(int role) {
    switch (role) {
      case 0:
        return "Student";
      case 2:
        return "Instructor";
      default:
        return "Unknown Role";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthUsersLoaded && state.users.isNotEmpty) {
            AuthEntity user = state.users.first;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false, // Removes the back button
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  expandedHeight: 230,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _buildProfileHeader(user),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    _buildProfileSection(user),
                    _buildCoursesSection(),
                    _buildActionButtons(context),
                  ]),
                ),
              ],
            );
          } else if (state is AuthLoadingUsers) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("Failed to load user data"));
          }
        },
      ),
    );
  }

  // Widget _buildProfileHeader(AuthEntity user) {
  //   String imageUrl = (user.image != null && user.image!.isNotEmpty)
  //       ? "${ApiEndpoints.imageUrl}/${user.image}".trim()
  //       : "https://via.placeholder.com/150";

  //   return Container(
  //     color: Colors.white,
  //     child: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Hero(
  //             tag: 'profile_image',
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 border: Border.all(
  //                   color: Colors.grey.shade300,
  //                   width: 4,
  //                 ),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.black12,
  //                     blurRadius: 10,
  //                     offset: Offset(0, 4),
  //                   ),
  //                 ],
  //               ),
  //               child: CircleAvatar(
  //                 radius: 60,
  //                 backgroundImage: NetworkImage(imageUrl),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           Text(
  //             user.name,
  //             style: const TextStyle(
  //               fontSize: 22,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black87,
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           Text(
  //             getRoleLabel(user.role),
  //             style: TextStyle(
  //               color: Colors.grey.shade600,
  //               fontSize: 16,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // Define a single static fallback image
  Widget _buildProfileHeader(AuthEntity user) {
    // Define a single static fallback image for the profile
    const String fallbackImage = "assets/images/pro.jpg";

    // Determine image source: Network or Asset
    String? imageUrl = (user.image != null && user.image!.isNotEmpty)
        ? "${ApiEndpoints.imageUrl}/${user.image}".trim()
        : null; // No URL if empty

    bool useAssetImage = imageUrl == null || !imageUrl.startsWith("http");

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 180, // Adjusted to ensure proper spacing
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255), // Soft background color
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        Positioned(
          bottom: -30, // Moves the profile image slightly outside the header
          child: Column(
            children: [
              CircleAvatar(
                radius: 60, // Increased size for better visibility
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 55, // Inner profile image
                  backgroundImage: useAssetImage
                      ? const AssetImage(fallbackImage) as ImageProvider
                      : NetworkImage(imageUrl),
                  onBackgroundImageError: (_, __) {
                    print("Error loading image: Using fallback asset.");
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                user.email,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(AuthEntity user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          _buildProfileDetailRow(Icons.email, "Email", user.email),
          Divider(color: Colors.grey.shade300),
          _buildProfileDetailRow(Icons.phone, "Phone", "9805233406"),
        ],
      ),
    );
  }

  Widget _buildCoursesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Courses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  _courses.map((course) => _buildCourseCard(course)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCourseCard(Map<String, dynamic> course) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(
  //         horizontal: 10, vertical: 8), // Adjusted spacing
  //     width: MediaQuery.of(context).size.width * 0.85, // Slightly reduced width
  //     decoration: BoxDecoration(
  //       color: course['color'] as Color,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(
  //         color: Colors.teal.shade900, // Proper side border
  //         width: 2,
  //       ),
  //       boxShadow: const [
  //         BoxShadow(
  //           color: Colors.black26,
  //           blurRadius: 2,
  //           offset: Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  //       child: Row(
  //         children: [
  //           Text(
  //             course['icon']!,
  //             style: const TextStyle(fontSize: 30),
  //           ),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: Text(
  //               course['name']!,
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //               overflow:
  //                   TextOverflow.ellipsis, // Prevents text from overflowing
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 8), // Adjusted spacing
      width: MediaQuery.of(context).size.width * 0.85, // Slightly reduced width
      decoration: BoxDecoration(
        color: Colors.pink.shade700, // Updated background color to pink[200]

        border: Border.all(
          color: const Color.fromARGB(255, 163, 159, 159), // Proper side border
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            Text(
              course['icon']!,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                course['name']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow:
                    TextOverflow.ellipsis, // Prevents text from overflowing
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color.fromARGB(255, 169, 35, 108),
            size: 24,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 5), // Reduced vertical padding
      child: Column(
        children: [
          SizedBox(height: 5), // Moves Logout button slightly up
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginView()));
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(
                  horizontal: 30, vertical: 12), // Ensures balanced button size
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_state.dart';

// class ProfileView extends StatefulWidget {
//   const ProfileView({super.key});

//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneController;
//   AuthEntity? user;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//   }

//   Future<void> _fetchUserData() async {
//     final response =
//         await http.get(Uri.parse("${ApiEndpoints.baseUrl}/users/userdetails"));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         user = AuthEntity(
//           name: data['name'],
//           email: data['email'],
//           contactNo: data['contactNo'],
//           role: data['role'],
//           image: data['image'] ?? "",
//           password: data['password'],
//         );
//         _nameController = TextEditingController(text: user!.name);
//         _emailController = TextEditingController(text: user!.email);
//         _phoneController = TextEditingController(text: user!.contactNo);
//       });
//     }
//   }

//   Future<void> _updateUserProfile() async {
//     if (user == null) return;

//     final response = await http.put(
//       Uri.parse("${ApiEndpoints.baseUrl}/users/update/${user!.authId}"),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         "name": _nameController.text,
//         "email": _emailController.text,
//         "contactNo": _phoneController.text,
//       }),
//     );

//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Profile updated successfully!")),
//       );
//       _fetchUserData();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to update profile.")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: user == null
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 const SizedBox(height: 20),
//                 _buildProfileImage(user!),
//                 const SizedBox(height: 15),
//                 _buildUserInfoTile(Icons.person, "Name", _nameController),
//                 _buildUserInfoTile(Icons.email, "Email", _emailController),
//                 _buildUserInfoTile(Icons.phone, "Phone", _phoneController),
//                 _buildUserInfoTile(Icons.school, "Role",
//                     TextEditingController(text: getRoleLabel(user!.role))),
//                 const SizedBox(height: 30),
//                 _buildEditProfileButton(),
//                 const SizedBox(height: 10),
//                 _buildLogoutButton(),
//               ],
//             ),
//     );
//   }

//   String getRoleLabel(int role) {
//     switch (role) {
//       case 0:
//         return "Student";
//       case 2:
//         return "Instructor";
//       default:
//         return "Unknown Role";
//     }
//   }

//   Widget _buildProfileImage(AuthEntity user) {
//     String imageUrl = (user.image != null && user.image!.isNotEmpty)
//         ? "${ApiEndpoints.imageUrl}/${user.image}".trim()
//         : "https://via.placeholder.com/150";

//     return CircleAvatar(
//       radius: 50,
//       backgroundColor: Colors.grey.shade300,
//       backgroundImage: NetworkImage(imageUrl),
//     );
//   }

//   Widget _buildUserInfoTile(
//       IconData icon, String title, TextEditingController controller) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.pink.shade400),
//       title: Text(
//         title,
//         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//       ),
//       subtitle: TextField(
//         controller: controller,
//         decoration: const InputDecoration(border: InputBorder.none),
//       ),
//     );
//   }

//   Widget _buildEditProfileButton() {
//     return ElevatedButton.icon(
//       onPressed: _updateUserProfile,
//       icon: const Icon(Icons.save, color: Colors.white),
//       label: const Text("Save Changes"),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.pink.shade400,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       ),
//     );
//   }

//   Widget _buildLogoutButton() {
//     return TextButton.icon(
//       onPressed: () {
//         // Implement Logout Logic
//       },
//       icon: const Icon(Icons.logout, color: Colors.redAccent),
//       label: const Text(
//         "Logout",
//         style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
