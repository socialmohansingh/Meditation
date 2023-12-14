import 'package:bhagavat_geeta/app/design/widgets/screens/app_scaffold.dart';
import 'package:bhagavat_geeta/app/extension/audio_player.dart';
import 'package:bhagavat_geeta/modules/audiobook_music/music_list/presentation/music_list_cubit.dart';
import 'package:bhagavat_geeta/modules/audiobook_music/music_list/presentation/music_list_state.dart';
import 'package:bhagavat_geeta/modules/meditation_music/play_meditation_music/presentation/play_meditation_music.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicList extends StatelessWidget {
  String oldLang;
  MusicList({required this.oldLang, super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MusicListCubit>();
    return BlocConsumer<MusicListCubit, MusicListState>(
      listener: (context, state) {},
      builder: (context, state) {
        String lang = oldLang;
        if (state is MusicListUpdateLanguage) {
          oldLang = state.lang;
          lang = state.lang;
          MyPlayer.shared.clearMusic();
          cubit.isPlay = false;
          cubit.selectedMusic = null;
        }
        return AppScaffold(
          hasBack: false,
          lang: lang,
          title: "Bhagavad Geeta",
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              itemCount: cubit.musics.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SizedBox(
                    height: cubit.musics[index].id.toString() ==
                                cubit.selectedMusic?.id &&
                            cubit.isPlay
                        ? 118
                        : 80,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      cubit.musics[index].img,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: const OvalBorder(),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    cubit.musics[index].getTitle(lang),
                                    style: GoogleFonts.urbanist().copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: const Color(0xFF343A3F),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    cubit.musics[index].getChapter(lang),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.urbanist().copyWith(
                                      color: const Color(0xFF697077),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    final aMusic = cubit.musics[index];
                                    if (aMusic.id.toString() !=
                                        cubit.selectedMusic?.id) {
                                      cubit.setMusic(MusicModel(
                                          id: aMusic.id.toString(),
                                          url: aMusic.audio,
                                          musicType: "audio"));
                                    } else {
                                      if (MyPlayer.shared.isPLaying()) {
                                        cubit.pauseMusic();
                                      } else {
                                        cubit.playMusic();
                                      }
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    width: 32,
                                    height: 32,
                                    decoration: const ShapeDecoration(
                                      color: Color(0xFFFEF7EB),
                                      shape: OvalBorder(),
                                    ),
                                    child: Icon(
                                      cubit.musics[index].id.toString() ==
                                                  cubit.selectedMusic?.id &&
                                              cubit.isPlay
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: const Color(0xFFD26A00),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (cubit.musics[index].id.toString() ==
                                  cubit.selectedMusic?.id &&
                              cubit.isPlay)
                            const SizedBox(
                              height: 12,
                            ),
                          if (cubit.musics[index].id.toString() ==
                                  cubit.selectedMusic?.id &&
                              cubit.isPlay)
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: AudioProgressBar(
                                  runningMusic: cubit.selectedMusic!,
                                  onComplete: (music) {
                                    if (music != null) {
                                      final musicId = music.id;
                                      final cIndex = cubit.musics.indexWhere(
                                          (element) =>
                                              element.id.toString() == musicId);
                                      if (cIndex >= 0) {
                                        if ((cIndex + 1) <
                                            cubit.musics.length) {
                                          final music =
                                              cubit.musics[cIndex + 1];
                                          cubit.setMusic(MusicModel(
                                              id: music.id.toString(),
                                              url: music.audio,
                                              musicType: "audio"));
                                        } else {
                                          cubit.pauseMusic();
                                        }
                                      }
                                    }
                                  },
                                )),
                          if (cubit.musics[index].id.toString() ==
                                  cubit.selectedMusic?.id &&
                              cubit.isPlay)
                            const SizedBox(
                              height: 5,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
