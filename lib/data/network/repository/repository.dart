import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:test_project/data/network/client/api_client.dart';
import 'package:test_project/data/network/client/api_provider.dart';
import 'package:test_project/data/network/models/LoginResponse.dart';
import 'package:test_project/data/network/models/add_user_response.dart';
import 'package:test_project/data/network/models/get_me_response.dart';
import 'package:test_project/data/network/models/get_user_list.dart';

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

  Future<Either<String, AddUserResponse>?> addUser(
      Map<String, dynamic> params, File image) async {
    var response = await postMethod<AddUserResponse>(
        ApiClient.userDetail, params,
        files: {'image': image});
    return response?.fold((l) => Left(l), (r) {
      var result = AddUserResponse.fromJson(r);
      return Right(result);
    });
  }
}
