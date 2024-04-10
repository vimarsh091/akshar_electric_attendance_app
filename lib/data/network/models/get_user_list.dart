class GetUserListResponse {
  bool? isError;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  GetUserListResponse({this.isError, this.message, this.data, this.pagination});

  GetUserListResponse.fromJson(Map<String, dynamic> json) {
    isError = json['isError'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isError'] = this.isError;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
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

class Pagination {
  int? pageNr;
  int? limit;
  int? offset;
  int? total;

  Pagination({this.pageNr, this.limit, this.offset, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    pageNr = json['pageNr'];
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNr'] = this.pageNr;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['total'] = this.total;
    return data;
  }
}
