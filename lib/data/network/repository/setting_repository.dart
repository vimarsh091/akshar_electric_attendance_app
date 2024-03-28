import 'package:either_dart/either.dart';
import 'package:test_project/data/network/client/api_client.dart';
import 'package:test_project/data/network/client/api_provider.dart';
import 'package:test_project/data/network/models/app_version_response.dart';

/// Setting api will be done here
class SettingRepository extends ApiProvider {
  Future<Either<String, AppVersionResponse>?> getAppVersion(
      Map<String, dynamic> params) async {
    var response = await getMethod<AppVersionResponse>(ApiClient.appVersion,
        headerLangCode: 'en', query: params);
    return response?.fold(
        (l) => Left(l), (r) => Right(r as AppVersionResponse));
  }
}
