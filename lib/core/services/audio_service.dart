// lib/core/services/audio_service.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:audioplayers/audioplayers.dart';

part 'audio_service.g.dart';

class AudioState {
  final int? surahNum;
  final int? ayahNum;
  final bool isPlaying;
  final bool isLoading;
  final String? error;
  final bool hasCompleted;

  AudioState({
    this.surahNum,
    this.ayahNum,
    this.isPlaying = false,
    this.isLoading = false,
    this.error,
    this.hasCompleted = false,
  });

  AudioState copyWith({
    int? surahNum,
    int? ayahNum,
    bool? isPlaying,
    bool? isLoading,
    String? error,
    bool? hasCompleted,
    bool clearError = false,
  }) {
    return AudioState(
      surahNum: surahNum ?? this.surahNum,
      ayahNum: ayahNum ?? this.ayahNum,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      hasCompleted: hasCompleted ?? this.hasCompleted,
    );
  }
}

@riverpod
class AudioService extends _$AudioService {
  late final AudioPlayer _player;

  @override
  AudioState build() {
    _player = AudioPlayer();

    // Listen to native player state changes to keep UI reactive state accurate
    _player.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        this.state = this.state.copyWith(isPlaying: true, isLoading: false);
      } else if (state == PlayerState.paused) {
        this.state = this.state.copyWith(isPlaying: false, isLoading: false);
      } else if (state == PlayerState.stopped || state == PlayerState.completed) {
        this.state = this.state.copyWith(isPlaying: false, isLoading: false);
      }
    });

    _player.onPlayerComplete.listen((_) {
      this.state = this.state.copyWith(
        isPlaying: false,
        isLoading: false,
        hasCompleted: true,
      );
      // Immediately reset completion flag so listeners don't re-trigger
      this.state = this.state.copyWith(hasCompleted: false);
    });

    _player.onLog.listen(
      (log) {},
      onError: (err) {
        this.state = this.state.copyWith(error: err.toString());
      },
    );

    ref.onDispose(() {
      _player.dispose();
    });

    return AudioState();
  }

  Future<void> playVerse(int surahNum, int ayahNum) async {
    // If the requested verse is already playing, pause it.
    if (state.surahNum == surahNum && state.ayahNum == ayahNum) {
      if (state.isPlaying) {
        await _player.pause();
      } else {
        await _player.resume();
      }
      return;
    }

    // Otherwise, stop current audio and play the new verse
    state = AudioState(
      surahNum: surahNum,
      ayahNum: ayahNum,
      isLoading: true,
      isPlaying: false,
    );

    try {
      final surahStr = surahNum.toString().padLeft(3, '0');
      final ayahStr = ayahNum.toString().padLeft(3, '0');
      final url = 'https://everyayah.com/data/Alafasy_128kbps/$surahStr$ayahStr.mp3';
      
      await _player.play(UrlSource(url));
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isPlaying: false,
        error: e.toString(),
      );
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    await _player.resume();
  }

  Future<void> stop() async {
    await _player.stop();
  }
}
