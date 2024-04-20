class LoginResponse {
  bool? isError;
  String? message;
  Data? data;

  LoginResponse({this.isError, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    isError = json['isError'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isError'] = this.isError;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? id;
  String? firstName;
  String? lastName;
  String? avatar;
  String? email;
  String? phone;
  bool? isAdmin;

  User(
      {this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.id,
        this.firstName,
        this.lastName,
        this.avatar,
        this.email,
        this.phone,
        this.isAdmin});

  User.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    avatar = json['avatar'];
    email = json['email'];
    phone = json['phone'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['isAdmin'] = this.isAdmin;
    return data;
  }
}
