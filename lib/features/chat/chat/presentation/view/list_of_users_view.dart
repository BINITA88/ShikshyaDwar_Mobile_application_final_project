import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';

import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/chat/chat/presentation/view/chat_view.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  String _searchQuery = "";
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(GetAllUsersRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 12),
            _buildSearchBar(),
            Expanded(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoadingUsers) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AuthUsersFailure) {
                    return Center(child: Text("Error: ${state.message}"));
                  } else if (state is AuthUsersLoaded) {
                    final filteredUsers = state.users
                        .where((user) => user.email
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                        .toList();

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        return UserTile(
                          user: filteredUsers[index],
                          onTap: () => _navigateToChatScreen(
                              context, filteredUsers[index]),
                        );
                      },
                    );
                  }
                  return const Center(
                      child: Text("No users found.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 19, 18, 18))));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 **Search Bar**
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        onChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
        style: TextStyle(color: const Color.fromARGB(255, 15, 15, 15)),
        decoration: InputDecoration(
          hintText: "Search users...",
          hintStyle: TextStyle(color: const Color.fromARGB(255, 17, 17, 17)),
          prefixIcon:
              Icon(Icons.search, color: const Color.fromARGB(255, 216, 96, 27)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 14, 14, 14),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 31, 29, 30),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 15, 15, 15),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 **Navigate to Chat Screen**
  void _navigateToChatScreen(BuildContext context, AuthEntity user) {
    if (_isNavigating) return; // Prevent multiple navigation taps
    _isNavigating = true;

    // Generate guest ID if the user is not logged in
    final guestId = "guest_${user.authId}";
    final senderId =
        guestId; // You can replace this with logged-in user ID if available

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          receiverId: user.authId!,
          receiverUsername: user.name,
          receiverImage: user.image ?? '',
          key: ValueKey(user.authId!),
        ),
      ),
    ).then((_) {
      _isNavigating = false;
    });
  }
}

/// 🔹 **User Tile Component**
class UserTile extends StatelessWidget {
  final AuthEntity user;
  final VoidCallback onTap;

  const UserTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.shade100.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: Colors.pink.shade50,
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildAvatar(user),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 14, 14, 14),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chat,
                  color: Colors.pink.shade700,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//   Widget _buildAvatar(AuthEntity user) {
//     String fullImageUrl = (user.image != null && user.image!.isNotEmpty)
//         ? "${ApiEndpoints.imageUrl}/${user.image}"
//         : "https://via.placeholder.com/150";

//     print("User Image URL: $fullImageUrl"); // Debugging

//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.black, width: 1),
//         boxShadow: [
//           BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5)
//         ],
//         image: DecorationImage(
//           fit: BoxFit.cover,
//           image: NetworkImage(fullImageUrl),
//         ),
//       ),
//     );
//   }
// }

Widget _buildAvatar(AuthEntity user) {
  // List of static user images (at least 5)
  List<String> userImages = [
    "assets/images/pro.jpg",
    "assets/images/pro.jpg",
    "assets/images/images1.jpg",
    "assets/images/images1.jpg",
    "assets/images/images1.jpg",
  ];

  // Assign a random or cyclic image to each user
  int index = user.authId.hashCode % userImages.length;
  String selectedImage = userImages[index];

  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.black, width: 1),
      boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5)
      ],
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(selectedImage), // Assigning a user image dynamically
      ),
    ),
  );
}


//   Widget _buildAvatar(AuthEntity user) {
//     String fullImageUrl = (user.image != null && user.image!.isNotEmpty)
//         ? "${ApiEndpoints.imageUrl}/${user.image}".trim() // Trim spaces
//         : "https://via.placeholder.com/150";
//     print("User Image URL: '$fullImageUrl'"); // Debugging

