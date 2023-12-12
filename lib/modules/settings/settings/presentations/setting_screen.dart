import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditation/app/configure/di.dart';
import 'package:meditation/app/constant/icon_constant.dart';
import 'package:meditation/app/design/widgets/screens/app_scaffold.dart';

class SettingScreen extends StatefulWidget {
  static List<AppPage> oldStatePages = [];
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isThemeExpanded = true;
  bool isDrakTheme = false;

  @override
  Widget build(BuildContext context) {
    isDrakTheme = context.appDesignForAction.isDarkMode;
    return AppScaffold(
      hasBack: true,
      showSettings: false,
      title: "Settings",
      body: SingleChildScrollView(
        child: Column(
          children: [
            getMenuItem(
              context,
              "Rate Us",
              Image.asset(
                isDrakTheme ? IconFile.starRateUsDark : IconFile.starRateUs,
                height: 24,
                width: 24,
                fit: BoxFit.contain,
              ),
              Container(),
            ),
            getMenuItem(
              context,
              "Share",
              Icon(
                Icons.share,
                color: context.appDesignForAction.isDarkMode
                    ? const Color(0xFFDDE1E6)
                    : const Color(0xFF697077),
              ),
              Container(),
            ),
            getMenuItem(
              context,
              "Privacy Policy",
              Icon(
                Icons.privacy_tip_outlined,
                color: context.appDesignForAction.isDarkMode
                    ? const Color(0xFFDDE1E6)
                    : const Color(0xFF697077),
              ),
              Container(),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isThemeExpanded = !isThemeExpanded;
                });
              },
              child: getMenuItem(
                context,
                "Theme",
                Icon(
                  Icons.color_lens_outlined,
                  color: context.appDesignForAction.isDarkMode
                      ? const Color(0xFFDDE1E6)
                      : const Color(0xFF697077),
                ),
                Image.asset(
                  isThemeExpanded ? IconFile.upArrow : IconFile.rightArrow,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            if (isThemeExpanded)
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: SizedBox(
                    height: 80,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            SettingScreen.oldStatePages =
                                context.navigationCubit.pages();
                            if (context.appDesignForAction.isDarkMode) {
                              context.appDesignForAction.toggleTheme();
                            }
                            setState(() {
                              isDrakTheme = false;
                            });
                          },
                          child: SizedBox(
                            height: 40,
                            child: getMenuItem(
                              context,
                              "Light (Default)",
                              Image.asset(
                                isDrakTheme
                                    ? IconFile.emptyRadio
                                    : IconFile.checkedRadio,
                                height: 24,
                                width: 24,
                                fit: BoxFit.contain,
                              ),
                              Container(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: InkWell(
                            onTap: () {
                              SettingScreen.oldStatePages =
                                  context.navigationCubit.pages();
                              if (!context.appDesignForAction.isDarkMode) {
                                context.appDesignForAction.toggleTheme();
                              }

                              setState(() {
                                isDrakTheme = true;
                              });
                            },
                            child: getMenuItem(
                              context,
                              "Dark",
                              Image.asset(
                                isDrakTheme
                                    ? IconFile.checkedRadioDark
                                    : IconFile.emptyRadio,
                                height: 24,
                                width: 24,
                                fit: BoxFit.contain,
                              ),
                              Container(),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            getMenuItem(
              context,
              "App Version",
              Image.asset(
                isDrakTheme ? IconFile.versionStackDark : IconFile.versionStack,
                height: 24,
                width: 24,
                fit: BoxFit.contain,
              ),
              Text(
                "v${AppDependencyContainer.version}",
                style: GoogleFonts.urbanist().copyWith(
                  color: context.appDesignForAction.isDarkMode
                      ? const Color(0xFFDDE1E6)
                      : const Color(0xFF697077),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getMenuItem(
    BuildContext context,
    String title,
    Widget image,
    Widget? rightWidget,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            image,
            const SizedBox(
              width: 16,
            ),
            Text(
              title,
              style: GoogleFonts.urbanist().copyWith(
                color: context.appDesignForAction.isDarkMode
                    ? const Color(0xFFDDE1E6)
                    : const Color(0xFF697077),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (rightWidget != null) rightWidget,
          ],
        ),
      ),
    );
  }
}
