import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioServiceProvider = Provider<AudioService>((ref) {
  return AudioService.instance;
});

class AudioService {
  static AudioService? _instance;
  final AudioPlayer _player;

  double _currentPlaybackRate = 1.0;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  PlayerState _currentState = PlayerState.stopped;

  StreamSubscription<PlayerState>? _stateSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration>? _durationSubscription;

  AudioService._({AudioPlayer? player}) : _player = player ?? AudioPlayer() {
    _initListeners();
  }

  static AudioService get instance {
    _instance ??= AudioService._();
    return _instance!;
  }

  @visibleForTesting
  static void setMockInstance(AudioService mockService) {
    _instance = mockService;
  }

  void _initListeners() {
    _stateSubscription = _player.onPlayerStateChanged.listen((state) {
      _currentState = state;
    });

    _positionSubscription = _player.onPositionChanged.listen((position) {
      _currentPosition = position;
    });

    _durationSubscription = _player.onDurationChanged.listen((duration) {
      _totalDuration = duration;
    });
  }

  AudioPlayer get player => _player;

  Stream<PlayerState> get onPlayerStateChanged => _player.onPlayerStateChanged;
  Stream<Duration> get onPositionChanged => _player.onPositionChanged;
  Stream<Duration> get onDurationChanged => _player.onDurationChanged;

  PlayerState get state => _currentState;
  Duration get position => _currentPosition;
  Duration get duration => _totalDuration;
  double get playbackRate => _currentPlaybackRate;
  bool get isPlaying => _currentState == PlayerState.playing;

  /// تشغيل ملف صوتي من الأصول المحلية (Assets)
  Future<void> playAsset(String assetPath) async {
    try {
      await _player.stop();
      await _player.setPlaybackRate(_currentPlaybackRate);
      await _player.play(AssetSource(assetPath));
    } catch (e) {
      debugPrint('Error playing asset audio: $e');
      rethrow;
    }
  }

  /// تشغيل صوت من رابط شبكي أو ملف محلي
  Future<void> playUrl(String url) async {
    try {
      await _player.stop();
      await _player.setPlaybackRate(_currentPlaybackRate);
      await _player.play(UrlSource(url));
    } catch (e) {
      debugPrint('Error playing URL audio: $e');
      rethrow;
    }
  }

  /// إيقاف مؤقت
  Future<void> pause() async {
    await _player.pause();
  }

  /// استئناف
  Future<void> resume() async {
    await _player.resume();
  }

  /// إيقاف نهائي
  Future<void> stop() async {
    await _player.stop();
    _currentPosition = Duration.zero;
  }

  /// تقديم أو ترجيع لموضع محدد
  Future<void> seek(Duration targetPosition) async {
    await _player.seek(targetPosition);
  }

  /// تعديل سرعة القراءة / التعليم (0.5x, 0.75x, 1.0x, 1.25x, 1.5x)
  Future<void> setPlaybackRate(double rate) async {
    _currentPlaybackRate = rate;
    await _player.setPlaybackRate(rate);
  }

  /// تعديل مستوى الصوت (0.0 إلى 1.0)
  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume.clamp(0.0, 1.0));
  }

  /// تفعيل وضع التكرار
  Future<void> setReleaseMode(ReleaseMode mode) async {
    await _player.setReleaseMode(mode);
  }

  /// تحرير الموارد
  Future<void> dispose() async {
    await _stateSubscription?.cancel();
    await _positionSubscription?.cancel();
    await _durationSubscription?.cancel();
    await _player.dispose();
    _instance = null;
  }
}
