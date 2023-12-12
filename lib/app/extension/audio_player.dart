import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:meditation/modules/meditation_music/play_meditation_music/presentation/progress_notifier.dart';

enum MusicStatus { playing, stop, pause, none }

class MusicModel {
  final String id;
  final String url;
  final String musicType;
  MusicModel({
    required this.id,
    required this.url,
    required this.musicType,
  });
}

class MyPlayer {
  final progressNotifier = ProgressNotifier();
  static final shared = MyPlayer._();
  MusicModel? _currentMusic;
  MusicStatus _status = MusicStatus.none;
  final _player = AudioPlayer();
  Timer? _timer;
  Duration _timerDurarion = const Duration();
  Function(int seconds)? _observeTimer;

  MyPlayer._() {
    _listenForChangesInPlayerPosition();
    _listenForChangesInTotalDuration();
  }

  MusicModel? getCurrentMusic() {
    return _currentMusic;
  }

  Duration currentDuration() {
    return _timerDurarion;
  }

  MusicStatus getStatus() {
    return _status;
  }

  clearObserver() {
    _observeTimer = null;
  }

  observeingTimer(Function(int seconds) observeTimer) {
    this._observeTimer = observeTimer;
  }

  setMusic(
    MusicModel music, {
    bool autoPlay = true,
    LoopMode mode = LoopMode.all,
    double volume = 1,
  }) async {
    _currentMusic = music;
    await _player.setUrl(music.url);
    _status = MusicStatus.stop;
    if (autoPlay) {
      playAudio();
    }
    setVilume(volume: volume);
    setPlayMode(mode: mode);
  }

  playAudio() async {
    _player.play();
    _status = MusicStatus.playing;
    _startTimer(_timerDurarion);
  }

  setVilume({double volume = 1}) {
    _player.setVolume(volume);
  }

  void seek(Duration position) {
    _player.seek(position);
  }

  setPlayMode({LoopMode mode = LoopMode.all}) {
    _player.setLoopMode(mode);
  }

  pauseAudio() async {
    _player.pause();
    _status = MusicStatus.pause;
    if (_timer != null) _timer?.cancel();
  }

  stopAudio() {
    resetTimer();
    _player.stop();
    _status = MusicStatus.stop;
    if (_timer != null) _timer?.cancel();
  }

  resetTimer({Duration duration = const Duration()}) {
    _timerDurarion = const Duration();
  }

  void _startTimer(Duration duration) {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        _timerDurarion = Duration(seconds: _timerDurarion.inSeconds + 1);
        if (_observeTimer != null) _observeTimer!(_timerDurarion.inSeconds);
      },
    );
  }

  void _listenForChangesInPlayerPosition() {
    _player.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInTotalDuration() {
    _player.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }
}
