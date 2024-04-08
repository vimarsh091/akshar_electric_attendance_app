import 'package:either_dart/either.dart';
import 'package:test_project/data/network/client/api_client.dart';
import 'package:test_project/data/network/client/api_provider.dart';
import 'package:test_project/data/network/models/LoginResponse.dart';

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
}
