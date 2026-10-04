package com.noor.noor_app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class NoorWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    companion object {
        private const val PREFS_NAME = "NoorWidgetPrefs"
        private const val KEY_VERSE = "widget_verse_text"
        private const val KEY_REF = "widget_verse_ref"
        private const val KEY_DATE = "widget_coptic_date"

        fun saveWidgetData(
            context: Context,
            verseText: String,
            verseRef: String,
            copticDate: String
        ) {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            prefs.edit()
                .putString(KEY_VERSE, verseText)
                .putString(KEY_REF, verseRef)
                .putString(KEY_DATE, copticDate)
                .apply()
        }

        fun updateAllWidgets(
            context: Context,
            verseText: String? = null,
            verseRef: String? = null,
            copticDate: String? = null
        ) {
            if (verseText != null && verseRef != null && copticDate != null) {
                saveWidgetData(context, verseText, verseRef, copticDate)
            }

            val appWidgetManager = AppWidgetManager.getInstance(context)
            val thisWidget = ComponentName(context, NoorWidgetProvider::class.java)
            val appWidgetIds = appWidgetManager.getAppWidgetIds(thisWidget)

            for (appWidgetId in appWidgetIds) {
                updateAppWidget(context, appWidgetManager, appWidgetId)
            }
        }

        private fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            val verse = prefs.getString(
                KEY_VERSE,
                "«أَنَا هُوَ نُورُ الْعَالَمِ. مَنْ يَتْبَعْنِي فَلاَ يَمْشِي فِي الظُّلْمَةِ»"
            ) ?: "«أَنَا هُوَ نُورُ الْعَالَمِ»"
            val ref = prefs.getString(KEY_REF, "(إنجيل يوحنا ٨ : ١٢)") ?: "(يوحنا ٨ : ١٢)"
            val date = prefs.getString(KEY_DATE, "تطبيق نور الكنسي") ?: "تطبيق نور"

            val views = RemoteViews(context.packageName, R.layout.noor_app_widget)
            views.setTextViewText(R.id.widget_verse_text, verse)
            views.setTextViewText(R.id.widget_verse_ref, ref)
            views.setTextViewText(R.id.widget_coptic_date, date)

            // فتح التطبيق عند النقر على الودجت
            val intent = Intent(context, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            }
            val pendingIntent = PendingIntent.getActivity(
                context,
                0,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
