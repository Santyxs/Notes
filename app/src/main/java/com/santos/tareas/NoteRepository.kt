package com.santos.tareas

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/**
 * Almacena las notas en SharedPreferences como JSON, igual que TaskRepository
 * pero en un almacén separado. "Eliminar" mueve la nota a la papelera en vez
 * de borrarla directamente.
 */
object NoteRepository {

    private const val PREFS = "notas_prefs"
    private const val KEY_NOTES = "notes_json"
    private const val KEY_NEXT_ID = "next_id"

    private fun getAllRaw(context: Context): MutableList<Note> {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val json = prefs.getString(KEY_NOTES, null)
        if (json == null) {
            val now = System.currentTimeMillis()
            val seed = mutableListOf(
                Note(id = nextId(context), title = "Bienvenido a Notas", text = "", createdAt = now),
                Note(id = nextId(context), title = "", text = "Toca + para crear una nota nueva", createdAt = now)
            )
            saveNotes(context, seed)
            return seed
        }
        val array = JSONArray(json)
        val list = mutableListOf<Note>()
        for (i in 0 until array.length()) {
            val o = array.getJSONObject(i)
            list.add(
                Note(
                    id = o.getLong("id"),
                    title = if (o.has("title")) o.getString("title") else "",
                    text = o.getString("text"),
                    deleted = if (o.has("deleted")) o.getBoolean("deleted") else false,
                    createdAt = if (o.has("createdAt")) o.getLong("createdAt") else 0L
                )
            )
        }
        return list
    }

    /** Notas activas (no eliminadas) — lo que se muestra normalmente. */
    fun getNotes(context: Context): MutableList<Note> =
        getAllRaw(context).filter { !it.deleted }.toMutableList()

    /** Notas en la papelera. */
    fun getDeletedNotes(context: Context): MutableList<Note> =
        getAllRaw(context).filter { it.deleted }.toMutableList()

    private fun saveNotes(context: Context, notes: List<Note>) {
        val array = JSONArray()
        for (n in notes) {
            val o = JSONObject()
            o.put("id", n.id)
            o.put("title", n.title)
            o.put("text", n.text)
            o.put("deleted", n.deleted)
            o.put("createdAt", n.createdAt)
            array.put(o)
        }
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .edit()
            .putString(KEY_NOTES, array.toString())
            .apply()
    }

    private fun nextId(context: Context): Long {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val id = prefs.getLong(KEY_NEXT_ID, 1L)
        prefs.edit().putLong(KEY_NEXT_ID, id + 1).apply()
        return id
    }

    fun addNote(context: Context, title: String, text: String) {
        val notes = getAllRaw(context)
        notes.add(0, Note(id = nextId(context), title = title, text = text, createdAt = System.currentTimeMillis()))
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
    }

    fun updateNote(context: Context, note: Note) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == note.id }
        if (idx >= 0) {
            // Se conserva la fecha de creación original al editar.
            notes[idx] = note.copy(createdAt = notes[idx].createdAt)
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    /** Mueve la nota a la papelera (no la borra todavía). */
    fun deleteNote(context: Context, id: Long) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(deleted = true)
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun restoreNote(context: Context, id: Long) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(deleted = false)
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    /** Borra definitivamente una nota de la papelera. */
    fun permanentlyDeleteNote(context: Context, id: Long) {
        val notes = getAllRaw(context)
        notes.removeAll { it.id == id }
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
    }

    fun emptyTrash(context: Context) {
        val notes = getAllRaw(context)
        notes.removeAll { it.deleted }
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
    }
}
