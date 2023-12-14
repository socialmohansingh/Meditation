import 'package:bhagavat_geeta/modules/audiobook_music/music_list/presentation/music_list_cubit.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDependencyContainer extends DependencyContainer {
  static String version = "";
  @override
  Future<void> init() async {
    try {
      GetIt.I.registerSingleton<BaseLocalStorage>(SecureLocalStorage());
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      AppDependencyContainer.version = packageInfo.version;

      GetIt.instance.registerSingleton<MusicListCubit>(MusicListCubit());
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> dispose() async {
    GetIt.I.unregister(instance: SecureLocalStorage());
    GetIt.I.unregister(instance: MusicListCubit());
  }
}
