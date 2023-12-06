import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_netwok_module/flutter_netwok_module.dart';

class MyAppInterceptor extends AppInterceptor {
  @override
  Future<Result<NetworkFailure, RequestApi>> onRequest(
      RequestApi api, NetworkClient client) async {
    if (api.shouldRequireAccessToken) {
      final token = await GetIt.I.get<BaseLocalStorage>().read("token");
      api.headers?["jwt"] = token ?? "";
    }
    api.headers?["Content-Type"] = "Application/json";
    return Success(api);
  }
}
