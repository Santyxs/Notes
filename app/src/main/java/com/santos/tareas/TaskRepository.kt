package com.santos.tareas

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/**
 * Almacena la lista de tareas en SharedPreferences como JSON.
 * Es la única fuente de datos: la usan tanto MainActivity/AddEditTaskActivity
 * como el widget (TaskWidgetService), así que cualquier cambio se refleja
 * en ambos sitios en cuanto se notifica la actualización del widget.
 *
 * "Eliminar" no borra al momento: marca la tarea como `deleted` para que
 * pase a la papelera, igual que las notas.
 */
object TaskRepository {

    private const val PREFS = "tareas_prefs"
    private const val KEY_TASKS = "tasks_json"
    private const val KEY_NEXT_ID = "next_id"

    // Caché en memoria, igual que en NoteRepository: evita reparsear todo el
    // JSON en cada operación (marcar hecha, borrar, cambiar prioridad...).
    private var cache: MutableList<Task>? = null

    private fun getAllRaw(context: Context): MutableList<Task> {
        cache?.let { return it }

        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val json = prefs.getString(KEY_TASKS, null)
        if (json == null) {
            val seed = mutableListOf(
                Task(id = nextId(context), title = "Bienvenido a Tareas", done = false),
                Task(id = nextId(context), title = "Crear una tarea", done = false),
                Task(id = nextId(context), title = "Tocar para editar", done = false)
            )
            saveTasks(context, seed)
            return seed
        }
        val array = JSONArray(json)
        val list = mutableListOf<Task>()
        for (i in 0 until array.length()) {
            val o = array.getJSONObject(i)
            list.add(
                Task(
                    id = o.getLong("id"),
                    title = o.getString("title"),
                    done = o.getBoolean("done"),
                    deleted = if (o.has("deleted")) o.getBoolean("deleted") else false,
                    createdAt = if (o.has("createdAt")) o.getLong("createdAt") else o.getLong("id"),
                    priority = if (o.has("priority")) o.getInt("priority") else 0,
                    reminderAt = if (o.has("reminderAt")) o.getLong("reminderAt") else 0L
                )
            )
        }
        cache = list
        return list
    }

    /** Tareas activas (no eliminadas) — lo que se muestra normalmente. */
    fun getTasks(context: Context): MutableList<Task> =
        getAllRaw(context).filter { !it.deleted }.toMutableList()

    /** Tareas en la papelera. */
    fun getDeletedTasks(context: Context): MutableList<Task> =
        getAllRaw(context).filter { it.deleted }.toMutableList()

    private fun saveTasks(context: Context, tasks: List<Task>) {
        cache = tasks.toMutableList()
        val array = JSONArray()
        for (t in tasks) {
            val o = JSONObject()
            o.put("id", t.id)
            o.put("title", t.title)
            o.put("done", t.done)
            o.put("deleted", t.deleted)
            o.put("createdAt", t.createdAt)
            o.put("priority", t.priority)
            o.put("reminderAt", t.reminderAt)
            array.put(o)
        }
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .edit()
            .putString(KEY_TASKS, array.toString())
            .apply()
    }

    private fun nextId(context: Context): Long {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val id = prefs.getLong(KEY_NEXT_ID, 1L)
        prefs.edit().putLong(KEY_NEXT_ID, id + 1).apply()
        return id
    }

    fun addTask(context: Context, title: String) {
        val tasks = getAllRaw(context)
        tasks.add(Task(id = nextId(context), title = title, done = false, createdAt = System.currentTimeMillis()))
        saveTasks(context, tasks)
        WidgetUpdater.updateAll(context)
    }

    fun updateTask(context: Context, task: Task) {
        val tasks = getAllRaw(context)
        val idx = tasks.indexOfFirst { it.id == task.id }
        if (idx >= 0) {
            tasks[idx] = task
            saveTasks(context, tasks)
            WidgetUpdater.updateAll(context)
        }
    }

    fun toggleDone(context: Context, id: Long) {
        val tasks = getAllRaw(context)
        val idx = tasks.indexOfFirst { it.id == id }
        if (idx >= 0) {
            val updated = tasks[idx].copy(done = !tasks[idx].done)
            tasks[idx] = updated
            saveTasks(context, tasks)
            if (updated.done) {
                ReminderManager.cancel(context, id)
            } else if (updated.reminderAt > System.currentTimeMillis()) {
                ReminderManager.schedule(context, id, updated.reminderAt)
            }
            WidgetUpdater.updateAll(context)
        }
    }

    /** Mueve la tarea a la papelera (no la borra todavía). */
    fun deleteTask(context: Context, id: Long) {
        val tasks = getAllRaw(context)
        val idx = tasks.indexOfFirst { it.id == id }
        if (idx >= 0) {
            tasks[idx] = tasks[idx].copy(deleted = true)
            saveTasks(context, tasks)
            ReminderManager.cancel(context, id)
            WidgetUpdater.updateAll(context)
        }
    }

    fun restoreTask(context: Context, id: Long) {
        val tasks = getAllRaw(context)
        val idx = tasks.indexOfFirst { it.id == id }
        if (idx >= 0) {
            tasks[idx] = tasks[idx].copy(deleted = false)
            saveTasks(context, tasks)
            WidgetUpdater.updateAll(context)
        }
    }

    /** Borra definitivamente una tarea de la papelera. */
    fun permanentlyDeleteTask(context: Context, id: Long) {
        val tasks = getAllRaw(context)
        tasks.removeAll { it.id == id }
        saveTasks(context, tasks)
        ReminderManager.cancel(context, id)
        WidgetUpdater.updateAll(context)
    }

    /** Todas las tareas, incluidas las de la papelera (para copia de seguridad). */
    fun getAllIncludingDeleted(context: Context): List<Task> = getAllRaw(context)

    /** Sustituye todos los datos por una lista importada (copia de seguridad). */
    fun replaceAll(context: Context, tasks: List<Task>) {
        saveTasks(context, tasks)
    }

    fun emptyTrash(context: Context) {
        val tasks = getAllRaw(context)
        tasks.removeAll { it.deleted }
        saveTasks(context, tasks)
        WidgetUpdater.updateAll(context)
    }
}
