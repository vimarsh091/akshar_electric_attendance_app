class CheckInResponse {
  bool? isError;
  String? message;
  Data? data;

  CheckInResponse({this.isError, this.message, this.data});

  CheckInResponse.fromJson(Map<String, dynamic> json) {
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
  String? siteName;
  String? siteImage;
  String? checkIn;
  String? userId;
  String? checkOut;
  String? totalTime;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? id;
  String? date;

  Data(
      {this.siteName,
        this.siteImage,
        this.checkIn,
        this.userId,
        this.checkOut,
        this.totalTime,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.id,
        this.date});

  Data.fromJson(Map<String, dynamic> json) {
    siteName = json['siteName'];
    siteImage = json['siteImage'];
    checkIn = json['checkIn'];
    userId = json['userId'];
    checkOut = json['checkOut'];
    totalTime = json['totalTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    id = json['id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteName'] = this.siteName;
    data['siteImage'] = this.siteImage;
    data['checkIn'] = this.checkIn;
    data['userId'] = this.userId;
    data['checkOut'] = this.checkOut;
    data['totalTime'] = this.totalTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['id'] = this.id;
    data['date'] = this.date;
    return data;
  }
}
