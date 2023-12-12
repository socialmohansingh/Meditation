import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:meditation/app/constant/image_constant.dart';
import 'package:meditation/modules/meditation_music/meditation_music_list/presentation/meditation_music_screen.dart';
import 'package:meditation/modules/meditation_music/play_meditation_music/presentation/play_meditation_music.dart';

class OnboardingScreen extends StatelessWidget {
  final DefaultTimer selectedTimer;
  const OnboardingScreen({required this.selectedTimer, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(ImageFile.splashScreen),
          Positioned(
            bottom: 66,
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
    await GetIt.I.get<BaseLocalStorage>().write("isFirstOpen", "0");
    // ignore: use_build_context_synchronously
    context.navigationCubit.root(
      AppPage(
        page: MaterialPage(
          child: MeditationMusicScreen(selectedTimer: selectedTimer),
        ),
        path: "",
      ),
    );
  }
}
