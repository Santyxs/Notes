package com.santos.tareas

data class Note(
    val id: Long,
    var title: String = "",
    var text: String,
    var deleted: Boolean = false,
    var createdAt: Long = System.currentTimeMillis(),
    var pinned: Boolean = false,
    var locked: Boolean = false,
    var color: String? = null,
    var fontFamily: String? = null,
    var attachments: MutableList<String> = mutableListOf()
)
