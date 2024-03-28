import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:test_project/data/network/client/api_client.dart';
import 'package:test_project/data/network/client/api_provider.dart';
import 'package:test_project/data/network/models/user_response.dart';

/// User authentication related all api will be done here
class UserAuthRepository extends ApiProvider {
  Future<Either<String, String>?> forgotPasswordEmail(
      Map<String, dynamic> params) async {
    var response = await postMethod(ApiClient.forgotPasswordEmail, params,
        headerLangCode: 'en');
    return response?.fold((l) => Left(l), (r) => Right(r as String));
  }

  Future<Either<String, UserResponse>?> loginUser(
      Map<String, dynamic> params) async {
    var response = await postMethod<UserResponse>(ApiClient.loginUser, params,
        headerLangCode: 'en');
    return response?.fold((l) => Left(l), (r) => Right(r as UserResponse));
  }

  Future<Either<String, UserResponse>?> registerUser(
      Map<String, dynamic> params,
      {Map<String, File>? imageFiles}) async {
    var response = await postMethod<UserResponse>(
        ApiClient.registerUser, params,
        files: imageFiles);
    return response?.fold((l) => Left(l), (r) => Right(r as UserResponse));
  }

  Future<Either<String, String>?> passwordReset(Map<String, dynamic> params,
      {Map<String, File>? imageFiles}) async {
    var response =
        await postMethod(ApiClient.passwordReset, params, files: imageFiles);
    return response?.fold((l) => Left(l), (r) => Right(r as String));
  }

  Future<Either<String, UserResponse>?> socialLogin(
      Map<String, dynamic> params) async {
    var response = await postMethod<UserResponse>(ApiClient.socialLogin, params,
        headerLangCode: 'en');
    return response?.fold((l) => Left(l), (r) => Right(r as UserResponse));
  }
}
