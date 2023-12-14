import 'package:flutter/material.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bhagavat_geeta/modules/settings/settings/presentations/setting_screen.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final bool hasBack;
  final bool showSettings;
  final String title;
  final Widget? leading;
  final double? leadingWidth;
  final bool centerTitle;
  final String lang;
  const AppScaffold({
    required this.body,
    this.title = "",
    this.lang = "en",
    this.hasBack = true,
    this.showSettings = true,
    this.leadingWidth,
    this.leading,
    this.centerTitle = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        centerTitle: centerTitle,
        leadingWidth: leadingWidth,
        titleSpacing: 0,
        leading: hasBack
            ? IconButton(
                onPressed: () {
                  context.navigationCubit.pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: context.appDesignForAction.isDarkMode
                      ? Colors.white
                      : const Color(0xFF343A3F),
                ),
              )
            : leading ?? Container(),
        actions: [
          if (showSettings)
            IconButton(
              onPressed: () {
                context.navigationCubit.push(AppPage(
                    page: MaterialPage(
                        child: SettingScreen(
                      lang: lang,
                    )),
                    path: ""));
              },
              icon: Icon(
                Icons.settings_outlined,
                color: context.appDesignForAction.isDarkMode
                    ? Colors.white
                    : Color(0xFF697077),
              ),
            )
        ],
        title: Text(
          title,
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: theme.colors.neutral.black,
          ),
        ),
      ),
      body: body,
    );
  }
}
