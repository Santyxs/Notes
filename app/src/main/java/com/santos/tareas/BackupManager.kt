package com.santos.tareas

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/**
 * Exporta e importa todas las notas y tareas (incluidas las de la papelera)
 * como un único archivo JSON, para hacer copia de seguridad o pasar los
 * datos a otro dispositivo.
 */
object BackupManager {

    fun exportJson(context: Context): String {
        val root = JSONObject()
        root.put("version", 1)
        root.put("exportedAt", System.currentTimeMillis())

        val notesArray = JSONArray()
        for (note in NoteRepository.getAllIncludingDeleted(context)) {
            val o = JSONObject()
            o.put("id", note.id)
            o.put("title", note.title)
            o.put("text", note.text)
            o.put("deleted", note.deleted)
            o.put("createdAt", note.createdAt)
            o.put("pinned", note.pinned)
            o.put("locked", note.locked)
            o.put("color", note.color ?: JSONObject.NULL)
            o.put("fontFamily", note.fontFamily ?: JSONObject.NULL)
            o.put("attachments", JSONArray(note.attachments))
            notesArray.put(o)
        }
        root.put("notes", notesArray)

        val tasksArray = JSONArray()
        for (task in TaskRepository.getAllIncludingDeleted(context)) {
            val o = JSONObject()
            o.put("id", task.id)
            o.put("title", task.title)
            o.put("done", task.done)
            o.put("deleted", task.deleted)
            o.put("createdAt", task.createdAt)
            tasksArray.put(o)
        }
        root.put("tasks", tasksArray)

        return root.toString()
    }

    /** Sustituye todos los datos actuales por los del JSON importado. */
    fun importJson(context: Context, json: String): Boolean {
        return try {
            val root = JSONObject(json)
            val notesArray = root.getJSONArray("notes")
            val notes = mutableListOf<Note>()
            for (i in 0 until notesArray.length()) {
                val o = notesArray.getJSONObject(i)
                notes.add(
                    Note(
                        id = o.getLong("id"),
                        title = o.optString("title", ""),
                        text = o.optString("text", ""),
                        deleted = o.optBoolean("deleted", false),
                        createdAt = o.optLong("createdAt", System.currentTimeMillis()),
                        pinned = o.optBoolean("pinned", false),
                        locked = o.optBoolean("locked", false),
                        color = if (o.isNull("color")) null else o.optString("color"),
                        fontFamily = if (o.isNull("fontFamily")) null else o.optString("fontFamily"),
                        attachments = (0 until o.optJSONArray("attachments")?.length().let { it ?: 0 })
                            .map { idx -> o.getJSONArray("attachments").getString(idx) }
                            .toMutableList()
                    )
                )
            }

            val tasksArray = root.getJSONArray("tasks")
            val tasks = mutableListOf<Task>()
            for (i in 0 until tasksArray.length()) {
                val o = tasksArray.getJSONObject(i)
                tasks.add(
                    Task(
                        id = o.getLong("id"),
                        title = o.optString("title", ""),
                        done = o.optBoolean("done", false),
                        deleted = o.optBoolean("deleted", false),
                        createdAt = o.optLong("createdAt", System.currentTimeMillis())
                    )
                )
            }

            NoteRepository.replaceAll(context, notes)
            TaskRepository.replaceAll(context, tasks)
            WidgetUpdater.updateAll(context)
            true
        } catch (e: Exception) {
            false
        }
    }
}
