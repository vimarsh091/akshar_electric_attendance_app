class UserSitesResponse {
  bool? isError;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  UserSitesResponse({this.isError, this.message, this.data, this.pagination});

  UserSitesResponse.fromJson(Map<String, dynamic> json) {
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
  String? siteName;
  String? siteImage;
  String? date;
  String? checkIn;
  String? checkOut;
  String? totalTime;
  String? userId;

  Data(
      {this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.id,
        this.siteName,
        this.siteImage,
        this.date,
        this.checkIn,
        this.checkOut,
        this.totalTime,
        this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    id = json['id'];
    siteName = json['siteName'];
    siteImage = json['siteImage'];
    date = json['date'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    totalTime = json['totalTime'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['id'] = this.id;
    data['siteName'] = this.siteName;
    data['siteImage'] = this.siteImage;
    data['date'] = this.date;
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['totalTime'] = this.totalTime;
    data['userId'] = this.userId;
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
