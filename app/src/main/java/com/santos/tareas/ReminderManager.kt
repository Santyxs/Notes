package com.santos.tareas

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent

object ReminderManager {

    private fun pendingIntentFor(context: Context, taskId: Long): PendingIntent {
        val intent = Intent(context, ReminderReceiver::class.java).apply {
            putExtra(ReminderReceiver.EXTRA_TASK_ID, taskId)
        }
        return PendingIntent.getBroadcast(
            context, taskId.toInt(), intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }

    fun schedule(context: Context, taskId: Long, timeMillis: Long) {
        if (timeMillis <= System.currentTimeMillis()) return
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val pendingIntent = pendingIntentFor(context, taskId)
        try {
            alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, timeMillis, pendingIntent)
        } catch (e: SecurityException) {
            // El usuario no concedió permiso de alarmas exactas: no programamos nada
        }
    }

    fun cancel(context: Context, taskId: Long) {
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        alarmManager.cancel(pendingIntentFor(context, taskId))
    }

    /** Reprograma todos los recordatorios pendientes (se llama tras reiniciar el móvil). */
    fun rescheduleAll(context: Context) {
        val tasks = TaskRepository.getTasks(context)
        for (task in tasks) {
            if (task.reminderAt > System.currentTimeMillis() && !task.done) {
                schedule(context, task.id, task.reminderAt)
            }
        }
    }
}
