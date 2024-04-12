import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/data/network/client/api_client.dart';
import 'package:test_project/data/network/client/api_provider.dart';
import 'package:test_project/data/network/models/LoginResponse.dart';
import 'package:test_project/data/network/models/add_user_response.dart';
import 'package:test_project/data/network/models/common_response.dart';
import 'package:test_project/data/network/models/get_me_response.dart';
import 'package:test_project/data/network/models/get_user_list.dart';

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

/*  Future<Either<String, AddUserResponse>?> addUser(
      Map<String, dynamic> params, File image) async {
    var response = await postMethod<AddUserResponse>(
        ApiClient.userDetail, params,
        files: {'image': image});
    return response?.fold((l) => Left(l), (r) {
      var result = AddUserResponse.fromJson(r);
      return Right(result);
    });
  }*/

  Future<Either<String, AddUserResponse>?> addUser(
      {String? firstName,
      String? lastName,
      String? email,
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
      request.fields['email'] = email!;
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
        return Right(commonResponse as AddUserResponse);
      } else {
        return Left(commonResponse.message ?? '');
      }
    } catch (e) {
      return Left('Spmething went wrong');
    }

  }
}
