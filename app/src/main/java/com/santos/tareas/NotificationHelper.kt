package com.santos.tareas

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build

object NotificationHelper {
    const val CHANNEL_ID = "recordatorios_tareas"

    fun ensureChannel(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val manager = context.getSystemService(NotificationManager::class.java)
            val existing = manager.getNotificationChannel(CHANNEL_ID)
            if (existing == null) {
                val channel = NotificationChannel(
                    CHANNEL_ID,
                    context.getString(R.string.recordatorios),
                    NotificationManager.IMPORTANCE_HIGH
                )
                channel.description = context.getString(R.string.recordatorios_desc)
                manager.createNotificationChannel(channel)
            }
        }
    }
}
