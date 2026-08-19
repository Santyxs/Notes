package com.santos.tareas

data class Task(
    val id: Long,
    var title: String,
    var done: Boolean = false
)
