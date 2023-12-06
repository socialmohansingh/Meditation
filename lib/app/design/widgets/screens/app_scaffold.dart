import 'package:flutter/material.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medication/modules/settings/settings/presentations/setting_screen.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final bool hasBack;
  final bool showSettings;
  final String title;
  final Widget? leading;
  final double? leadingWidth;
  const AppScaffold({
    required this.body,
    this.title = "",
    this.hasBack = true,
    this.showSettings = true,
    this.leadingWidth,
    this.leading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: context.appDesignForAction.isDarkMode
          ? const Color(0xFF3C404A)
          : theme.colors.neutral.white,
      appBar: AppBar(
        backgroundColor: context.appDesignForAction.isDarkMode
            ? const Color(0xFF3C404A)
            : theme.colors.neutral.white,
        elevation: 0,
        centerTitle: !hasBack,
        leadingWidth: leadingWidth,
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
                    page: const MaterialPage(child: SettingScreen()),
                    path: ""));
              },
              icon: Icon(
                Icons.settings,
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
