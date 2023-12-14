import 'package:bhagavat_geeta/app/configure/network/network.dart';
import 'package:bhagavat_geeta/app/extension/audio_player.dart';
import 'package:bhagavat_geeta/modules/audiobook_music/music_list/presentation/music_list_state.dart';
import 'package:bhagavat_geeta/modules/meditation_music/meditation_music_list/domain/model/meditation_music_model.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_netwok_module/flutter_netwok_module.dart';
import 'package:just_audio/just_audio.dart';

import 'music_list_api.dart';

class MusicListCubit extends Cubit<MusicListState> {
  MusicModel? selectedMusic;
  bool isPlay = false;
  List<MeditationMusicMoodel> musics = [];
  MusicListCubit() : super(MusicListInitial()) {
    getMusicList();
  }

  getMusicList() async {
    final network = NetworkClient.fromConfig(networkConfig);
    try {
      final res = await network
          .request<AppMusicList>(MusicListAPI(parser: MusicListParser()));
      res.fold((error) => print(error), (data) {
        musics = data.object?.musics ?? [];
        emit(MusicListInitial());
      });
    } catch (e) {
      print(e);
      musics = MeditationMusicMoodel.musics;
      emit(MusicListInitial());
    }
  }

  setMusic(MusicModel music) {
    selectedMusic = music;
    isPlay = true;
    MyPlayer.shared.setMusic(music, autoPlay: true, mode: LoopMode.off);
    emit(MusicListInitial());
  }

  pauseMusic() {
    isPlay = false;
    MyPlayer.shared.pauseAudio();
    emit(MusicListInitial());
  }

  playMusic() {
    isPlay = true;
    MyPlayer.shared.playAudio();
    emit(MusicListInitial());
  }

  updateLanguage(String lang) {
    emit(MusicListUpdateLanguage(lang));
  }
}
