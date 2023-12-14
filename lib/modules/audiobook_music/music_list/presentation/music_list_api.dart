import 'package:bhagavat_geeta/app/extension/audio_player.dart';
import 'package:bhagavat_geeta/modules/meditation_music/meditation_music_list/domain/model/meditation_music_model.dart';
// ignore: implementation_imports
import 'package:flutter_core/src/entity/entity.dart';
import 'package:flutter_netwok_module/flutter_netwok_module.dart';

class MusicListAPI extends RequestApi {
  MusicListAPI({required super.parser});

  @override
  String get endPath => "bhagwat-gita";

  @override
  Map<String, dynamic> get queryParams => {"limit": "9999"};

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  bool get shouldRequireAccessToken => false;
}

class MusicListParser extends EntityParser<AppMusicList> {
  @override
  AppMusicList parseObject(Map<String, dynamic> json) {
    return AppMusicList.fromJson(json);
  }
}

class AppMusicList extends Entity {
  final List<MeditationMusicMoodel> musics;
  AppMusicList({required this.musics});
  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  factory AppMusicList.fromJson(Map<String, dynamic> json) {
    final musicsJsons = json["data"] as List<dynamic>;
    final musics = musicsJsons
        .map(
          (e) => e as Map<String, dynamic>,
        )
        .toList()
        .map(
          (ej) => MeditationMusicMoodel.fromJson(ej),
        )
        .toList();
    return AppMusicList(musics: musics);
  }
}
