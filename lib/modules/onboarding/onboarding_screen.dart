import 'package:bhagavat_geeta/modules/settings/lang_screen/lang_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:bhagavat_geeta/app/constant/image_constant.dart';

class OnboardingScreen extends StatelessWidget {
  final String lang;
  const OnboardingScreen({required this.lang, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(ImageFile.splashScreen),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 68,
                height: 68,
                child: TextButton(
                  onPressed: () {
                    updateOnboardingScreen(context);
                  },
                  child: const Text(""),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  updateOnboardingScreen(BuildContext context) async {
    // ignore: use_build_context_synchronously
    context.navigationCubit.root(
      AppPage(
        page: MaterialPage(
          child: LangScreen(lang: lang),
        ),
        path: "",
      ),
    );
  }
}
