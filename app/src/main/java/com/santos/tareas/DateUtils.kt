package com.santos.tareas

import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

object DateUtils {
    private val formatter = SimpleDateFormat("d MMM yyyy, HH:mm", Locale("es", "ES"))

    fun format(millis: Long): String {
        if (millis <= 0L) return ""
        return formatter.format(Date(millis))
    }
}
