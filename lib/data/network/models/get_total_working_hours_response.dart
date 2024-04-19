class GetTotalWorkingHoursRespose {
  bool? isError;
  String? message;
  Data? data;

  GetTotalWorkingHoursRespose({this.isError, this.message, this.data});

  GetTotalWorkingHoursRespose.fromJson(Map<String, dynamic> json) {
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
  String? totalHours;

  Data({this.totalHours});

  Data.fromJson(Map<String, dynamic> json) {
    totalHours = json['totalHours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalHours'] = this.totalHours;
    return data;
  }
}
