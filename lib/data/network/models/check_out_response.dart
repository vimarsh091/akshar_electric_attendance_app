class CheckOutResponse {
  bool? isError;
  String? message;
  Data? data;

  CheckOutResponse({this.isError, this.message, this.data});

  CheckOutResponse.fromJson(Map<String, dynamic> json) {
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
