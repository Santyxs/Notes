package com.santos.tareas

data class Note(
    val id: Long,
    var title: String = "",
    var text: String,
    var deleted: Boolean = false,
    var createdAt: Long = System.currentTimeMillis()
)
