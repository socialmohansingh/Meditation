abstract class MusicListState {}

class MusicListInitial extends MusicListState {}

class MusicListUpdateLanguage extends MusicListState {
  final String lang;
  MusicListUpdateLanguage(this.lang);
}
