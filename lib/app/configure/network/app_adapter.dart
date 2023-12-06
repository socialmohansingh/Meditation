import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:flutter_netwok_module/flutter_netwok_module.dart';

class AppAdapter extends Adapter {
  @override
  Future<Result<NetworkFailure, NetworkResponseModel<T>>>
      onResponse<T extends Entity>(
          Result<NetworkFailure, NetworkResponseModel<T>> response,
          RequestApi api,
          NetworkClient client) async {
    response.fold((error) {
      if (error.statusCode == 401) {
        GlobalConnector.data.sendData(AuthorizationState(
            object: AuthorizationConnectionType.notAuthorized));
      }
    }, (data) => null);
    return response;
  }
}
