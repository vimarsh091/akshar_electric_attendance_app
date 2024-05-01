import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/data/network/client/api_client.dart';
import 'package:test_project/data/network/client/api_provider.dart';
import 'package:test_project/data/network/models/add_user_response.dart';
import 'package:test_project/data/network/models/check_in_response.dart';
import 'package:test_project/data/network/models/check_out_response.dart';
import 'package:test_project/data/network/models/common_response.dart';
import 'package:test_project/data/network/models/get_me_response.dart';
import 'package:test_project/data/network/models/get_total_working_hours_response.dart';
import 'package:test_project/data/network/models/get_user_list.dart';
import 'package:test_project/data/network/models/login_response.dart';
import 'package:test_project/data/network/models/site_status_response.dart';
import 'package:test_project/data/network/models/user_detail_response.dart';
import 'package:test_project/data/network/models/user_sites_response.dart';
import 'package:test_project/generated/locales.g.dart';

import '../../../ui/data/storage_manager.dart';

class Repository extends ApiProvider {
  Future<Either<String, LoginResponse>?> loginUser(
      Map<String, dynamic> params) async {
    var response = await postMethod<LoginResponse>(
      ApiClient.login,
      params,
    );
    return response?.fold((l) => Left(l), (r) {
      var loginResponse = LoginResponse.fromJson(r);
      return Right(loginResponse);
    });
  }

  Future<Either<String, GetMeResponse>?> getMe() async {
    var response = await getMethod(ApiClient.getLoggedInUserDetail);
    return response?.fold((l) => Left(l), (r) {
      var getMeResponse = GetMeResponse.fromJson(r);
      return Right(getMeResponse);
    });
  }

  Future<Either<String, CheckOutResponse>?> checkOut() async {
    var response = await putMethod(ApiClient.checkOut);
    return response?.fold((l) => Left(l), (r) {
      var result = CheckOutResponse.fromJson(r);
      return Right(result);
    });
  }

  Future<Either<String, SiteStatusResponse>?> getSiteStatus() async {
    var response = await getMethod(ApiClient.getStatus);
    return response?.fold((l) => Left(l), (r) {
      var result = SiteStatusResponse.fromJson(r);
      return Right(result);
    });
  }

  Future<Either<String, GetUserListResponse>?> getUserList(
      {String name = '', int? limit, int? page}) async {
    String url = ApiClient.userDetail;
    if (name.isNotEmpty) {
      url += '?name=$name&limit=$limit&page=$page';
    }
    url += '?limit=$limit&page=$page';

    var response = await getMethod(url);
    return response?.fold((l) => Left(l), (r) {
      var result = GetUserListResponse.fromJson(r);
      return Right(result);
    });
  }

  Future<Either<String, UserDetailsResponse>?> getUserDetails(
      {String? id}) async {
    String url = ApiClient.userDetail;

    url += '/$id';

    var response = await getMethod(url);
    return response?.fold((l) => Left(l), (r) {
      var result = UserDetailsResponse.fromJson(r);
      return Right(result);
    });
  }

  Future<Either<String, CommonResponse>?> deleteUser({String? id}) async {
    String url = ApiClient.userDetail;

    url += '/$id';

    var response = await deleteMethod(url);
    return response?.fold((l) => Left(l), (r) {
      var result = CommonResponse.fromJson(r);
      return Right(result);
    });
  }

  Future<Either<String, GetTotalWorkingHoursRespose>?> getTotalWorkingHoursData(
      {String? id, String? startDate, String? endDate}) async {
    String url = ApiClient.userDetail;

    url += '/$id/sites/hours?fromDate=$startDate&toDate=$endDate';

    var response = await getMethod(url);
    return response?.fold((l) => Left(l), (r) {
      var result = GetTotalWorkingHoursRespose.fromJson(r);
      return Right(result);
    });
  }

  Future<Either<String, UserSitesResponse>?> getUserSites(
      {String? id, int? page}) async {
    String url = ApiClient.userDetail;

    url += '/$id/sites?page=$page&limit=${20}';

    var response = await getMethod(url);
    return response?.fold((l) => Left(l), (r) {
      var result = UserSitesResponse.fromJson(r);
      return Right(result);
    });
  }

