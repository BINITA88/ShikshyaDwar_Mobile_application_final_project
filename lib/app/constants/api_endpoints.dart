class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // For Android Emulator
  static const String baseUrl = "http://10.0.2.2:9000/api/";
  // static const String baseUrl = "http://192.168.1.82:9000/api/";
  // http://192.168.1.82:9000/api/users/signup

  // ============= Auth Routes =============
  // static const String login = "users/signin1";
  // static const String register = "users/register1";
  static const String login = "users/login";
  static const String register = "users/signup";
  static const String sendotp = "users/sendotp";
  static const String getAllStudent = "users/userlist";
  static const String postEmailConfirmation = "/users/confirmation/:token";
  static const String deleteStudent = "users/deleteUser/:id";
  // static const String imageUrl = "http://10.0.2.2:9000/uploads/";
  static const String imageUrl = "  http://10.0.2.2:9000/public/profile";
// ===================== ✅ Password Routes =====================
  static const String forgotPassword = "users/forgot-password";
  static const String resetPassword = "users/reset-password";

  // ask ....
  static const String uploadImage = "users/uploadImage";

  static const String getAllCourses = "/productlist";
  static const String getCurrentUser = "user/userdetails";
  // ====================== Chatting ======================

  static const String getAllUsers = "users/userlist";

  static const String sendMessage = "messages/send/";
  static const String getMessages = "/messages/";
  static const String deleteMessage = "/messages/";

  // ====================== Course Routes ======================
  static const String getCourseDetailById = "/productDetail/";

  static const String getAllCourse = "/productlist";
  static const String courseImageUrl = "  http://10.0.2.2:9000/public/uploads";
  static const String uploadCourseImage = "users/postproduct";

  // ====================== Booking Routes ======================
  static const String courseBooking = "/postbooking/";

  // ====================== Notice ======================
  static const String getnotice = "/notifications/";

  // ====================== Routine ======================
  static const String getroutine = "schedules/getschedule/";

  // ====================== Routine ======================
  static const String bookExamSeat = "seat/status/";
  static const String getExamSeats = "seat/";
}




// internet connectivity afai garni 

