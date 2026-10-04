# Flutter Wrapper rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# SQLite / Drift native bindings
-keep class org.sqlite.** { *; }
-dontwarn org.sqlite.**
-keep class sqlite3.** { *; }
-dontwarn sqlite3.**

# Flutter Local Notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-dontwarn com.dexterous.flutterlocalnotifications.**

# Audioplayers
-keep class xyz.luan.audioplayers.** { *; }
-dontwarn xyz.luan.audioplayers.**

# SharedPreferences / PathProvider
-keep class io.flutter.plugins.pathprovider.** { *; }
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# Keep generic signatures and reflection attributes
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# Google Play Core / Deferred Components (suppress missing Play Core warnings)
-dontwarn com.google.android.play.core.**
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**
