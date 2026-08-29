package com.santos.tareas

import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat

class ReminderReceiver : BroadcastReceiver() {

    companion object {
        const val EXTRA_TASK_ID = "extra_task_id"
    }

    override fun onReceive(context: Context, intent: Intent) {
        val taskId = intent.getLongExtra(EXTRA_TASK_ID, -1L)
        if (taskId == -1L) return

        val task = TaskRepository.getTasks(context).find { it.id == taskId } ?: return
        if (task.done) return

        NotificationHelper.ensureChannel(context)

        val openIntent = Intent(context, AddEditTaskActivity::class.java).apply {
            putExtra(AddEditTaskActivity.EXTRA_TASK_ID, task.id)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
        }
        val contentPendingIntent = PendingIntent.getActivity(
            context, taskId.toInt(), openIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val notification = NotificationCompat.Builder(context, NotificationHelper.CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_reminder)
            .setContentTitle(context.getString(R.string.recordatorio_titulo))
            .setContentText(task.title)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .setContentIntent(contentPendingIntent)
            .build()

        if (ContextCompat.checkSelfPermission(context, android.Manifest.permission.POST_NOTIFICATIONS)
            == PackageManager.PERMISSION_GRANTED || android.os.Build.VERSION.SDK_INT < 33
        ) {
            NotificationManagerCompat.from(context).notify(taskId.toInt(), notification)
        }
    }
}
