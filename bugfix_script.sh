#!/bin/bash
set -e

mkdir -p app/src/main/res/values
cat > app/src/main/res/values/strings.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Notas</string>
    <string name="notas">Notas</string>
    <string name="tareas">Tareas</string>
    <string name="buscar">Buscar</string>
    <string name="sin_tareas">No hay tareas todavía</string>
    <string name="sin_notas">No hay notas todavía</string>
    <string name="tocar_para_editar">Tocar para editar</string>
    <string name="titulo">Título</string>
    <string name="anota_algo">Anota algo</string>
    <string name="anadir">Añadir</string>
    <string name="guardar">Guardar</string>
    <string name="cancelar">Cancelar</string>
    <string name="anadir_tarea">Añadir tarea</string>
    <string name="anadir_nota">Añadir nota</string>
    <string name="marcar_tarea">Marcar tarea</string>
    <string name="eliminar_tarea">Eliminar tarea</string>
    <string name="eliminar_nota">Eliminar nota</string>
    <string name="vista_lista">Vista de lista</string>
    <string name="vista_tarjeta">Vista de tarjeta</string>
    <string name="vista_cuadricula">Vista de cuadrícula</string>
</resources>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_back.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@android:color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M20,11L7.83,11l5.59,-5.59L12,4l-8,8 8,8 1.41,-1.41L7.83,13L20,13z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/dark_row_flat_background.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="@android:color/transparent" />
    <stroke android:width="1dp" android:color="@color/dark_surface_light" />
    <corners android:radius="4dp" />
</shape>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_add_edit_note.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/dark_bg">

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:padding="16dp">

        <ImageView
            android:id="@+id/backButton"
            android:layout_width="44dp"
            android:layout_height="44dp"
            android:layout_alignParentStart="true"
            android:background="@drawable/circle_button_dark"
            android:padding="11dp"
            android:src="@drawable/ic_back" />

    </RelativeLayout>

    <ScrollView
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="vertical"
            android:padding="20dp">

            <EditText
                android:id="@+id/titleInput"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:hint="@string/titulo"
                android:textColor="@color/white"
                android:textColorHint="@color/dark_text_secondary"
                android:textSize="24sp"
                android:textStyle="bold"
                android:background="@android:color/transparent"
                android:fontFamily="casual" />

            <EditText
                android:id="@+id/bodyInput"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:layout_marginTop="12dp"
                android:hint="@string/anota_algo"
                android:textColor="@color/white"
                android:textColorHint="@color/dark_text_secondary"
                android:textSize="16sp"
                android:minLines="8"
                android:gravity="top"
                android:background="@android:color/transparent" />

        </LinearLayout>

    </ScrollView>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="end"
        android:padding="16dp">

        <TextView
            android:id="@+id/cancelButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/cancelar"
            android:textColor="@color/dark_text_secondary"
            android:padding="10dp" />

        <TextView
            android:id="@+id/saveButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/guardar"
            android:textColor="@color/accent_yellow"
            android:textStyle="bold"
            android:padding="10dp"
            android:layout_marginStart="8dp" />

    </LinearLayout>

</LinearLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/item_note_row.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:gravity="center_vertical"
    android:background="@drawable/dark_row_background"
    android:layout_marginBottom="8dp"
    android:padding="14dp">

    <LinearLayout
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:orientation="vertical">

        <TextView
            android:id="@+id/noteTitle"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:textColor="@color/white"
            android:textSize="16sp"
            android:textStyle="bold"
            android:maxLines="1"
            android:ellipsize="end"
            android:visibility="gone" />

        <TextView
            android:id="@+id/text"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="2dp"
            android:maxLines="3"
            android:ellipsize="end"
            android:textColor="@color/dark_text_secondary"
            android:textSize="14sp" />

    </LinearLayout>

    <ImageView
        android:id="@+id/deleteButton"
        android:layout_width="22dp"
        android:layout_height="22dp"
        android:layout_marginStart="10dp"
        android:padding="1dp"
        android:src="@drawable/ic_trash"
        android:contentDescription="@string/eliminar_nota" />

