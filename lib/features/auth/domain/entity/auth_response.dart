// class AuthResponse {
//   final String token;
//   final int role; // 0 = Student, 2 = Instructor

//   AuthResponse({required this.token, required this.role});

//   factory AuthResponse.fromJson(Map<String, dynamic> json) {
//     return AuthResponse(
//       token: json['token'] as String,
//       role: json['role'] as int, // Ensure role is parsed correctly
//     );
//   }
// }
