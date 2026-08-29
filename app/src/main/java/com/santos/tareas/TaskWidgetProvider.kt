package com.santos.tareas

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.RemoteViews

/** Versión con margen (tarjeta más pequeña que la celda que ocupa). */
open class TaskWidgetProvider : AppWidgetProvider() {

    companion object {
        const val ACTION_TOGGLE = "com.santos.tareas.ACTION_TOGGLE"
        const val EXTRA_TASK_ID = "extra_task_id"

        // Umbral de altura por debajo del cual usamos el layout compacto (sin lista)
        private const val COMPACT_HEIGHT_DP = 100
    }

    protected open val fullLayoutRes: Int = R.layout.widget_task

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

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == ACTION_TOGGLE) {
            val taskId = intent.getLongExtra(EXTRA_TASK_ID, -1L)
            if (taskId != -1L) {
                TaskRepository.toggleDone(context, taskId)
            }
        }
    }

    private fun isCompact(appWidgetManager: AppWidgetManager, widgetId: Int): Boolean {
        val options = appWidgetManager.getAppWidgetOptions(widgetId)
        val minHeight = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_HEIGHT, 0)
        return minHeight in 1 until COMPACT_HEIGHT_DP
    }

    private fun updateWidget(context: Context, appWidgetManager: AppWidgetManager, widgetId: Int) {
        val compact = isCompact(appWidgetManager, widgetId)

        val addIntent = Intent(context, AddEditTaskActivity::class.java)
        val addPendingIntent = PendingIntent.getActivity(
            context, 0, addIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val openIntent = Intent(context, MainActivity::class.java).apply {
            putExtra(MainActivity.EXTRA_SHOW_NOTES, false)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK
        }
        val openPendingIntent = PendingIntent.getActivity(
            context, 2, openIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        if (compact) {
            val views = RemoteViews(context.packageName, R.layout.widget_task_small)
            views.setOnClickPendingIntent(R.id.widget_add_button_small, addPendingIntent)

            val tasks = TaskRepository.getTasks(context)
            val pending = tasks.count { !it.done }
            val summary = when {
                tasks.isEmpty() -> context.getString(R.string.sin_tareas)
                pending == 0 -> context.getString(R.string.todo_completado)
                else -> context.resources.getQuantityStringOrFallback(pending, tasks.size)
            }
            views.setTextViewText(R.id.widget_small_summary, summary)
            views.setOnClickPendingIntent(R.id.widget_small_summary, openPendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        } else {
            val views = RemoteViews(context.packageName, fullLayoutRes)
            views.setOnClickPendingIntent(R.id.widget_add_button, addPendingIntent)
            views.setOnClickPendingIntent(R.id.widget_header, openPendingIntent)

            val serviceIntent = Intent(context, TaskWidgetService::class.java).apply {
                putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
                data = Uri.parse(toUri(Intent.URI_INTENT_SCHEME))
            }
            views.setRemoteAdapter(R.id.widget_list, serviceIntent)
            views.setEmptyView(R.id.widget_list, R.id.widget_empty)

            val toggleIntent = Intent(context, javaClass).apply {
                action = ACTION_TOGGLE
            }
            val togglePendingIntent = PendingIntent.getBroadcast(
                context, 0, toggleIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
            )
            views.setPendingIntentTemplate(R.id.widget_list, togglePendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
            appWidgetManager.notifyAppWidgetViewDataChanged(widgetId, R.id.widget_list)
        }
    }
}

/** Versión sin margen: la tarjeta ocupa toda la celda que reserva. */
class TaskWidgetProviderNoMargin : TaskWidgetProvider() {
    override val fullLayoutRes: Int = R.layout.widget_task_full
}

private fun android.content.res.Resources.getQuantityStringOrFallback(pending: Int, total: Int): String {
    return "$pending de $total pendientes"
}
