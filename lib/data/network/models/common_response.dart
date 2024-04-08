import 'package:test_project/data/network/models/app_version_response.dart';
import 'package:test_project/data/network/models/user_response.dart';

/*/// Common response model
class CommonResponse<T> {
  int? responseCode;
  String? message;
  dynamic data;

  CommonResponse({this.responseCode, this.message, this.data});

  bool get isSuccess => responseCode == 200;

  bool get isTokenExpired => responseCode == 401;

  CommonResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    message = json['message'];
    data = json.containsKey('data') && json['data'] != null
        ? getResponseData(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['responseCode'] = responseCode;
    dataMap['message'] = message;
    if (data != null) {
      dataMap['data'] = data!.toJson();
    }
    return dataMap;
  }

  @override
  String toString() {
    return 'CommonResponse{responseCode: $responseCode, message: $message, data: $data}';
  }

  /// To get response data either in list or models
  dynamic getResponseData(dynamic json) {
    if (json is List) {
      List<T> list = [];
      for (var element in json) {
        list.add(getModelValue(element));
      }
      return list;
    } else {
      return getModelValue(json);
    }
  }

  /// To retrieve generic specific model value from json
  dynamic getModelValue(dynamic json) {
    switch (T) {
      case UserResponse:
        return UserResponse.fromJson(json);
      case AppVersionResponse:
        return AppVersionResponse.fromJson(json);
    }
  }
}*/


/// Common response model
class CommonResponse<T> {
  bool? isError;
  String? message;
  dynamic data;

  CommonResponse({this.isError, this.message, this.data});

  bool get isSuccess => !isError!;

  bool get isTokenExpired => isError!;

  CommonResponse.fromJson(Map<String, dynamic> json) {
    isError = json['isError'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['isError'] = isError;
    dataMap['message'] = message;
    dataMap['data'] = data;
    return dataMap;
  }

  @override
  String toString() {
    return 'CommonResponse{isError: $isError, message: $message, data: $data}';
  }

  /// To get response data either in list or models
  dynamic getResponseData(dynamic json) {
    if (json == null) {
      return null;
    } else if (json is List) {
      List<T> list = [];
      for (var element in json) {
        list.add(getModelValue(element));
      }
      return list;
    } else {
      return getModelValue(json);
    }
  }

  /// To retrieve generic specific model value from json
  dynamic getModelValue(dynamic json) {
    switch (T) {
      case UserResponse:
        return UserResponse.fromJson(json);
      case AppVersionResponse:
        return AppVersionResponse.fromJson(json);
      default:
        return json;
    }
  }
}


