import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:medication/app/design/brand/app_brand.dart';
import 'package:medication/modules/meditation_music/meditation_music_list/presentation/meditation_music_screen.dart';
import 'package:medication/modules/meditation_music/play_meditation_music/presentation/play_meditation_music.dart';
import 'package:medication/modules/onboarding/onboarding_screen.dart';
import 'package:medication/modules/settings/settings/presentations/setting_screen.dart';

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
      mode: ThemeMode.system,
      materialApp: (
        localeResolutionCallback,
        localizationsDelegates,
        supportedLocales,
        locale,
        theme,
      ) {
        return GestureDetector(
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
              DefaultTimer selectedTimer = DefaultTimer.defaults.first;
              final bool isSecondTimeOpen =
                  await GetIt.I.get<BaseLocalStorage>().read("isFirstOpen") ==
                      "0";
              final timerValue =
                  await GetIt.I.get<BaseLocalStorage>().read("timer");
              if (timerValue != null) {
                final timerDoubleValue = double.tryParse(timerValue) ?? 0;
                final index = DefaultTimer.defaults
                    .indexWhere((element) => element.value == timerDoubleValue);
                if (index >= 0) {
                  selectedTimer = DefaultTimer.defaults[index];
                } else if (timerDoubleValue >= 0) {
                  selectedTimer = DefaultTimer.defaults
                      .firstWhere((element) => element.value == -1);
                }
              }

              return SettingScreen.oldStatePages.isNotEmpty
                  ? SettingScreen.oldStatePages
                  : [
                      AppPage(
                          page: MaterialPage(
                            child: isSecondTimeOpen
                                ? MeditationMusicScreen(
                                    selectedTimer: selectedTimer,
                                  )
                                : OnboardingScreen(
                                    selectedTimer: selectedTimer,
                                  ),
                          ),
                          path: "")
                    ];
            },
            dependencyContainer: AppDependencyContainer(),
          ),
        );
      },
    );
  }
}
