import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/data/network/client/api_client.dart';
import 'package:test_project/data/network/client/connectivity_manager.dart';
import 'package:test_project/generated/locales.g.dart';
import 'package:test_project/ui/data/storage_manager.dart';

import '../models/common_response.dart';

/// Define own methods of all types of api's. Like., GET, POST..etc
abstract class IApiProvider {
  Future<Either<String, dynamic>?> getMethod<T>(
    String url, {
    Map<String, dynamic>? query,
    String? headerLangCode,
  });

  Future<Either<String, dynamic>?> putMethod<T>(String url);

  Future<Either<String, dynamic>?> postMethod<T>(
    String url,
    dynamic body, {
    Progress? uploadProgress,
    Map<String, File>? files,
  });

  Future<Either<String, dynamic>?> deleteMethod<T>(
    String url,
  );

  Future<Either<String, dynamic>?> patchMethod<T>(
    String url,
    Map<String, dynamic> body, {
    String? headerLangCode,
  });
}

/// Common custom api provider with get connect
class ApiProvider extends GetConnect implements IApiProvider {
  @override
  void onInit() {
    httpClient.baseUrl = ApiClient.apiBaseUrl;
    httpClient.maxAuthRetries = 3;
  }

  @override
  Future<Either<String, dynamic>?> getMethod<T>(
    String url, {
    Map<String, dynamic>? query,
    String? headerLangCode,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        var result =
            await get(ApiClient.apiBaseUrl + url, query: query, headers: {
          'Accept': 'application/json',
          if (headerLangCode != null) ...{
            'Accept-Language': headerLangCode,
          },
          if (token != null) ...{
            'Authorization': 'Bearer $token',
          }
        });
        // Print response body and status code
        debugPrint('Responsebody :- ${result.body}');
        var commonResponse = CommonResponse<T>.fromJson(result.body);

        if (commonResponse.isError == false) {
          return Right(result.body);
        } else {
          return Left(commonResponse.message ?? '');
        }
      } else {
        return Left(LocaleKeys.checkYourInternetConnection.tr);
      }
    } catch (e, s) {
      debugPrint('$e \n $s');
      return Left(LocaleKeys.somethingWentWrong.tr);
    }
  }

  @override
  Future<Either<String, dynamic>?> postMethod<T>(
    String url,
    dynamic body, {
    Progress? uploadProgress,
    Map<String, File>? files,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        dynamic formData;
        if (files != null) {
          formData = FormData({
            ...body,
          });
          files.forEach((key, value) {
            String fileName = value.path.split('/').last;
            formData.files
                .add(MapEntry(key, MultipartFile(value, filename: fileName)));
          });
        } else {
          formData = body;
        }

        var result = await post(ApiClient.apiBaseUrl + url, formData,
            uploadProgress: uploadProgress,
            headers: {
              'accept': '*/*',
              'Content-Type': 'application/json',
              if (token != null) ...{
                'Authorization': 'Bearer $token',
              }
            });

        // Print response body and status code
        debugPrint('Responsebody :- ${result.body}');
        var commonResponse = CommonResponse<T>.fromJson(result.body);

        if (commonResponse.isError == false) {
          return Right(result.body);
        } else {
          return Left(commonResponse.message ?? '');
        }
      } else {
        return Left(LocaleKeys.checkYourInternetConnection.tr);
      }
    } catch (e, s) {
      debugPrint('$e \n $s');
      return Left(LocaleKeys.somethingWentWrong.tr);
    }
  }

  @override
  Future<Either<String, dynamic>?> deleteMethod<T>(String url) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        var result = await delete(ApiClient.apiBaseUrl + url, headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          if (token != null) ...{
            'Authorization': 'Bearer $token',
          }
        });
        // Print response body and status code
        debugPrint('Responsebody :- ${result.body}');
        var commonResponse = CommonResponse<T>.fromJson(result.body);

        if (commonResponse.isError == false) {
          return Right(result.body);
        } else {
          return Left(commonResponse.message ?? '');
        }
      } else {
        return Left(LocaleKeys.checkYourInternetConnection.tr);
      }
    } catch (e, s) {
      debugPrint('$e \n $s');
      return Left(LocaleKeys.somethingWentWrong.tr);
    }
  }

  @override
  Future<Either<String, dynamic>?> patchMethod<T>(
      String url, Map<String, dynamic> body,
      {String? headerLangCode}) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        var result = await patch(ApiClient.apiBaseUrl + url, body, headers: {
          'Accept': 'application/json',
          if (headerLangCode != null) ...{
            'Accept-Language': headerLangCode,
          },
          if (token != null) ...{
            'Authorization': 'Bearer $token',
          }
        });
        // Print response body and status code
        debugPrint('Responsebody :- ${result.body}');
        var commonResponse = CommonResponse<T>.fromJson(result.body);

        if (commonResponse.isError == false) {
          return Right(result.body);
        } else {
          return Left(commonResponse.message ?? '');
        }
      } else {
        return Left(LocaleKeys.checkYourInternetConnection.tr);
      }
    } catch (e, s) {
      debugPrint('$e \n $s');
      return Left(LocaleKeys.somethingWentWrong.tr);
    }
  }

  @override
  Future<Either<String, dynamic>?> putMethod<T>(String url) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        var result = await get(ApiClient.apiBaseUrl + url, headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          if (token != null) ...{
            'Authorization': 'Bearer $token',
          }
        });
        // Print response body and status code
        debugPrint('Responsebody :- ${result.body}');
        var commonResponse = CommonResponse<T>.fromJson(result.body);

        if (commonResponse.isError == false) {
          return Right(result.body);
        } else {
          return Left(commonResponse.message ?? '');
        }
      } else {
        return Left(LocaleKeys.checkYourInternetConnection.tr);
      }
    } catch (e, s) {
      debugPrint('$e \n $s');
      return Left(LocaleKeys.somethingWentWrong.tr);
    }
  }
}
