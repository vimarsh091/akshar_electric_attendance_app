class UserResponse {
  User? user;
  bool? isAlreadyLoggedIn;
  String? token;

  UserResponse({this.user, this.isAlreadyLoggedIn, this.token});

  UserResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    isAlreadyLoggedIn = json['is_already_logged_in'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['is_already_logged_in'] = isAlreadyLoggedIn;
    data['token'] = token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? mobileVerifiedAt;
  String? isdCode;
  String? mobile;

  User({this.id, this.name, this.email, this.mobileVerifiedAt, this.isdCode, this.mobile});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileVerifiedAt = json['mobile_verified_at'];
    isdCode = json['isd_code'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile_verified_at'] = mobileVerifiedAt;
    data['isd_code'] = isdCode;
    data['mobile'] = mobile;
    return data;
  }
}
