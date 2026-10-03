import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/providers/simple_mode_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('SimpleModeNotifier', () {
    test('initial state is false by default', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final isSimple = container.read(simpleModeProvider);
      expect(isSimple, false);
    });

    test('toggle changes state and persists to SharedPreferences', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(simpleModeProvider.notifier);
      await notifier.toggle();

      expect(container.read(simpleModeProvider), true);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('app_simple_mode_enabled'), true);

      await notifier.toggle();
      expect(container.read(simpleModeProvider), false);
      expect(prefs.getBool('app_simple_mode_enabled'), false);
    });

    test('setSimpleMode directly sets boolean value', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(simpleModeProvider.notifier);
      await notifier.setSimpleMode(true);

      expect(container.read(simpleModeProvider), true);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('app_simple_mode_enabled'), true);
    });
  });
}
