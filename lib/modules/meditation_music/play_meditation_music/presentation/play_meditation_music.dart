import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medication/app/constant/icon_constant.dart';
import 'package:medication/app/extension/audio_player.dart';
import 'package:medication/modules/meditation_music/meditation_music_list/domain/model/meditation_music_model.dart';
import 'package:medication/modules/meditation_music/play_meditation_music/presentation/progress_notifier.dart';
import 'package:medication/modules/settings/settings/presentations/setting_screen.dart';

class DefaultTimer {
  int id;
  double value;
  String title;
  bool isCustom;

  DefaultTimer(
      {required this.id,
      required this.value,
      required this.title,
      this.isCustom = false});

  static List<DefaultTimer> defaults = [
    DefaultTimer(id: 1, value: 0, title: "No timer"),
    DefaultTimer(id: 2, value: -1, title: "Custom", isCustom: true),
    DefaultTimer(id: 3, value: 5 * 60, title: "5 minutes"),
    DefaultTimer(id: 4, value: 10 * 60, title: "10 minutes"),
    DefaultTimer(id: 5, value: 15 * 60, title: "15 minutes"),
    DefaultTimer(id: 6, value: 20 * 60, title: "20 minutes"),
    DefaultTimer(id: 7, value: 30 * 60, title: "30 minutes"),
    DefaultTimer(id: 8, value: 1 * 60 * 60, title: "1 hour"),
    DefaultTimer(id: 9, value: 2 * 60 * 60, title: "2 hour"),
  ];
}

class PlayMeditationMusic extends StatefulWidget {
  final MeditationMusicMoodel music;
  final DefaultTimer selectedTimer;
  const PlayMeditationMusic(
      {required this.music, required this.selectedTimer, super.key});

  @override
  State<PlayMeditationMusic> createState() => _PlayMeditationMusicState();
}

class _PlayMeditationMusicState extends State<PlayMeditationMusic> {
  bool timerRunning = false;
  double timerTotalDuration = 0;
  double remainingDuration = 0;
  bool showCustomTimer = false;
  DefaultTimer selectedTimer = DefaultTimer.defaults.first;
  int hour = 0;
  int minute = 0;

  @override
  void initState() {
    super.initState();
    selectedTimer = widget.selectedTimer;
    timerTotalDuration = selectedTimer.value;
    timerRunning = MyPlayer.shared.getStatus() == MusicStatus.playing;
    remainingDuration =
        timerTotalDuration - MyPlayer.shared.currentDuration().inSeconds;
    if (mounted) {
      MyPlayer.shared.observeingTimer((seconds) {
        remainingDuration = timerTotalDuration - seconds;
        timerRunning = MyPlayer.shared.getStatus() == MusicStatus.playing;
        if (remainingDuration <= 0 && timerTotalDuration > 0) {
          MyPlayer.shared.stopAudio();
          timerRunning = false;
        }
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    MyPlayer.shared.clearObserver();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: widget.music.img,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.black.withOpacity(0.2),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  context.navigationCubit.pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context.navigationCubit.push(AppPage(
                        page: const MaterialPage(child: SettingScreen()),
                        path: ""));
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: Stack(
              children: [
                Positioned(
                  left: 40,
                  right: 40,
                  bottom: 80,
                  child: Container(
                    height: 277,
                    decoration: BoxDecoration(
                        color: context.appDesignForAction.isDarkMode
                            ? const Color(0xFF3C404A)
                            : Colors.white.withOpacity(0.72),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 36,
                          child: Text(
                            widget.music.title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist().copyWith(
                              color: !context.appDesignForAction.isDarkMode
                                  ? const Color(0xFF3F4553)
                                  : Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (timerRunning) {
                                    MyPlayer.shared.pauseAudio();
                                    setState(() {
                                      timerRunning = false;
                                    });
                                  } else {
                                    MyPlayer.shared.playAudio();
                                    setState(() {
                                      timerRunning = true;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFFFEF6E8),
                                    shape: OvalBorder(),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      !timerRunning
                                          ? Icons.play_arrow
                                          : Icons.pause,
                                      color: const Color(0xFF3F4553),
                                      size: 36,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Scaffold(
                                          backgroundColor: Colors.transparent,
                                          body: Center(
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 54),
                                              height:
                                                  showCustomTimer ? 277 : 480,
                                              decoration: BoxDecoration(
                                                  color: context
                                                          .appDesignForAction
                                                          .isDarkMode
                                                      ? const Color(0xFF3F4553)
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16.0),
                                                    child: SizedBox(
                                                      height: 60,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Set Timer Duration',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                    .urbanist()
                                                                .copyWith(
                                                              color: !context
                                                                      .appDesignForAction
                                                                      .isDarkMode
                                                                  ? const Color(
                                                                      0xFF3F4553)
                                                                  : Colors
                                                                      .white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  'Cancel');
                                                            },
                                                            icon: Icon(
                                                              Icons.close,
                                                              color: !context
                                                                      .appDesignForAction
                                                                      .isDarkMode
                                                                  ? const Color(
                                                                      0xFF3F4553)
                                                                  : Colors
                                                                      .white,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  for (DefaultTimer timer
                                                      in DefaultTimer.defaults)
                                                    SizedBox(
                                                      height: 45,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    16.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context,
                                                                'Cancel');
                                                            selectedTimer =
                                                                timer;
                                                            if (timer
                                                                .isCustom) {
                                                              showCustomTimerAlert(
                                                                  context);
                                                            } else {
                                                              updateTimerDuration(
                                                                  timer.value);
                                                            }
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                selectedTimer
                                                                            .id ==
                                                                        timer.id
                                                                    ? Icons
                                                                        .radio_button_on
                                                                    : Icons
                                                                        .radio_button_off,
                                                                color: context
                                                                        .appDesignForAction
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                size: 20,
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                timer.title,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                        .urbanist()
                                                                    .copyWith(
                                                                  color: !context
                                                                          .appDesignForAction
                                                                          .isDarkMode
                                                                      ? const Color(
                                                                          0xFF3F4553)
                                                                      : Colors
                                                                          .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFFFEF6E8),
                                    shape: OvalBorder(),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      height: 52,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            IconFile.timerIcon,
                                            height: 32,
                                            width: 32,
                                          ),
                                          Text(
                                            timerTotalDuration == 0
                                                ? "N/A"
                                                : _printDuration(Duration(
                                                    seconds: remainingDuration
                                                        .round())),
                                            textAlign: TextAlign.center,
                                            style:
                                                GoogleFonts.urbanist().copyWith(
                                              color: const Color(0xFF3F4553),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 31.5),
                            child: AudioProgressBar()),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
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
                        updateTimerDuration(hour * 60 * 60 + minute * 60);
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

  updateTimerDuration(double totalDuration) {
    timerTotalDuration = totalDuration;
    remainingDuration =
        timerTotalDuration - MyPlayer.shared.currentDuration().inSeconds;
    MyPlayer.shared.resetTimer();
    setState(() {});
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

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: MyPlayer.shared.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: MyPlayer.shared.seek,
          thumbRadius: 5,
          baseBarColor: Colors.white,
          progressBarColor: const Color(0xFFDFB160),
          thumbColor: const Color(0xFFDFB160),
          timeLabelPadding: 5,
          timeLabelTextStyle: GoogleFonts.urbanist().copyWith(
            color: !context.appDesignForAction.isDarkMode
                ? const Color(0xFF697077)
                : Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}
