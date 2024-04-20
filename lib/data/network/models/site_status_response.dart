class SiteStatusResponse {
  bool? isError;
  String? message;
  Data? data;

  SiteStatusResponse({this.isError, this.message, this.data});

  SiteStatusResponse.fromJson(Map<String, dynamic> json) {
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
  String? action;
  Status? status;

  Data({this.action, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class Status {
  String? siteName;
  String? siteImage;
  String? date;
  String? checkIn;
  String? checkOut;
  String? totalTime;

  Status(
      {this.siteName,
        this.siteImage,
        this.date,
        this.checkIn,
        this.checkOut,
        this.totalTime});

  Status.fromJson(Map<String, dynamic> json) {
    siteName = json['siteName'];
    siteImage = json['siteImage'];
    date = json['date'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    totalTime = json['totalTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteName'] = this.siteName;
    data['siteImage'] = this.siteImage;
    data['date'] = this.date;
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['totalTime'] = this.totalTime;
    return data;
  }
}