//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.black, width: 1),
//         boxShadow: [
//           BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5),
//         ],
//         image: DecorationImage(
//           fit: BoxFit.cover,
//           image: NetworkImage(fullImageUrl),
//           onError: (exception, stackTrace) {
//             print("Error loading image: $exception"); // Debugging error
//           },
//         ),
//       ),
//     );
//   }
// }

  /// 🔹 **User Avatar**
  // Widget _buildAvatar(AuthEntity user) {
  //   return Container(
  //     width: 5s0,
  //     height: 50,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       border: Border.all(
  //         color: const Color.fromARGB(255, 77, 70, 70),
  //         width: 1,
  //       ),
  //       boxShadow: [
  //         BoxShadow(
  //           color: const Color.fromARGB(255, 211, 122, 143).withOpacity(0.3),
  //           blurRadius: 8,
  //           spreadRadius: 1,
  //         ),
  //       ],
  //       image: DecorationImage(
  //         fit: BoxFit.cover,
  //         image: (user.image?.isNotEmpty ?? false)
  //             ? NetworkImage("${ApiEndpoints.imageUrl}/${user.image!}")
  //             : const AssetImage("assets/images/c2.png") as ImageProvider,
  //       ),
  //     ),
  //   );
  // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/chat/chat/presentation/view/chat_view.dart';

// class UserListScreen extends StatefulWidget {
//   const UserListScreen({super.key});

//   @override
//   State<UserListScreen> createState() => _UserListScreenState();
// }

// class _UserListScreenState extends State<UserListScreen> {
//   String _searchQuery = "";
//   bool _isNavigating = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<AuthBloc>().add(GetAllUsersRequested());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.pink.shade50, // Light pink at the top
//               Colors.white, // White at the bottom
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             _buildSearchBar(),
//             Expanded(
//               child: BlocBuilder<AuthBloc, AuthState>(
//                 builder: (context, state) {
//                   if (state is AuthLoadingUsers) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: Color(0xFF3498DB),
//                         strokeWidth: 3,
//                       ),
//                     );
//                   } else if (state is AuthUsersFailure) {
//                     return _buildErrorWidget(state.message);
//                   } else if (state is AuthUsersLoaded) {
//                     final filteredUsers = state.users
//                         .where((user) => user.email
//                             .toLowerCase()
//                             .contains(_searchQuery.toLowerCase()))
//                         .toList();

//                     if (filteredUsers.isEmpty) {
//                       return _buildNoUsersFoundWidget();
//                     }

//                     return ListView.builder(
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: filteredUsers.length,
//                       itemBuilder: (context, index) {
//                         return UserTile(
//                           user: filteredUsers[index],
//                           onTap: () => _navigateToChatScreen(
//                               context, filteredUsers[index]),
//                         );
//                       },
//                     );
//                   }
//                   return const Center(
//                     child: Text(
//                       "No users available",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Search Bar Widget
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: TextField(
//         onChanged: (query) {
//           setState(() {
//             _searchQuery = query;
//           });
//         },
//         style: const TextStyle(color: Color(0xFF2C3E50)),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           hintText: "Search users...",
//           prefixIcon: const Icon(Icons.search, color: Color(0xFF3498DB)),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }

//   /// Error Widget
//   Widget _buildErrorWidget(String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.error, color: Color(0xFFE74C3C), size: 70),
//           const SizedBox(height: 16),
//           const Text(
//             "Error Loading Users",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Text(message, style: TextStyle(color: Colors.grey[700])),
//         ],
//       ),
//     );
//   }

//   /// No Users Found Widget
//   Widget _buildNoUsersFoundWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: const [
//           Icon(Icons.person_off, color: Color(0xFF3498DB), size: 70),
//           SizedBox(height: 16),
//           Text(
//             "No Users Found",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Navigate to Chat Screen
//   void _navigateToChatScreen(BuildContext context, AuthEntity user) {
//     if (_isNavigating) return;
//     _isNavigating = true;

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ChatScreen(
//           receiverId: user.authId!,
//           receiverUsername: user.name,
//           receiverImage: user.image ?? '',
//         ),
//       ),
//     ).then((_) => _isNavigating = false);
//   }
// }

// /// User Tile Component
// class UserTile extends StatelessWidget {
//   final AuthEntity user;
//   final VoidCallback onTap;

//   const UserTile({super.key, required this.user, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundImage: user.image?.isNotEmpty ?? false
//             ? NetworkImage("${ApiEndpoints.imageUrl}/${user.image}")
//             : const AssetImage("assets/images/c2.png") as ImageProvider,
//       ),
//       title:
//           Text(user.name, style: const TextStyle(fontWeight: FontWeight.w600)),
//       trailing: IconButton(
//         icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFF3498DB)),
//         onPressed: onTap,
//       ),
//     );
//   }
// }
