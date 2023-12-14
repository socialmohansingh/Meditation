import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bhagavat_geeta/app/design/widgets/screens/app_scaffold.dart';
import 'package:bhagavat_geeta/app/extension/audio_player.dart';
import 'package:bhagavat_geeta/modules/meditation_music/meditation_music_list/domain/model/meditation_music_model.dart';
import 'package:bhagavat_geeta/modules/meditation_music/play_meditation_music/presentation/play_meditation_music.dart';

class MeditationMusicScreen extends StatefulWidget {
  final DefaultTimer selectedTimer;
  const MeditationMusicScreen({required this.selectedTimer, super.key});

  @override
  State<MeditationMusicScreen> createState() => _MeditationMusicScreenState();
}

class _MeditationMusicScreenState extends State<MeditationMusicScreen> {
  int hour = 0;
  int minute = 0;
  bool showCustomTimer = false;
  DefaultTimer selectedTimer = DefaultTimer.defaults.first;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedTimer = widget.selectedTimer;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return AppScaffold(
      hasBack: false,
      title: "Meditation Music",
      leadingWidth: 88,
      leading: SizedBox(
        width: 65,
        child: InkWell(
          onTap: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 54),
                        height: showCustomTimer ? 277 : 480,
                        decoration: BoxDecoration(
                            color: context.appDesignForAction.isDarkMode
                                ? const Color(0xFF3F4553)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SizedBox(
                                height: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Set Timer Duration',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.urbanist().copyWith(
                                        color: !context
                                                .appDesignForAction.isDarkMode
                                            ? const Color(0xFF3F4553)
                                            : Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: !context
                                                .appDesignForAction.isDarkMode
                                            ? const Color(0xFF3F4553)
                                            : Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            for (DefaultTimer timer in DefaultTimer.defaults)
                              SizedBox(
                                height: 45,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context, 'Cancel');
                                      selectedTimer = timer;
                                      if (timer.isCustom) {
                                        showCustomTimerAlert(context);
                                      } else {
                                        updateTimerDuration(timer);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          selectedTimer.id == timer.id
                                              ? Icons.radio_button_on
                                              : Icons.radio_button_off,
                                          color: context
                                                  .appDesignForAction.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          timer.title,
                                          textAlign: TextAlign.center,
                                          style:
                                              GoogleFonts.urbanist().copyWith(
                                            color: !context.appDesignForAction
                                                    .isDarkMode
                                                ? const Color(0xFF3F4553)
                                                : Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Icon(
                Icons.history,
                color: context.appDesignForAction.isDarkMode
                    ? Colors.white
                    : const Color(0xFF697077),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                selectedTimer.value == 0
                    ? "N/A"
                    : _printDuration(
                        Duration(seconds: selectedTimer.value.round())),
                style: GoogleFonts.urbanist().copyWith(
                  color: context.appDesignForAction.isDarkMode
                      ? Colors.white
                      : const Color(0xFF697077),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 55,
              child: Stack(
                children: [
                  Container(
                    height: 48,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFDDE1E6)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  DesignTextField(
                    prefixIconData: Icons.search,
                    placeholderText: "Search",
                    decoration: const BoxDecoration(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: MeditationMusicMoodel.musics.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 164.0 / 108.0,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // ignore: unrelated_type_equality_checks
                      if (MeditationMusicMoodel.musics[index].id.toString() !=
                          MyPlayer.shared.getCurrentMusic()?.id) {
                        MyPlayer.shared.stopAudio();
                        MyPlayer.shared.setMusic(
                          MusicModel(
                              id: MeditationMusicMoodel.musics[index].id
                                  .toString(),
                              url: MeditationMusicMoodel.musics[index].audio,
                              musicType: "audio"),
                        );
                      }

                      context.navigationCubit.push(
                        AppPage(
                            page: MaterialPage(
                                child: PlayMeditationMusic(
                              music: MeditationMusicMoodel.musics[index],
                              selectedTimer: selectedTimer,
                            )),
                            path: ""),
                      );
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: MeditationMusicMoodel.musics[index].img,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.24),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          )),
                          Positioned(
                            left: 16,
                            right: 16,
                            bottom: 16,
                            child: Text(
                              MeditationMusicMoodel.musics[index].title,
                              style: GoogleFonts.urbanist().copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  showCustomTimerAlert(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 54),
                height: 277,
                decoration: BoxDecoration(
                    color: context.appDesignForAction.isDarkMode
                        ? const Color(0xFF3F4553)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 24,
                            ),
                            const Spacer(),
                            Text(
                              'Custom Timer',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist().copyWith(
                                color: !context.appDesignForAction.isDarkMode
                                    ? const Color(0xFF3F4553)
                                    : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 24,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Cancel');
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: !context.appDesignForAction.isDarkMode
                                      ? const Color(0xFF3F4553)
                                      : Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 235,
                        height: 80,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 117,
                              child: CupertinoPicker(
                                onSelectedItemChanged: (value) {
                                  hour = value;
                                },
                                itemExtent: 25,
                                diameterRatio: 1,
                                selectionOverlay:
                                    const CupertinoPickerDefaultSelectionOverlay(
                                  background: Colors.transparent,
                                ),
                                children: [
                                  for (int i = 0; i < 12; i++)
                                    Text(
                                      "$i",
                                      style: GoogleFonts.urbanist().copyWith(
                                          color: !context
                                                  .appDesignForAction.isDarkMode
                                              ? const Color(0xFF3F4553)
                                              : Colors.white),
                                    )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              width: 117,
                              child: CupertinoPicker(
                                onSelectedItemChanged: (value) {
                                  minute = value;
                                },
                                itemExtent: 25,
                                diameterRatio: 1,
                                selectionOverlay:
                                    const CupertinoPickerDefaultSelectionOverlay(
                                  background: Colors.transparent,
                                ),
                                children: [
                                  for (int i = 0; i < 60; i++)
                                    Text(
                                      "$i",
                                      style: GoogleFonts.urbanist().copyWith(
                                          color: !context
                                                  .appDesignForAction.isDarkMode
                                              ? const Color(0xFF3F4553)
                                              : Colors.white),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      '*Set time in HH:MM',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist().copyWith(
                        color: !context.appDesignForAction.isDarkMode
                            ? const Color(0xFF3F4553)
                            : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    InkWell(
                      onTap: () {
                        updateTimerDuration(DefaultTimer(
                            id: 2,
                            value: hour * 60 * 60 + minute * 60,
                            title: "Custom"));
                        Navigator.pop(context, 'Cancel');
                      },
                      child: Container(
                        width: 93,
                        height: 36,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFDFB160),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFDFB160)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Set Timer',
                              style: GoogleFonts.urbanist().copyWith(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  updateTimerDuration(DefaultTimer timer) async {
    selectedTimer = timer;
    setState(() {});
    await GetIt.I.get<BaseLocalStorage>().write("timer", "${timer.value}");
  }

  String _printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    if (duration.inHours <= 0) {
      return "$negativeSign$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
