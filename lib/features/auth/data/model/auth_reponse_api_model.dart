// class AuthResponse {
//   final String token;
//   final int role; // Role from backend (0 = Student, 2 = Instructor)

//   AuthResponse({required this.token, required this.role});

//   // Factory constructor to parse JSON response from API
//   factory AuthResponse.fromJson(Map<String, dynamic> json) {
//     return AuthResponse(
//       token: json['token'] ?? '',
//       role: json['role'] ?? 0, // Default role is 0 (Student)
//     );
//   }

//   // Convert object to JSON (if needed for local storage)
//   Map<String, dynamic> toJson() {
//     return {
//       'token': token,
//       'role': role,
//     };
//   }
// }
