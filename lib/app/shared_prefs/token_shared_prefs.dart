// import 'package:dartz/dartz.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';

// class TokenSharedPrefs {
//   final SharedPreferences _sharedPreferences;

//   TokenSharedPrefs(this._sharedPreferences);

//   Future<Either<Failure, void>> saveToken(String token) async {
//     try {
//       await _sharedPreferences.setString('token', token);
//       return Right(null);
//     } catch (e) {
//       return Left(SharedPrefsFailure(message: e.toString()));
//     }
//   }

//   Future<Either<Failure, String>> getToken() async {
//     try {
//       final token = _sharedPreferences.getString('token');
//       return Right(token ?? '');
//     } catch (e) {
//       return Left(SharedPrefsFailure(message: e.toString()));
//     }
//   }

//   Future<Either<Failure, void>> removeToken() async {
//     try {
//       await _sharedPreferences.remove('token');
//       return const Right(null);
//     } catch (e) {
//       return Left(SharedPrefsFailure(message: e.toString()));
//     }
//   }

//   Future<String?> getAuthIdFromSharedPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString("authId"); // 🔹 Ensure "authId" is saved at login
//   }
// }
















import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> removeToken() async {
    try {
      await _sharedPreferences.remove('token');
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<String?> getAuthIdFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("authId"); // 🔹 Ensure "authId" is saved at login
  }
}

class UserPreferences {
  static const String _keyUserRole = "userRole";

  /// ✅ Save user role
  static Future<void> saveUserRole(int role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserRole, role);
  }

  /// ✅ Retrieve user role (default to 0 if not set)
  static Future<int> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserRole) ?? 0;
  }

  /// ✅ Clear stored user role (for logout)
  static Future<void> clearUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserRole);
  }
}














// import 'package:dartz/dartz.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';

// class TokenSharedPrefs {
//   final SharedPreferences _sharedPreferences;

//   TokenSharedPrefs(this._sharedPreferences);

//   /// 🔹 **Save Token & Role**
//   Future<Either<Failure, void>> saveTokenAndRole(String token, int role) async {
//     try {
//       await _sharedPreferences.setString('token', token);
//       await _sharedPreferences.setInt('user_role', role); // Store Role
//       return Right(null);
//     } catch (e) {
//       return Left(SharedPrefsFailure(message: e.toString()));
//     }
//   }

//   /// 🔹 **Get Token**
//   Future<Either<Failure, String>> getToken() async {
//     try {
//       final token = _sharedPreferences.getString('token');
//       return Right(token ?? '');
//     } catch (e) {
//       return Left(SharedPrefsFailure(message: e.toString()));
//     }
//   }

//   /// 🔹 **Get Role**
//   Future<Either<Failure, int>> getUserRole() async {
//     try {
//       final role =
//           _sharedPreferences.getInt('user_role') ?? 0; // Default: Student (0)
//       return Right(role);
//     } catch (e) {
//       return Left(SharedPrefsFailure(message: e.toString()));
//     }
//   }

//   /// 🔹 **Remove Token & Role on Logout**
//   Future<Either<Failure, void>> removeTokenAndRole() async {
//     try {
//       await _sharedPreferences.remove('token');
//       await _sharedPreferences.remove('user_role'); // Remove Role
//       return const Right(null);
//     } catch (e) {
//       return Left(SharedPrefsFailure(message: e.toString()));
//     }
//   }

//   /// 🔹 **Get Auth ID**
//   Future<String?> getAuthIdFromSharedPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString("authId"); // 🔹 Ensure "authId" is saved at login
//   }
// }
