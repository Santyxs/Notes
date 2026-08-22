#!/bin/bash
set -e

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_add_edit_task.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/dark_bg">

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:padding="16dp">

        <ImageView
            android:id="@+id/backButton"
            android:layout_width="44dp"
            android:layout_height="44dp"
            android:layout_alignParentStart="true"
            android:background="@drawable/circle_button_dark"
            android:padding="11dp"
            android:src="@drawable/ic_back" />

    </RelativeLayout>

    <ScrollView
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:padding="20dp">

            <ImageView
                android:layout_width="26dp"
                android:layout_height="26dp"
                android:layout_marginEnd="14dp"
                android:layout_marginTop="6dp"
                android:src="@drawable/ic_check_circle_outline" />

            <EditText
                android:id="@+id/taskInput"
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_weight="1"
                android:hint="@string/tocar_para_editar"
                android:textColor="@color/white"
                android:textColorHint="@color/dark_text_secondary"
                android:textSize="24sp"
                android:textStyle="bold"
                android:background="@android:color/transparent"
                android:fontFamily="casual"
                android:includeFontPadding="false"
                android:paddingTop="0dp"
                android:paddingBottom="0dp"
                android:gravity="center_vertical" />

        </LinearLayout>

    </ScrollView>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="end"
        android:padding="16dp">

        <TextView
            android:id="@+id/cancelButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/cancelar"
            android:textColor="@color/dark_text_secondary"
            android:padding="10dp" />

        <TextView
            android:id="@+id/saveButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/guardar"
            android:textColor="@color/accent_yellow"
            android:textStyle="bold"
            android:padding="10dp"
            android:layout_marginStart="8dp" />

    </LinearLayout>

</LinearLayout>
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/TaskWidgetProvider.kt << 'ZZEOF'
package com.santos.tareas

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.RemoteViews

class TaskWidgetProvider : AppWidgetProvider() {

    companion object {
        const val ACTION_TOGGLE = "com.santos.tareas.ACTION_TOGGLE"
        const val EXTRA_TASK_ID = "extra_task_id"

        // Umbral de altura por debajo del cual usamos el layout compacto (sin lista)
        private const val COMPACT_HEIGHT_DP = 130
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
            val summary = if (tasks.isEmpty()) {
                context.getString(R.string.sin_tareas)
            } else {
                context.resources.getQuantityStringOrFallback(pending, tasks.size)
            }
            views.setTextViewText(R.id.widget_small_summary, summary)
            views.setOnClickPendingIntent(R.id.widget_small_summary, openPendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        } else {
            val views = RemoteViews(context.packageName, R.layout.widget_task)
            views.setOnClickPendingIntent(R.id.widget_add_button, addPendingIntent)
            views.setOnClickPendingIntent(R.id.widget_header, openPendingIntent)

            val serviceIntent = Intent(context, TaskWidgetService::class.java).apply {
                putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
                data = Uri.parse(toUri(Intent.URI_INTENT_SCHEME))
            }
            views.setRemoteAdapter(R.id.widget_list, serviceIntent)
            views.setEmptyView(R.id.widget_list, R.id.widget_empty)

            val toggleIntent = Intent(context, TaskWidgetProvider::class.java).apply {
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

private fun android.content.res.Resources.getQuantityStringOrFallback(pending: Int, total: Int): String {
    return "$pending de $total pendientes"
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteWidgetProvider.kt << 'ZZEOF'
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
        private const val COMPACT_HEIGHT_DP = 130
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
ZZEOF

echo "Widget abre la pantalla correcta y texto alineado. Compilando..."
./gradlew assembleDebug