</LinearLayout>
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/Note.kt << 'ZZEOF'
package com.santos.tareas

data class Note(
    val id: Long,
    var title: String = "",
    var text: String
)
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteRepository.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/**
 * Almacena las notas en SharedPreferences como JSON, igual que TaskRepository
 * pero en un almacén separado. La usan tanto MainActivity/AddEditNoteActivity
 * como el widget de Notas.
 */
object NoteRepository {

    private const val PREFS = "notas_prefs"
    private const val KEY_NOTES = "notes_json"
    private const val KEY_NEXT_ID = "next_id"

    fun getNotes(context: Context): MutableList<Note> {
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
            list.add(
                Note(
                    id = o.getLong("id"),
                    title = if (o.has("title")) o.getString("title") else "",
                    text = o.getString("text")
                )
            )
        }
        return list
    }

    private fun saveNotes(context: Context, notes: List<Note>) {
        val array = JSONArray()
        for (n in notes) {
            val o = JSONObject()
            o.put("id", n.id)
            o.put("title", n.title)
            o.put("text", n.text)
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
        val notes = getNotes(context)
        notes.add(0, Note(id = nextId(context), title = title, text = text))
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
    }

    fun updateNote(context: Context, note: Note) {
        val notes = getNotes(context)
        val idx = notes.indexOfFirst { it.id == note.id }
        if (idx >= 0) {
            notes[idx] = note
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun deleteNote(context: Context, id: Long) {
        val notes = getNotes(context)
        notes.removeAll { it.id == id }
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/AddEditNoteActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.santos.tareas.databinding.ActivityAddEditNoteBinding

class AddEditNoteActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_NOTE_ID = "extra_note_id"
    }

    private lateinit var binding: ActivityAddEditNoteBinding
    private var editingNoteId: Long? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddEditNoteBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val noteId = intent.getLongExtra(EXTRA_NOTE_ID, -1L)
        if (noteId != -1L) {
            editingNoteId = noteId
            val note = NoteRepository.getNotes(this).find { it.id == noteId }
            binding.titleInput.setText(note?.title ?: "")
            binding.bodyInput.setText(note?.text ?: "")
        }

        binding.backButton.setOnClickListener { saveAndFinish() }
        binding.cancelButton.setOnClickListener { finish() }
        binding.saveButton.setOnClickListener { saveAndFinish() }
    }

    private fun saveAndFinish() {
        val title = binding.titleInput.text.toString().trim()
        val body = binding.bodyInput.text.toString().trim()

        if (title.isEmpty() && body.isEmpty()) {
            finish()
            return
        }

        val id = editingNoteId
        if (id != null) {
            NoteRepository.updateNote(this, Note(id = id, title = title, text = body))
        } else {
            NoteRepository.addNote(this, title, body)
        }
        finish()
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteAdapter.kt << 'ZZEOF'
package com.santos.tareas

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.santos.tareas.databinding.ItemNoteRowBinding

class NoteAdapter(
    private val onClick: (Note) -> Unit,
    private val onDelete: (Note) -> Unit
) : RecyclerView.Adapter<NoteAdapter.NoteViewHolder>() {

    private var items: List<Note> = emptyList()
    var flatStyle: Boolean = false

    fun submitList(newItems: List<Note>) {
        items = newItems
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): NoteViewHolder {
        val binding = ItemNoteRowBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return NoteViewHolder(binding)
    }

    override fun onBindViewHolder(holder: NoteViewHolder, position: Int) {
        holder.bind(items[position])
    }

    override fun getItemCount(): Int = items.size

    inner class NoteViewHolder(private val binding: ItemNoteRowBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(note: Note) {
            binding.root.setBackgroundResource(
                if (flatStyle) R.drawable.dark_row_flat_background else R.drawable.dark_row_background
            )
            if (note.title.isNotBlank()) {
                binding.noteTitle.visibility = View.VISIBLE
                binding.noteTitle.text = note.title
            } else {
                binding.noteTitle.visibility = View.GONE
            }
            binding.text.text = note.text
            binding.root.setOnClickListener { onClick(note) }
            binding.deleteButton.setOnClickListener { onDelete(note) }
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/TaskAdapter.kt << 'ZZEOF'
package com.santos.tareas

import android.graphics.Paint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.santos.tareas.databinding.ItemTaskRowBinding

class TaskAdapter(
    private val onToggle: (Task) -> Unit,
    private val onClick: (Task) -> Unit,
    private val onDelete: (Task) -> Unit
) : RecyclerView.Adapter<TaskAdapter.TaskViewHolder>() {

    private var items: List<Task> = emptyList()
    var flatStyle: Boolean = false

    fun submitList(newItems: List<Task>) {
        items = newItems
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TaskViewHolder {
        val binding = ItemTaskRowBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return TaskViewHolder(binding)
    }

    override fun onBindViewHolder(holder: TaskViewHolder, position: Int) {
        holder.bind(items[position])
    }

    override fun getItemCount(): Int = items.size

    inner class TaskViewHolder(private val binding: ItemTaskRowBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(task: Task) {
            binding.root.setBackgroundResource(
                if (flatStyle) R.drawable.dark_row_flat_background else R.drawable.dark_row_background
            )
            binding.title.text = task.title
            binding.checkbox.setImageResource(
                if (task.done) R.drawable.ic_check_circle_filled else R.drawable.ic_check_circle_outline
            )
            binding.title.paintFlags = if (task.done) {
                binding.title.paintFlags or Paint.STRIKE_THRU_TEXT_FLAG
            } else {
                binding.title.paintFlags and Paint.STRIKE_THRU_TEXT_FLAG.inv()
            }
            binding.checkbox.setOnClickListener { onToggle(task) }
            binding.root.setOnClickListener { onClick(task) }
            binding.deleteButton.setOnClickListener { onDelete(task) }
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteRemoteViewsFactory.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import android.widget.RemoteViewsService.RemoteViewsFactory

class NoteRemoteViewsFactory(private val context: Context) : RemoteViewsFactory {

    private var notes: List<Note> = emptyList()

    override fun onCreate() {
        notes = NoteRepository.getNotes(context)
    }

    override fun onDataSetChanged() {
        notes = NoteRepository.getNotes(context)
    }

    override fun onDestroy() {
        notes = emptyList()
    }

    override fun getCount(): Int = notes.size

    override fun getViewAt(position: Int): RemoteViews {
        val note = notes[position]
        val views = RemoteViews(context.packageName, R.layout.widget_note_item)
        val display = if (note.title.isNotBlank()) note.title else note.text
        views.setTextViewText(R.id.note_item_text, display)

        val fillInIntent = Intent().apply {
            putExtra(AddEditNoteActivity.EXTRA_NOTE_ID, note.id)
        }
        views.setOnClickFillInIntent(R.id.note_item_row, fillInIntent)

        return views
    }

    override fun getLoadingView(): RemoteViews? = null
    override fun getViewTypeCount(): Int = 1
    override fun getItemId(position: Int): Long = notes[position].id
    override fun hasStableIds(): Boolean = true
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/MainActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.widget.PopupMenu
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import com.santos.tareas.databinding.ActivityMainBinding

enum class ViewMode { LIST, CARD, GRID }

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var noteAdapter: NoteAdapter
    private lateinit var taskAdapter: TaskAdapter

    private var showingNotes = true
    private var searchQuery = ""
    private var viewMode = ViewMode.CARD

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        noteAdapter = NoteAdapter(
            onClick = { note ->
                val intent = Intent(this, AddEditNoteActivity::class.java)
                intent.putExtra(AddEditNoteActivity.EXTRA_NOTE_ID, note.id)
                startActivity(intent)
            },
            onDelete = { note ->
                NoteRepository.deleteNote(this, note.id)
                refresh()
            }
        )

        taskAdapter = TaskAdapter(
            onToggle = { task ->
                TaskRepository.toggleDone(this, task.id)
                refresh()
            },
            onClick = { task ->
                val intent = Intent(this, AddEditTaskActivity::class.java)
                intent.putExtra(AddEditTaskActivity.EXTRA_TASK_ID, task.id)
                startActivity(intent)
            },
            onDelete = { task ->
                TaskRepository.deleteTask(this, task.id)
                refresh()
            }
        )

        binding.tabNotas.setOnClickListener { selectTab(notes = true) }
        binding.tabTareas.setOnClickListener { selectTab(notes = false) }

        binding.fabAdd.setOnClickListener {
            if (showingNotes) {
                startActivity(Intent(this, AddEditNoteActivity::class.java))
            } else {
                startActivity(Intent(this, AddEditTaskActivity::class.java))
            }
        }

        binding.menuButton.setOnClickListener { showViewModeMenu() }

        binding.searchInput.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                searchQuery = s?.toString().orEmpty()
                refresh()
            }
            override fun afterTextChanged(s: Editable?) {}
        })

        applyViewMode()
        selectTab(notes = true)
    }

    override fun onResume() {
        super.onResume()
        refresh()
    }

    private fun showViewModeMenu() {
        val popup = PopupMenu(this, binding.menuButton)
        popup.menu.add(0, 0, 0, getString(R.string.vista_lista))
        popup.menu.add(0, 1, 1, getString(R.string.vista_tarjeta))
        popup.menu.add(0, 2, 2, getString(R.string.vista_cuadricula))
        popup.setOnMenuItemClickListener { item ->
            viewMode = when (item.itemId) {
                0 -> ViewMode.LIST
                2 -> ViewMode.GRID
                else -> ViewMode.CARD
            }
            applyViewMode()
            true
        }
        popup.show()
    }

    private fun applyViewMode() {
        binding.recyclerView.layoutManager = when (viewMode) {
            ViewMode.GRID -> GridLayoutManager(this, 2)
            else -> LinearLayoutManager(this)
        }
        val flat = viewMode == ViewMode.LIST
        noteAdapter.flatStyle = flat
        taskAdapter.flatStyle = flat
        refresh()
    }

    private fun selectTab(notes: Boolean) {
        showingNotes = notes
        binding.tabNotas.setBackgroundResource(if (notes) R.drawable.pill_selected_background else 0)
        binding.tabTareas.setBackgroundResource(if (!notes) R.drawable.pill_selected_background else 0)
        binding.tabNotas.setTextColor(
            resources.getColor(if (notes) R.color.accent_yellow else R.color.white, theme)
        )
        binding.tabTareas.setTextColor(
            resources.getColor(if (!notes) R.color.accent_yellow else R.color.white, theme)
        )
        binding.recyclerView.adapter = if (notes) noteAdapter else taskAdapter
        binding.emptyText.text = getString(if (notes) R.string.sin_notas else R.string.sin_tareas)
        refresh()
    }

    private fun refresh() {
        if (showingNotes) {
            val notes = NoteRepository.getNotes(this).filter {
                searchQuery.isBlank() ||
                    it.title.contains(searchQuery, ignoreCase = true) ||
                    it.text.contains(searchQuery, ignoreCase = true)
            }
            noteAdapter.submitList(notes)
            binding.emptyView.visibility = if (notes.isEmpty()) android.view.View.VISIBLE else android.view.View.GONE
        } else {
            val tasks = TaskRepository.getTasks(this).filter {
                searchQuery.isBlank() || it.title.contains(searchQuery, ignoreCase = true)
            }
            taskAdapter.submitList(tasks)
            binding.emptyView.visibility = if (tasks.isEmpty()) android.view.View.VISIBLE else android.view.View.GONE
        }
    }
}
ZZEOF

echo "Título/cuerpo de notas y menú de vistas listos. Compilando..."
./gradlew assembleDebug