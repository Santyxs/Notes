package com.santos.tareas

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/**
 * Almacena las notas en SharedPreferences como JSON. "Eliminar" mueve la nota
 * a la papelera en vez de borrarla directamente.
 */
object NoteRepository {

    private const val PREFS = "notas_prefs"
    private const val KEY_NOTES = "notes_json"
    private const val KEY_NEXT_ID = "next_id"

    private fun getAllRaw(context: Context): MutableList<Note> {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val json = prefs.getString(KEY_NOTES, null)
        if (json == null) {
            val seed = mutableListOf(
                Note(id = nextId(context), title = "Bienvenido a Notas", text = ""),
                Note(id = nextId(context), title = "", text = "Toca + para crear una nota nueva")
            )
            saveNotes(context, seed)
            return seed
        }
        val array = JSONArray(json)
        val list = mutableListOf<Note>()
        for (i in 0 until array.length()) {
            val o = array.getJSONObject(i)
            val attachments = mutableListOf<String>()
            if (o.has("attachments")) {
                val arr = o.getJSONArray("attachments")
                for (j in 0 until arr.length()) attachments.add(arr.getString(j))
            }
            list.add(
                Note(
                    id = o.getLong("id"),
                    title = if (o.has("title")) o.getString("title") else "",
                    text = o.getString("text"),
                    deleted = if (o.has("deleted")) o.getBoolean("deleted") else false,
                    createdAt = if (o.has("createdAt")) o.getLong("createdAt") else 0L,
                    pinned = if (o.has("pinned")) o.getBoolean("pinned") else false,
                    locked = if (o.has("locked")) o.getBoolean("locked") else false,
                    color = if (o.has("color") && !o.isNull("color")) o.getString("color") else null,
                    fontFamily = if (o.has("fontFamily") && !o.isNull("fontFamily")) o.getString("fontFamily") else null,
                    attachments = attachments
                )
            )
        }
        return list
    }

    /** Notas activas (no eliminadas), ancladas primero. */
    fun getNotes(context: Context): MutableList<Note> =
        getAllRaw(context).filter { !it.deleted }
            .sortedByDescending { it.pinned }
            .toMutableList()

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
            o.put("pinned", n.pinned)
            o.put("locked", n.locked)
            o.put("color", n.color)
            o.put("fontFamily", n.fontFamily)
            val attArray = JSONArray()
            n.attachments.forEach { attArray.put(it) }
            o.put("attachments", attArray)
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

    fun addNote(context: Context, title: String, text: String): Long {
        val notes = getAllRaw(context)
        val id = nextId(context)
        notes.add(0, Note(id = id, title = title, text = text))
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
        return id
    }

    fun updateNote(context: Context, note: Note) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == note.id }
        if (idx >= 0) {
            notes[idx] = note
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

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

    fun setPinned(context: Context, id: Long, pinned: Boolean) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(pinned = pinned)
            saveNotes(context, notes)
        }
    }

    fun setLocked(context: Context, id: Long, locked: Boolean) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(locked = locked)
            saveNotes(context, notes)
        }
    }

    fun setColor(context: Context, id: Long, color: String?) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(color = color)
            saveNotes(context, notes)
        }
    }

    fun setFontFamily(context: Context, id: Long, fontFamily: String?) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(fontFamily = fontFamily)
            saveNotes(context, notes)
        }
    }

    fun addAttachment(context: Context, id: Long, path: String) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            val updated = notes[idx].attachments.toMutableList().apply { add(path) }
            notes[idx] = notes[idx].copy(attachments = updated)
            saveNotes(context, notes)
        }
    }

    fun removeAttachment(context: Context, id: Long, path: String) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            val updated = notes[idx].attachments.toMutableList().apply { remove(path) }
            notes[idx] = notes[idx].copy(attachments = updated)
            saveNotes(context, notes)
        }
    }
}
