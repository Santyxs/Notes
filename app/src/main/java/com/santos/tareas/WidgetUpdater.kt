package com.santos.tareas

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.widget.RemoteViews

object WidgetUpdater {
    fun updateAll(context: Context) {
        val manager = AppWidgetManager.getInstance(context)

        val taskIds = manager.getAppWidgetIds(ComponentName(context, TaskWidgetProvider::class.java))
        manager.notifyAppWidgetViewDataChanged(taskIds, R.id.widget_list)

        val noteIds = manager.getAppWidgetIds(ComponentName(context, NoteWidgetProvider::class.java))
        manager.notifyAppWidgetViewDataChanged(noteIds, R.id.widget_note_list)
    }
}
