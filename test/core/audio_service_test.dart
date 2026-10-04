import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/services/audio_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers.global'),
      (MethodCall methodCall) async {
        return 1;
      },
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers'),
      (MethodCall methodCall) async {
        return 1;
      },
    );
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers.global'),
      null,
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers'),
      null,
    );
  });

  group('AudioService Tests', () {
    test('AudioService instance is singleton and initializes with defaults', () {
      final service1 = AudioService.instance;
      final service2 = AudioService.instance;

      expect(service1, same(service2));
      expect(service1.playbackRate, 1.0);
      expect(service1.isPlaying, isFalse);
      expect(service1.position, Duration.zero);
      expect(service1.duration, Duration.zero);
    });

    test('AudioService controls playback rate and volume correctly', () async {
      final service = AudioService.instance;

      await service.setPlaybackRate(1.25);
      expect(service.playbackRate, 1.25);

      await service.setPlaybackRate(0.75);
      expect(service.playbackRate, 0.75);

      await service.setVolume(0.8);
      expect(service.playbackRate, 0.75);
    });
  });
}
