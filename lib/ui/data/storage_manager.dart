import 'package:get_storage/get_storage.dart';
import 'package:test_project/data/network/models/LoginResponse.dart';

class StorageManager {
  final box = GetStorage();

  static const user = 'user';
  static const todayPunchInTime = 'today_punch_in_time';

  static const authToken = 'auth_token';

  void setLoggedInUser(LoginResponse user) {
    box.write(StorageManager.user, user);
  }

  void setPunchInTime(String timeStamp) {
    box.write(StorageManager.todayPunchInTime, timeStamp);
  }

  String getLoggedInUser() {
    return box.read(StorageManager.user);
  }


  String? getPunchInTime() {
    return box.read(StorageManager.todayPunchInTime);
  }

  String? getAuthToken() {
    return box.read(StorageManager.authToken);
  }
  void setAuthToken(String token) {
     box.write(StorageManager.authToken,token);
  }
}
