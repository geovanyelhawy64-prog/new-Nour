package com.noor.noor_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val widgetChannel = "com.noor.noor_app/widget"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, widgetChannel).setMethodCallHandler { call, result ->
            if (call.method == "updateWidget") {
                val verseText = call.argument<String>("verseText")
                val verseRef = call.argument<String>("verseRef")
                val copticDate = call.argument<String>("copticDate")

                if (verseText != null && verseRef != null && copticDate != null) {
                    NoorWidgetProvider.updateAllWidgets(context, verseText, verseRef, copticDate)
                    result.success(true)
                } else {
                    result.error("INVALID_ARGS", "Missing arguments for widget update", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
