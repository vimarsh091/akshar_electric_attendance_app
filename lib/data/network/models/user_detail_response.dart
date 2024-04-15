class UserDetailsResponse {
  bool? isError;
  String? message;
  Data? data;

  UserDetailsResponse({this.isError, this.message, this.data});

  UserDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? id;
  String? firstName;
  String? lastName;
  String? avatar;
  String? email;
  String? phone;
  String? password;
  bool? isAdmin;

  Data(
      {this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.id,
        this.firstName,
        this.lastName,
        this.avatar,
        this.email,
        this.phone,
        this.password,
        this.isAdmin});

  Data.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    avatar = json['avatar'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
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
    data['password'] = this.password;
    data['isAdmin'] = this.isAdmin;
    return data;
  }
}
