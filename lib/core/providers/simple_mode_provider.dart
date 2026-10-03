import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kSimpleModeKey = 'app_simple_mode_enabled';

class SimpleModeNotifier extends StateNotifier<bool> {
  SimpleModeNotifier() : super(false) {
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_kSimpleModeKey) ?? false;
  }

  Future<void> toggle() async {
    final prefs = await SharedPreferences.getInstance();
    state = !state;
    await prefs.setBool(_kSimpleModeKey, state);
  }

  Future<void> setSimpleMode(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    state = enabled;
    await prefs.setBool(_kSimpleModeKey, enabled);
  }
}

final simpleModeProvider =
    StateNotifierProvider<SimpleModeNotifier, bool>((ref) {
  return SimpleModeNotifier();
});
