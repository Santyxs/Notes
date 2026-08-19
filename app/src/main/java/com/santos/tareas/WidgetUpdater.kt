package com.santos.tareas

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.widget.RemoteViews

object WidgetUpdater {
    fun updateAll(context: Context) {
        val manager = AppWidgetManager.getInstance(context)
        val ids = manager.getAppWidgetIds(ComponentName(context, TaskWidgetProvider::class.java))
        manager.notifyAppWidgetViewDataChanged(ids, R.id.widget_list)
    }
}
