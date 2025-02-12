class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 10000);
  static const Duration receiveTimeout = Duration(seconds: 10000);

  // For Android Emulator
  static const String baseUrl = "http://10.0.2.2:9000/api/";

  // ============= Auth Routes =============
  // static const String login = "users/signin1";
  // static const String register = "users/register1";
  static const String login = "users/login";
  static const String register = "users/signup";
  static const String sendotp = "users/sendotp";
  static const String getAllStudent = "users/userlist";
  static const String postEmailConfirmation = "/users/confirmation/:token";
  static const String deleteStudent = "users/deleteUser/:id";
  static const String imageUrl = "  http://10.0.2.2:9000/public/uploads/";

  // ask ....
  static const String uploadImage = "users/uploadImage";

  static const String getAllCourses = "/productlist";

  // ====================== Course Routes ======================
  static const String getCourseDetailById = "/productDetail/";

  static const String getAllCourse = "/productlist";

  static const String uploadCourseImage = "users/postproduct";
}




// internet connectivity afai garni 

