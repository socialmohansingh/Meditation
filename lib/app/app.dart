import 'package:bhagavat_geeta/modules/audiobook_music/music_list/presentation/music_list.dart';
import 'package:bhagavat_geeta/modules/audiobook_music/music_list/presentation/music_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:bhagavat_geeta/app/design/brand/app_brand.dart';
import 'package:bhagavat_geeta/modules/onboarding/onboarding_screen.dart';
import 'package:bhagavat_geeta/modules/settings/settings/presentations/setting_screen.dart';

import 'configure/di.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FlutterDesignApp(
      brand: AppBrand(),
      mode: ThemeMode.light,
      materialApp: (
        localeResolutionCallback,
        localizationsDelegates,
        supportedLocales,
        locale,
        theme,
      ) {
        return BlocProvider(
          create: (context) => GetIt.instance.get<MusicListCubit>(),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: FlutterModule.buildRootRouter(
              builder: (routerDelegate, routeInformationParser, context) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  localeResolutionCallback: localeResolutionCallback,
                  localizationsDelegates: localizationsDelegates,
                  supportedLocales: supportedLocales,
                  locale: locale,
                  theme: theme,
                  routerDelegate: routerDelegate,
                  routeInformationParser: routeInformationParser,
                );
              },
              onWillPop: (nav) async {
                nav.pop();
                return true;
              },
              rootPages: () async {
                final lang = await GetIt.I.get<BaseLocalStorage>().read("lang");
                return SettingScreen.oldStatePages.isNotEmpty
                    ? SettingScreen.oldStatePages
                    : [
                        AppPage(
                            page: MaterialPage(
                              child: lang != null
                                  ? MusicList(oldLang: lang)
                                  : OnboardingScreen(
                                      lang: lang ?? "en",
                                    ),
                            ),
                            path: "")
                      ];
              },
              dependencyContainer: AppDependencyContainer(),
            ),
          ),
        );
      },
    );
  }
}