  Future<Either<String, CommonResponse>?> updateSiteDetails(
      {String? id,
      String? siteId,
      String? siteName,
      String? punchInTime,
      String? punchOutTime}) async {
    String url = ApiClient.userDetail;

    url +=
        '/$id/sites/$siteId?siteName=$siteName&checkIn=$punchInTime&checkOut=$punchOutTime';

    var response = await putMethod(url);
    return response?.fold((l) => Left(l), (r) {
      var result = CommonResponse.fromJson(r);
      return Right(result);
    });
  }

  Future<Either<String, AddUserResponse>?> addUser(
      {String? firstName,
      String? lastName,
      String? mobileNumber,
      File? image}) async {
    try {
      // Create a multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiClient.apiBaseUrl}${ApiClient.userDetail}'),
      );

      // Add image file to multipart
      request.files.add(
        await http.MultipartFile.fromPath(
          'avatar',
          image!.path,
        ),
      );

      request.fields['firstName'] = firstName!;
      request.fields['lastName'] = lastName!;
      request.fields['phone'] = mobileNumber!;

      // Add headers
      request.headers['accept'] = '*/*';
      request.headers['authorization'] = StorageManager().getAuthToken() ?? '';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Send request
      final streamedResponse = await request.send();

      // Get response
      final response = await http.Response.fromStream(streamedResponse);

      var commonResponse = CommonResponse.fromJson(jsonDecode(response.body));

      if (commonResponse.isError == false) {
        return Right(AddUserResponse.fromJson(jsonDecode(response.body)));
      } else {
        return Left(commonResponse.message ?? '');
      }
    } catch (e) {
      return Left(LocaleKeys.somethingWentWrong.tr);
    }
  }

  Future<Either<String, CheckInResponse>?> checkIn(
      {String? siteName, File? image}) async {
    try {
      // Create a multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiClient.apiBaseUrl}${ApiClient.checkIn}'),
      );

      // Add image file to multipart
      request.files.add(
        await http.MultipartFile.fromPath(
          'siteImage',
          image!.path,
        ),
      );

      request.fields['siteName'] = siteName!;

      // Add headers
      request.headers['accept'] = '*/*';
      request.headers['authorization'] = StorageManager().getAuthToken() ?? '';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Send request
      final streamedResponse = await request.send();

      // Get response
      final response = await http.Response.fromStream(streamedResponse);

      var commonResponse = CommonResponse.fromJson(jsonDecode(response.body));

      if (commonResponse.isError == false) {
        return Right(CheckInResponse.fromJson(jsonDecode(response.body)));
      } else {
        return Left(commonResponse.message ?? '');
      }
    } catch (e) {
      return Left(LocaleKeys.somethingWentWrong.tr);
    }
  }

  Future<Either<String, CommonResponse>?> updateUserDetails(
      {String? id,
      String? firstName,
      String? lastName,
      String? mobileNumber,
      File? image}) async {
    try {
      // Create a multipart request
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('${ApiClient.apiBaseUrl}${ApiClient.userDetail}/$id'),
      );

      // Add image file to multipart
      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'avatar',
            image.path,
          ),
        );
      }

      request.fields['firstName'] = firstName!;
      request.fields['lastName'] = lastName!;
      request.fields['phone'] = mobileNumber!;

      // Add headers
      request.headers['accept'] = '*/*';
      request.headers['authorization'] = StorageManager().getAuthToken() ?? '';
      request.headers['Content-Type'] = 'multipart/form-data';

      debugPrint(request.toString());
      // Send request
      final streamedResponse = await request.send();

      // Get response
      final response = await http.Response.fromStream(streamedResponse);

      var commonResponse = CommonResponse.fromJson(jsonDecode(response.body));

      if (commonResponse.isError == false) {
        return Right(commonResponse);
      } else {
        return Left(commonResponse.message ?? '');
      }
    } catch (e) {
      return Left(LocaleKeys.somethingWentWrong.tr);
    }
  }
}
