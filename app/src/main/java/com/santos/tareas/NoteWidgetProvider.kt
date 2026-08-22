package com.santos.tareas

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.RemoteViews

class NoteWidgetProvider : AppWidgetProvider() {

    companion object {
        private const val COMPACT_HEIGHT_DP = 200
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (widgetId in appWidgetIds) {
            updateWidget(context, appWidgetManager, widgetId)
        }
    }

    override fun onAppWidgetOptionsChanged(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        newOptions: Bundle
    ) {
        updateWidget(context, appWidgetManager, appWidgetId)
    }

    private fun isCompact(appWidgetManager: AppWidgetManager, widgetId: Int): Boolean {
        val options = appWidgetManager.getAppWidgetOptions(widgetId)
        val minHeight = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_HEIGHT, 0)
        return minHeight in 1 until COMPACT_HEIGHT_DP
    }

    private fun updateWidget(context: Context, appWidgetManager: AppWidgetManager, widgetId: Int) {
        val compact = isCompact(appWidgetManager, widgetId)

        val addIntent = Intent(context, AddEditNoteActivity::class.java)
        val addPendingIntent = PendingIntent.getActivity(
            context, 0, addIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        if (compact) {
            val views = RemoteViews(context.packageName, R.layout.widget_note_small)
            views.setOnClickPendingIntent(R.id.widget_note_add_button_small, addPendingIntent)

            val notes = NoteRepository.getNotes(context)
            val summary = if (notes.isEmpty()) {
                context.getString(R.string.sin_notas)
            } else {
                val latest = notes.first()
                latest.title.ifBlank { latest.text }.ifBlank { context.getString(R.string.notas) }
            }
            views.setTextViewText(R.id.widget_note_small_summary, summary)

            val openIntent = Intent(context, MainActivity::class.java).apply {
                putExtra(MainActivity.EXTRA_SHOW_NOTES, true)
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
            val openPendingIntent = PendingIntent.getActivity(
                context, 3, openIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_note_small_summary, openPendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        } else {
            val views = RemoteViews(context.packageName, R.layout.widget_note)
            views.setOnClickPendingIntent(R.id.widget_note_add_button, addPendingIntent)

            val openIntent = Intent(context, MainActivity::class.java).apply {
                putExtra(MainActivity.EXTRA_SHOW_NOTES, true)
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
            val openPendingIntent = PendingIntent.getActivity(
                context, 4, openIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_note_header, openPendingIntent)

            val serviceIntent = Intent(context, NoteWidgetService::class.java).apply {
                putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
                data = Uri.parse(toUri(Intent.URI_INTENT_SCHEME))
            }
            views.setRemoteAdapter(R.id.widget_note_list, serviceIntent)
            views.setEmptyView(R.id.widget_note_list, R.id.widget_note_empty)

            val itemOpenIntent = Intent(context, AddEditNoteActivity::class.java)
            val itemOpenPendingIntent = PendingIntent.getActivity(
                context, 1, itemOpenIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
            )
            views.setPendingIntentTemplate(R.id.widget_note_list, itemOpenPendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
            appWidgetManager.notifyAppWidgetViewDataChanged(widgetId, R.id.widget_note_list)
        }
    }
}
