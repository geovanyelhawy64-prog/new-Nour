import unittest
from pathlib import Path


class NoAudioPolicyTest(unittest.TestCase):
    def test_audio_playback_dependency_and_service_are_absent(self):
        root = Path(__file__).resolve().parents[2]
        self.assertFalse((root / "lib/core/services/audio_service.dart").exists())
        self.assertFalse((root / "test/core/audio_service_test.dart").exists())
        self.assertNotIn("audioplayers", (root / "pubspec.yaml").read_text())
        self.assertNotIn("audioplayers", (root / "pubspec.lock").read_text())

    def test_platform_registrants_do_not_link_audio_plugin(self):
        root = Path(__file__).resolve().parents[2]
        generated_files = [
            "macos/Flutter/GeneratedPluginRegistrant.swift",
            "windows/flutter/generated_plugin_registrant.cc",
            "windows/flutter/generated_plugins.cmake",
            "linux/flutter/generated_plugin_registrant.cc",
            "linux/flutter/generated_plugins.cmake",
        ]
        for relative in generated_files:
            with self.subTest(file=relative):
                text = (root / relative).read_text()
                self.assertNotIn("audioplayers", text.lower())


if __name__ == "__main__":
    unittest.main()
