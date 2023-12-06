import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';

class AppDependencyContainer extends DependencyContainer {
  @override
  Future<void> init() async {
    try {
      GetIt.I.registerSingleton<BaseLocalStorage>(SecureLocalStorage());
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> dispose() async {
    GetIt.I.unregister(instance: SecureLocalStorage());
  }
}
