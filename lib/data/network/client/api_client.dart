/// All api endpoints are defined here
class ApiClient {
  ApiClient._();

  static const String apiBaseUrl = 'http://192.168.156.175:9000/';

  static const String appVersion = '/settings/app-version';
  static const String contentPages = '/content-pages';
  static const String forgotPasswordEmail = '/password/email';
   static const String registerUser = '/register';
  static const String passwordReset = '/password/reset';
  static const String socialLogin = '/social-login';
  static const String logoutUser = '/logout';
  static const String logoutUserFromOther = '/past/logout';
  static const String sendOtp = '/send-otp';
  static const String updateLocale = '/update-locale';
  static const String updateMobile = '/update-mobile';
  static const String updatePassword = '/update-password';
  static const String verifyOtp = '/verify-otp';





  static const String login = 'api/v1/auth/login';
  static const String checkIn = 'api/v1/site/check-in';
  static const String checkOut = 'api/v1/site/check-out';
  static const String getStatus = 'api/v1/site/status';
  static const String getLoggedInUserDetail = 'api/v1/users/me';
  static const String userDetail = 'api/v1/admin/users';


}
