package com.santos.tareas

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent

object WidgetUpdater {
    fun updateAll(context: Context) {
        val manager = AppWidgetManager.getInstance(context)

        val taskIds = manager.getAppWidgetIds(ComponentName(context, TaskWidgetProvider::class.java))
        manager.notifyAppWidgetViewDataChanged(taskIds, R.id.widget_list)
        if (taskIds.isNotEmpty()) {
            val intent = Intent(context, TaskWidgetProvider::class.java).apply {
                action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, taskIds)
            }
            context.sendBroadcast(intent)
        }

        val noteIds = manager.getAppWidgetIds(ComponentName(context, NoteWidgetProvider::class.java))
        manager.notifyAppWidgetViewDataChanged(noteIds, R.id.widget_note_list)
        if (noteIds.isNotEmpty()) {
            val intent = Intent(context, NoteWidgetProvider::class.java).apply {
                action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, noteIds)
            }
            context.sendBroadcast(intent)
        }
    }
}
