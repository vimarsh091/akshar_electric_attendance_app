/// All api endpoints are defined here
class ApiClient {
  ApiClient._();

  static const String apiBaseUrl = 'https://aksharelect.com/api/';
  static const String login = 'v1/auth/login';
  static const String checkIn = 'v1/site/check-in';
  static const String checkOut = 'v1/site/check-out';
  static const String getStatus = 'v1/site/status';
  static const String getLoggedInUserDetail = 'v1/users/me';
  static const String userDetail = 'v1/admin/users';
}
