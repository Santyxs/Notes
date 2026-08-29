package com.santos.tareas

/** 0 = sin prioridad, 1 = baja, 2 = media, 3 = alta */
data class Task(
    val id: Long,
    var title: String,
    var done: Boolean = false,
    var deleted: Boolean = false,
    var createdAt: Long = System.currentTimeMillis(),
    var priority: Int = 0,
    var reminderAt: Long = 0L
)
