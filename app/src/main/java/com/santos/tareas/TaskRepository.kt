package com.santos.tareas

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/**
 * Almacena la lista de tareas en SharedPreferences como JSON.
 * Es la única fuente de datos: la usan tanto MainActivity/AddEditTaskActivity
 * como el widget (TaskWidgetService), así que cualquier cambio se refleja
 * en ambos sitios en cuanto se notifica la actualización del widget.
 */
object TaskRepository {

    private const val PREFS = "tareas_prefs"
    private const val KEY_TASKS = "tasks_json"
    private const val KEY_NEXT_ID = "next_id"

    fun getTasks(context: Context): MutableList<Task> {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val json = prefs.getString(KEY_TASKS, null) ?: return mutableListOf()
        val array = JSONArray(json)
        val list = mutableListOf<Task>()
        for (i in 0 until array.length()) {
            val o = array.getJSONObject(i)
            list.add(
                Task(
                    id = o.getLong("id"),
                    title = o.getString("title"),
                    done = o.getBoolean("done")
                )
            )
        }
        return list
    }

    private fun saveTasks(context: Context, tasks: List<Task>) {
        val array = JSONArray()
        for (t in tasks) {
            val o = JSONObject()
            o.put("id", t.id)
            o.put("title", t.title)
            o.put("done", t.done)
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
        val tasks = getTasks(context)
        tasks.add(Task(id = nextId(context), title = title, done = false))
        saveTasks(context, tasks)
        WidgetUpdater.updateAll(context)
    }

    fun updateTask(context: Context, task: Task) {
        val tasks = getTasks(context)
        val idx = tasks.indexOfFirst { it.id == task.id }
        if (idx >= 0) {
            tasks[idx] = task
            saveTasks(context, tasks)
            WidgetUpdater.updateAll(context)
        }
    }

    fun toggleDone(context: Context, id: Long) {
        val tasks = getTasks(context)
        val idx = tasks.indexOfFirst { it.id == id }
        if (idx >= 0) {
            tasks[idx] = tasks[idx].copy(done = !tasks[idx].done)
            saveTasks(context, tasks)
            WidgetUpdater.updateAll(context)
        }
    }

    fun deleteTask(context: Context, id: Long) {
        val tasks = getTasks(context)
        tasks.removeAll { it.id == id }
        saveTasks(context, tasks)
        WidgetUpdater.updateAll(context)
    }
}
