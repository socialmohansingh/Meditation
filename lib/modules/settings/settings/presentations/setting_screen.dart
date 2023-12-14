import 'package:bhagavat_geeta/modules/audiobook_music/music_list/presentation/music_list_cubit.dart';
import 'package:bhagavat_geeta/modules/audiobook_music/music_list/presentation/music_list_state.dart';
import 'package:bhagavat_geeta/modules/settings/lang_screen/lang_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bhagavat_geeta/app/configure/di.dart';
import 'package:bhagavat_geeta/app/constant/icon_constant.dart';
import 'package:bhagavat_geeta/app/design/widgets/screens/app_scaffold.dart';

class SettingScreen extends StatefulWidget {
  String lang;
  static List<AppPage> oldStatePages = [];
  SettingScreen({required this.lang, super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isThemeExpanded = true;
  bool isDrakTheme = false;

  @override
  Widget build(BuildContext context) {
    isDrakTheme = context.appDesignForAction.isDarkMode;
    return BlocListener<MusicListCubit, MusicListState>(
      listener: (context, state) {
        if (state is MusicListUpdateLanguage) {
          widget.lang = state.lang;
        }
      },
      child: AppScaffold(
        hasBack: true,
        showSettings: false,
        lang: widget.lang,
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
                  context.navigationCubit.push(
                    AppPage(
                      page: MaterialPage(
                        child: LangScreen(
                          lang: widget.lang,
                          fromSetting: true,
                        ),
                      ),
                      path: "",
                    ),
                  );
                },
                child: getMenuItem(
                  context,
                  "Change Language",
                  Image.asset(
                    IconFile.langTranslate,
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                  Container(),
                ),
              ),
              getMenuItem(
                context,
                "App Version",
                Image.asset(
                  isDrakTheme
                      ? IconFile.versionStackDark
                      : IconFile.versionStack,
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
