/// All api endpoints are defined here
class ApiClient {
  ApiClient._();

  static const String apiBaseUrl = 'https://dev2.spaceo.in/project/l9_basecode/public/api';

  static const String appVersion = '/settings/app-version';
  static const String contentPages = '/content-pages';

  static const String forgotPasswordEmail = '/password/email';
  static const String loginUser = '/login';
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


}
