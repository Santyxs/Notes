#!/bin/bash
set -e

mkdir -p app/src/main
cat > app/src/main/AndroidManifest.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.Tareas">

        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:label="@string/app_name">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <activity
            android:name=".TasksActivity"
            android:exported="false"
            android:label="@string/tareas" />

        <activity
            android:name=".NotesActivity"
            android:exported="false"
            android:label="@string/notas" />

        <activity
            android:name=".AddEditTaskActivity"
            android:exported="false"
            android:label="@string/tareas"
            android:theme="@style/Theme.Tareas.Dialog" />

        <activity
            android:name=".AddEditNoteActivity"
            android:exported="false"
            android:label="@string/notas"
            android:theme="@style/Theme.Tareas.Dialog" />

        <receiver
            android:name=".TaskWidgetProvider"
            android:exported="false"
            android:label="">
            <intent-filter>
                <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
            </intent-filter>
            <meta-data
                android:name="android.appwidget.provider"
                android:resource="@xml/task_widget_info" />
        </receiver>

        <receiver
            android:name=".NoteWidgetProvider"
            android:exported="false"
            android:label="">
            <intent-filter>
                <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
            </intent-filter>
            <meta-data
                android:name="android.appwidget.provider"
                android:resource="@xml/note_widget_info" />
        </receiver>

        <service
            android:name=".TaskWidgetService"
            android:exported="false"
            android:permission="android.permission.BIND_REMOTEVIEWS" />

        <service
            android:name=".NoteWidgetService"
            android:exported="false"
            android:permission="android.permission.BIND_REMOTEVIEWS" />

    </application>

</manifest>
ZZEOF

mkdir -p app/src/main/res/values
cat > app/src/main/res/values/strings.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Notas</string>
    <string name="notas">Notas</string>
    <string name="tareas">Tareas</string>
    <string name="sin_tareas">No hay tareas todavía</string>
    <string name="sin_notas">No hay notas todavía</string>
    <string name="tocar_para_editar">Tocar para editar</string>
    <string name="anadir">Añadir</string>
    <string name="guardar">Guardar</string>
    <string name="cancelar">Cancelar</string>
    <string name="anadir_tarea">Añadir tarea</string>
    <string name="anadir_nota">Añadir nota</string>
    <string name="marcar_tarea">Marcar tarea</string>
    <string name="eliminar_tarea">Eliminar tarea</string>
    <string name="eliminar_nota">Eliminar nota</string>
</resources>
ZZEOF

mkdir -p app/src/main/res/values
cat > app/src/main/res/values/colors.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="card_cream">#FCEBB6</color>
    <color name="accent_yellow">#F5A623</color>
    <color name="text_brown">#5C4322</color>
    <color name="text_brown_light">#A9895C</color>
    <color name="background_app">#0B1E45</color>
    <color name="white">#FFFFFF</color>
</resources>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/widget_card_background.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="@color/card_cream" />
    <corners android:radius="28dp" />
</shape>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_note.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="#F5A623">
    <path
        android:fillColor="#F5A623"
        android:pathData="M6,2 L18,2 C19.1,2 20,2.9 20,4 L20,20 C20,21.1 19.1,22 18,22 L6,22 C4.9,22 4,21.1 4,20 L4,4 C4,2.9 4.9,2 6,2 Z M7,7 L17,7 L17,9 L7,9 Z M7,11 L17,11 L17,13 L7,13 Z M7,15 L13,15 L13,17 L7,17 Z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_main.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/background_app"
    android:padding="24dp"
    android:gravity="center">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="@string/app_name"
        android:textColor="@color/white"
        android:textSize="30sp"
        android:textStyle="bold"
        android:layout_marginBottom="32dp" />

    <LinearLayout
        android:id="@+id/notesCard"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="center_vertical"
        android:background="@drawable/widget_card_background"
        android:padding="20dp"
        android:layout_marginBottom="16dp">

        <ImageView
            android:layout_width="36dp"
            android:layout_height="36dp"
            android:src="@drawable/ic_note"
            android:layout_marginEnd="16dp" />

        <TextView
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:text="@string/notas"
            android:textColor="@color/text_brown"
            android:textSize="20sp"
            android:textStyle="bold" />
    </LinearLayout>

    <LinearLayout
        android:id="@+id/tasksCard"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="center_vertical"
        android:background="@drawable/widget_card_background"
        android:padding="20dp">

        <ImageView
            android:layout_width="36dp"
            android:layout_height="36dp"
            android:src="@drawable/ic_check_circle_filled"
            android:layout_marginEnd="16dp" />

        <TextView
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:text="@string/tareas"
            android:textColor="@color/text_brown"
            android:textSize="20sp"
            android:textStyle="bold" />
    </LinearLayout>

</LinearLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_tasks.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/background_app">

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:padding="20dp">

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/tareas"
            android:textColor="@color/text_brown"
            android:textSize="26sp"
            android:textStyle="bold" />

        <ImageView
            android:id="@+id/addButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_alignParentEnd="true"
            android:background="@drawable/widget_add_button_background"
            android:padding="8dp"
            android:src="@drawable/ic_plus"
            android:contentDescription="@string/anadir_tarea" />
    </RelativeLayout>

    <androidx.recyclerview.widget.RecyclerView
        android:id="@+id/recyclerView"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:paddingHorizontal="12dp"
        android:clipToPadding="false" />

    <TextView
        android:id="@+id/emptyView"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:gravity="center"
        android:visibility="gone"
        android:text="@string/sin_tareas"
        android:textColor="@color/text_brown_light"
        android:textSize="16sp" />

</LinearLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_notes.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/background_app">

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:padding="20dp">

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/notas"
            android:textColor="@color/text_brown"
            android:textSize="26sp"
            android:textStyle="bold" />

        <ImageView
            android:id="@+id/addButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_alignParentEnd="true"
            android:background="@drawable/widget_add_button_background"
            android:padding="8dp"
            android:src="@drawable/ic_plus"
            android:contentDescription="@string/anadir_nota" />
    </RelativeLayout>

    <androidx.recyclerview.widget.RecyclerView
        android:id="@+id/recyclerView"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:paddingHorizontal="12dp"
        android:clipToPadding="false" />

    <TextView
        android:id="@+id/emptyView"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:gravity="center"
        android:visibility="gone"
        android:text="@string/sin_notas"
        android:textColor="@color/text_brown_light"
        android:textSize="16sp" />

</LinearLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_add_edit_note.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical"
    android:background="@drawable/widget_card_background"
    android:padding="20dp"
    android:layout_margin="24dp">

    <EditText
        android:id="@+id/noteInput"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:minLines="4"
        android:gravity="top"
        android:hint="@string/tocar_para_editar"
        android:textColor="@color/text_brown"
        android:textColorHint="@color/text_brown_light"
        android:background="@android:color/transparent"
        android:textSize="16sp" />

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="end"
        android:layout_marginTop="16dp">

        <TextView
            android:id="@+id/cancelButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/cancelar"
            android:textColor="@color/text_brown_light"
            android:padding="10dp" />

        <TextView
            android:id="@+id/saveButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/anadir"
            android:textColor="@color/text_brown"
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
    android:background="@drawable/widget_card_background"
    android:layout_marginBottom="8dp"
    android:padding="14dp">

    <TextView
        android:id="@+id/text"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:maxLines="3"
        android:ellipsize="end"
        android:textColor="@color/text_brown"
        android:textSize="15sp" />

    <ImageView
        android:id="@+id/deleteButton"
        android:layout_width="24dp"
        android:layout_height="24dp"
        android:layout_marginStart="10dp"
        android:padding="2dp"
        android:src="@android:drawable/ic_menu_delete"
        android:contentDescription="@string/eliminar_nota" />

</LinearLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/widget_note.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@drawable/widget_card_background"
    android:padding="16dp">

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:paddingBottom="8dp">

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_centerVertical="true"
            android:text="@string/notas"
            android:textColor="@color/text_brown"
            android:textSize="20sp"
            android:textStyle="bold"
            android:fontFamily="casual" />

        <ImageView
            android:id="@+id/widget_note_add_button"
            android:layout_width="32dp"
            android:layout_height="32dp"
            android:layout_alignParentEnd="true"
            android:layout_centerVertical="true"
            android:background="@drawable/widget_add_button_background"
            android:padding="6dp"
            android:src="@drawable/ic_plus"
            android:contentDescription="@string/anadir_nota" />
    </RelativeLayout>

    <ListView
        android:id="@+id/widget_note_list"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:divider="@null"
        android:dividerHeight="4dp"
        android:listSelector="@android:color/transparent" />

    <TextView
        android:id="@+id/widget_note_empty"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:gravity="center"
        android:text="@string/sin_notas"
        android:textColor="@color/text_brown_light"
        android:textSize="14sp" />

</LinearLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/widget_note_item.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/note_item_row"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical"
    android:paddingTop="8dp"
    android:paddingBottom="8dp">

    <TextView
        android:id="@+id/note_item_text"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:maxLines="2"
        android:ellipsize="end"
        android:textColor="@color/text_brown"
        android:textSize="14sp"
        android:fontFamily="casual" />

</LinearLayout>
ZZEOF

mkdir -p app/src/main/res/xml
cat > app/src/main/res/xml/note_widget_info.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<appwidget-provider xmlns:android="http://schemas.android.com/apk/res/android"
    android:label=""
    android:minWidth="180dp"
    android:minHeight="180dp"
    android:targetCellWidth="3"
    android:targetCellHeight="2"
    android:updatePeriodMillis="0"
    android:initialLayout="@layout/widget_note"
    android:resizeMode="vertical|horizontal"
    android:widgetCategory="home_screen" />
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/MainActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.santos.tareas.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.notesCard.setOnClickListener {
            startActivity(Intent(this, NotesActivity::class.java))
        }
        binding.tasksCard.setOnClickListener {
            startActivity(Intent(this, TasksActivity::class.java))
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/TasksActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.santos.tareas.databinding.ActivityTasksBinding

class TasksActivity : AppCompatActivity() {

    private lateinit var binding: ActivityTasksBinding
    private lateinit var adapter: TaskAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityTasksBinding.inflate(layoutInflater)
        setContentView(binding.root)

        adapter = TaskAdapter(
            onToggle = { task ->
                TaskRepository.toggleDone(this, task.id)
                loadTasks()
            },
            onClick = { task ->
                val intent = Intent(this, AddEditTaskActivity::class.java)
                intent.putExtra(AddEditTaskActivity.EXTRA_TASK_ID, task.id)
                startActivity(intent)
            },
            onDelete = { task ->
                TaskRepository.deleteTask(this, task.id)
                loadTasks()
            }
        )
        binding.recyclerView.layoutManager = LinearLayoutManager(this)
        binding.recyclerView.adapter = adapter

        binding.addButton.setOnClickListener {
            startActivity(Intent(this, AddEditTaskActivity::class.java))
        }
    }

    override fun onResume() {
        super.onResume()
        loadTasks()
    }

    private fun loadTasks() {
        val tasks = TaskRepository.getTasks(this)
        adapter.submitList(tasks)
        binding.emptyView.visibility =
            if (tasks.isEmpty()) android.view.View.VISIBLE else android.view.View.GONE
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/Note.kt << 'ZZEOF'
package com.santos.tareas

data class Note(
    val id: Long,
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
 * pero en un almacén separado. La usan tanto NotesActivity/AddEditNoteActivity
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
                Note(id = nextId(context), text = "Bienvenido a Notas"),
                Note(id = nextId(context), text = "Toca + para crear una nota nueva")
            )
            saveNotes(context, seed)
            return seed
        }
        val array = JSONArray(json)
        val list = mutableListOf<Note>()
        for (i in 0 until array.length()) {
            val o = array.getJSONObject(i)
            list.add(Note(id = o.getLong("id"), text = o.getString("text")))
        }
        return list
    }

    private fun saveNotes(context: Context, notes: List<Note>) {
        val array = JSONArray()
        for (n in notes) {
            val o = JSONObject()
            o.put("id", n.id)
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

    fun addNote(context: Context, text: String) {
        val notes = getNotes(context)
        notes.add(0, Note(id = nextId(context), text = text))
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
cat > app/src/main/java/com/santos/tareas/NoteAdapter.kt << 'ZZEOF'
package com.santos.tareas

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.santos.tareas.databinding.ItemNoteRowBinding

class NoteAdapter(
    private val onClick: (Note) -> Unit,
    private val onDelete: (Note) -> Unit
) : RecyclerView.Adapter<NoteAdapter.NoteViewHolder>() {

    private var items: List<Note> = emptyList()

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
            binding.text.text = note.text
            binding.root.setOnClickListener { onClick(note) }
            binding.deleteButton.setOnClickListener { onDelete(note) }
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NotesActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.santos.tareas.databinding.ActivityNotesBinding

class NotesActivity : AppCompatActivity() {

    private lateinit var binding: ActivityNotesBinding
    private lateinit var adapter: NoteAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityNotesBinding.inflate(layoutInflater)
        setContentView(binding.root)

        adapter = NoteAdapter(
            onClick = { note ->
                val intent = Intent(this, AddEditNoteActivity::class.java)
                intent.putExtra(AddEditNoteActivity.EXTRA_NOTE_ID, note.id)
                startActivity(intent)
            },
            onDelete = { note ->
                NoteRepository.deleteNote(this, note.id)
                loadNotes()
            }
        )
        binding.recyclerView.layoutManager = LinearLayoutManager(this)
        binding.recyclerView.adapter = adapter

        binding.addButton.setOnClickListener {
            startActivity(Intent(this, AddEditNoteActivity::class.java))
        }
    }

    override fun onResume() {
        super.onResume()
        loadNotes()
    }

    private fun loadNotes() {
        val notes = NoteRepository.getNotes(this)
        adapter.submitList(notes)
        binding.emptyView.visibility =
            if (notes.isEmpty()) android.view.View.VISIBLE else android.view.View.GONE
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
            binding.noteInput.setText(note?.text ?: "")
            binding.saveButton.text = getString(R.string.guardar)
        }

        binding.saveButton.setOnClickListener {
            val text = binding.noteInput.text.toString().trim()
            if (text.isNotEmpty()) {
                val id = editingNoteId
                if (id != null) {
                    NoteRepository.updateNote(this, Note(id = id, text = text))
                } else {
                    NoteRepository.addNote(this, text)
                }
                finish()
            }
        }

        binding.cancelButton.setOnClickListener { finish() }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteWidgetProvider.kt << 'ZZEOF'
package com.santos.tareas

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.RemoteViews

class NoteWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (widgetId in appWidgetIds) {
            updateWidget(context, appWidgetManager, widgetId)
        }
    }

    private fun updateWidget(context: Context, appWidgetManager: AppWidgetManager, widgetId: Int) {
        val views = RemoteViews(context.packageName, R.layout.widget_note)

        val addIntent = Intent(context, AddEditNoteActivity::class.java)
        val addPendingIntent = PendingIntent.getActivity(
            context, 0, addIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        views.setOnClickPendingIntent(R.id.widget_note_add_button, addPendingIntent)

        val serviceIntent = Intent(context, NoteWidgetService::class.java).apply {
            putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
            data = Uri.parse(toUri(Intent.URI_INTENT_SCHEME))
        }
        views.setRemoteAdapter(R.id.widget_note_list, serviceIntent)
        views.setEmptyView(R.id.widget_note_list, R.id.widget_note_empty)

        // Tocar una nota abre la app para editarla
        val openIntent = Intent(context, AddEditNoteActivity::class.java)
        val openPendingIntent = PendingIntent.getActivity(
            context, 1, openIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
        )
        views.setPendingIntentTemplate(R.id.widget_note_list, openPendingIntent)

        appWidgetManager.updateAppWidget(widgetId, views)
        appWidgetManager.notifyAppWidgetViewDataChanged(widgetId, R.id.widget_note_list)
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteWidgetService.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Intent
import android.widget.RemoteViewsService

class NoteWidgetService : RemoteViewsService() {
    override fun onGetViewFactory(intent: Intent): RemoteViewsFactory {
        return NoteRemoteViewsFactory(applicationContext)
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
        views.setTextViewText(R.id.note_item_text, note.text)

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
cat > app/src/main/java/com/santos/tareas/WidgetUpdater.kt << 'ZZEOF'
package com.santos.tareas

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.widget.RemoteViews

object WidgetUpdater {
    fun updateAll(context: Context) {
        val manager = AppWidgetManager.getInstance(context)

        val taskIds = manager.getAppWidgetIds(ComponentName(context, TaskWidgetProvider::class.java))
        manager.notifyAppWidgetViewDataChanged(taskIds, R.id.widget_list)

        val noteIds = manager.getAppWidgetIds(ComponentName(context, NoteWidgetProvider::class.java))
        manager.notifyAppWidgetViewDataChanged(noteIds, R.id.widget_note_list)
    }
}
ZZEOF
mkdir -p app/src/main/res/mipmap-mdpi
base64 -d << 'ZZEOF' > app/src/main/res/mipmap-mdpi/ic_launcher.png
iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAw0lEQVR42u2awQ2AIAxFnUVHcQ3ncwSX8uzNRE8c1KAglH7KJ+kR8l5iG2jtOi7Da1+Xw0VVsKFRJTSETE7w4iKS8KISJcDFRDTgs0lowidLIMAnSVQtgAQfLYEIHyVRtUDoQdPY/w5RCd+mbR4uQQEJgbdNSAJeia9NDh42mZGrDwXunxBcDoTCoyTxQ4IC2gIsoxRovYyauAvxOo0sYPJZyUd9a60VthbZ4G2xxc4JjZkZmZkppYk5sZlJval/JbTWCao0KVVz0GTkAAAAAElFTkSuQmCC
ZZEOF

mkdir -p app/src/main/res/mipmap-mdpi
base64 -d << 'ZZEOF' > app/src/main/res/mipmap-mdpi/ic_launcher_round.png
iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAw0lEQVR42u2awQ2AIAxFnUVHcQ3ncwSX8uzNRE8c1KAglH7KJ+kR8l5iG2jtOi7Da1+Xw0VVsKFRJTSETE7w4iKS8KISJcDFRDTgs0lowidLIMAnSVQtgAQfLYEIHyVRtUDoQdPY/w5RCd+mbR4uQQEJgbdNSAJeia9NDh42mZGrDwXunxBcDoTCoyTxQ4IC2gIsoxRovYyauAvxOo0sYPJZyUd9a60VthbZ4G2xxc4JjZkZmZkppYk5sZlJval/JbTWCao0KVVz0GTkAAAAAElFTkSuQmCC
ZZEOF

mkdir -p app/src/main/res/mipmap-hdpi
base64 -d << 'ZZEOF' > app/src/main/res/mipmap-hdpi/ic_launcher.png
iVBORw0KGgoAAAANSUhEUgAAAEgAAABICAYAAABV7bNHAAABHklEQVR42u3csQ3CQAyF4ZsFRskazMcILEWdDgkq0AkJEcw552f/ltxQXPEJXazYTmsEQVSI2/Vyf08gjAlKBSxPFHmsGTgSSDNhQkNFggkHFRlnOpICzjQkJZzdkRRxdkNSxnFHyoDjhpQJZzhSRpyhSAAVxRmCBFBxHDNSJRwT0tZD1/Pxlc/fTsvBLaWAepweKT2Q5d/TpyrQZiSAALID/XLYpzso9dPMcmAmHBegUvUQQABxB7kBWWGyVNJfkUYAqddBAAEUHIiLmkqaOggggKikNYCyVtK8UeSVK0AarZ+yfbF/O6u0nunNM90BEgNUjOExxMkoMMPkrCOAw7YP+2IgsZbJYi/r4XxgABi+3RETq2ULUAbCNYKQjwe+yNpqcqjDQQAAAABJRU5ErkJggg==
ZZEOF

mkdir -p app/src/main/res/mipmap-hdpi
base64 -d << 'ZZEOF' > app/src/main/res/mipmap-hdpi/ic_launcher_round.png
iVBORw0KGgoAAAANSUhEUgAAAEgAAABICAYAAABV7bNHAAABHklEQVR42u3csQ3CQAyF4ZsFRskazMcILEWdDgkq0AkJEcw552f/ltxQXPEJXazYTmsEQVSI2/Vyf08gjAlKBSxPFHmsGTgSSDNhQkNFggkHFRlnOpICzjQkJZzdkRRxdkNSxnFHyoDjhpQJZzhSRpyhSAAVxRmCBFBxHDNSJRwT0tZD1/Pxlc/fTsvBLaWAepweKT2Q5d/TpyrQZiSAALID/XLYpzso9dPMcmAmHBegUvUQQABxB7kBWWGyVNJfkUYAqddBAAEUHIiLmkqaOggggKikNYCyVtK8UeSVK0AarZ+yfbF/O6u0nunNM90BEgNUjOExxMkoMMPkrCOAw7YP+2IgsZbJYi/r4XxgABi+3RETq2ULUAbCNYKQjwe+yNpqcqjDQQAAAABJRU5ErkJggg==
ZZEOF

mkdir -p app/src/main/res/mipmap-xhdpi
base64 -d << 'ZZEOF' > app/src/main/res/mipmap-xhdpi/ic_launcher.png
iVBORw0KGgoAAAANSUhEUgAAAGAAAABgCAYAAADimHc4AAABfklEQVR42u3cQUoDQRCG0T6LHiXX8HwewUu5dicoLgQhGJNxMn9X1yvolYvA94TpTmZmDGOMMabQvL++fPy21Dkg8talaiA6jImiw5gsfEuIGcO3gKgQfkmIiuGXgVghflmEleKXQlgxfBmIDvGnRegUfzqEjvGnQegcP44gfhBB9DCC4EEAsYMIIgcRxA0jCBsEEDWMIGgQQMwwgpBBABHDCFs+8O358Wx9/+3p9BBZJQH2iv8ToSPAZoS9Ab4WgDsC/BUfQPi/vzPAzQgACgK4CO8E8N8PurQNdSZw+AIAAAAAAADWBrAD2ghwjy2oc8ANCAAKA/gqAgAAAK4BAC4BWAdsRZ0DnIQBWAAAWAB6Arg1MfjDvIOY+4IAAAjdngjA3dEAXIQnfUjD3t8zYh7UEx+Ah7XFB+CFHeID8NIm8SF4cZ/4ALy8VXwIXuAtPoTa8TsijFlHfBC9w6+KMKqO+CB6h68IMTqM8CB6h09jqB3AUPUAHHWMMebq+QRXB4V/JD/nXAAAAABJRU5ErkJggg==
ZZEOF

mkdir -p app/src/main/res/mipmap-xhdpi
base64 -d << 'ZZEOF' > app/src/main/res/mipmap-xhdpi/ic_launcher_round.png
iVBORw0KGgoAAAANSUhEUgAAAGAAAABgCAYAAADimHc4AAABfklEQVR42u3cQUoDQRCG0T6LHiXX8HwewUu5dicoLgQhGJNxMn9X1yvolYvA94TpTmZmDGOMMabQvL++fPy21Dkg8talaiA6jImiw5gsfEuIGcO3gKgQfkmIiuGXgVghflmEleKXQlgxfBmIDvGnRegUfzqEjvGnQegcP44gfhBB9DCC4EEAsYMIIgcRxA0jCBsEEDWMIGgQQMwwgpBBABHDCFs+8O358Wx9/+3p9BBZJQH2iv8ToSPAZoS9Ab4WgDsC/BUfQPi/vzPAzQgACgK4CO8E8N8PurQNdSZw+AIAAAAAAADWBrAD2ghwjy2oc8ANCAAKA/gqAgAAAK4BAC4BWAdsRZ0DnIQBWAAAWAB6Arg1MfjDvIOY+4IAAAjdngjA3dEAXIQnfUjD3t8zYh7UEx+Ah7XFB+CFHeID8NIm8SF4cZ/4ALy8VXwIXuAtPoTa8TsijFlHfBC9w6+KMKqO+CB6h68IMTqM8CB6h09jqB3AUPUAHHWMMebq+QRXB4V/JD/nXAAAAABJRU5ErkJggg==
ZZEOF

mkdir -p app/src/main/res/mipmap-xxhdpi
base64 -d << 'ZZEOF' > app/src/main/res/mipmap-xxhdpi/ic_launcher.png
iVBORw0KGgoAAAANSUhEUgAAAJAAAACQCAYAAADnRuK4AAACGklEQVR42u3dwQ2CQBAFUGrRUmzD+izBpjx7M8G7gUAky+zsvJ/8u9l5IYaFZZpEREREREREQvJ5Pee9tVqQNKtVhgUqaPqtKUEDEzggQTNoTRkckOCBCByQwFGQ4IEIHJDggQgcBQkeiOCBCB6I4NFCiAwVInggggcieLQCIkODCB6I4NFkiAwIIHgggkeTITIQgOCBCB5NhsgAAIJHZ4A0FyCLDhE8GoPIQgMEj8YgssAAdQXo/bgu1iAHBHQWnjVE99slVSFqCGgLzxIigBIDisDziwigxIgAAggggGIAnf3neQ0RQEkRRQNyBQIIoKqAWvwogAohavWj/rkPpAAduhOtAO2CZGgAKUDw6EFEFk4BUoAUIAVIAeoUkJuIAwKKggPRIIii8XgmGiC78QABBBBAAFUH5JlogFyBAAIIIIAAqnwfSAFyJ9p2hr0weOzGK0AKkAKkAAGkAKmXC9Wrzd6NB8jpHDrq+UA2UwGyG++YO4CckQgQQJUAeSY6OSAn1TupHiCAAAIoMSDfC/O9sPRfLNTkgHwzFR5fbVaANDEgiOABSGMBQQQPRBqLByCAINJYPAABBBE8fcQw4AEIIIg0KR6I4AEIIIg0OR6I4IEIHoh0ADwQwQMRPBDBA5HCAxE8EMEDETwgKTgQwQMSOBDBAxI4AhI4EMEDEjgwQSOVIJkeTNDABI10hMoqwwWJiIiIiIi0yReCdt1uNzZy0wAAAABJRU5ErkJggg==
ZZEOF

mkdir -p app/src/main/res/mipmap-xxhdpi
base64 -d << 'ZZEOF' > app/src/main/res/mipmap-xxhdpi/ic_launcher_round.png
iVBORw0KGgoAAAANSUhEUgAAAJAAAACQCAYAAADnRuK4AAACGklEQVR42u3dwQ2CQBAFUGrRUmzD+izBpjx7M8G7gUAky+zsvJ/8u9l5IYaFZZpEREREREREQvJ5Pee9tVqQNKtVhgUqaPqtKUEDEzggQTNoTRkckOCBCByQwFGQ4IEIHJDggQgcBQkeiOCBCB6I4NFCiAwVInggggcieLQCIkODCB6I4NFkiAwIIHgggkeTITIQgOCBCB5NhsgAAIJHZ4A0FyCLDhE8GoPIQgMEj8YgssAAdQXo/bgu1iAHBHQWnjVE99slVSFqCGgLzxIigBIDisDziwigxIgAAggggGIAnf3neQ0RQEkRRQNyBQIIoKqAWvwogAohavWj/rkPpAAduhOtAO2CZGgAKUDw6EFEFk4BUoAUIAVIAeoUkJuIAwKKggPRIIii8XgmGiC78QABBBBAAFUH5JlogFyBAAIIIIAAqnwfSAFyJ9p2hr0weOzGK0AKkAKkAAGkAKmXC9Wrzd6NB8jpHDrq+UA2UwGyG++YO4CckQgQQJUAeSY6OSAn1TupHiCAAAIoMSDfC/O9sPRfLNTkgHwzFR5fbVaANDEgiOABSGMBQQQPRBqLByCAINJYPAABBBE8fcQw4AEIIIg0KR6I4AEIIIg0OR6I4IEIHoh0ADwQwQMRPBDBA5HCAxE8EMEDETwgKTgQwQMSOBDBAxI4AhI4EMEDEjgwQSOVIJkeTNDABI10hMoqwwWJiIiIiIi0yReCdt1uNzZy0wAAAABJRU5ErkJggg==
ZZEOF

mkdir -p app/src/main/res/mipmap-xxxhdpi
base64 -d << 'ZZEOF' > app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
iVBORw0KGgoAAAANSUhEUgAAAMAAAADACAYAAABS3GwHAAADNklEQVR42u3d0U3rQABEUdcCpdAG9VECTeWbPyT4j0CJHNnZ3XtGmgLwzknQs/3YNhEREREREREREREREdmd78vnz966erL0wB+tqy+ZsUMhRg+DGDwQYvQwiOGDIEYPgxg+CGL4IIjhg2D4RguC8SsEhq8gGL6CYPwKgeErCMavEBi/QmD4CoLxKwTGrxAYv0Jg/AqB8SsExq8QGL9CYPwKgfErBMavEBi/QmD8CoHxKwTGrxAAoAAYv0Jg/AqB8SsEAGgagMPTLAKHpmkEDkyzAByWphE4KM0CcEiaReBwNI3AwWgWgEPRNAIHolkADkPTCByEZgE4BE0jcACaBfCMH/br4/XPGgIESwP4b/gQ6NIA7hn+LQjvby+ZArDYp/8eANcIAIAg8+kPAAD5T/9rBABAkPr0BwAAAAAAoPzrDwAQAAAAAAAAAAAAAAAw37M/7gMAMBQCAAAAYAIEBqBLPfdv/Pp0BCP8QIavaQCqAKgCoHoiABdT0whcSAVAFQBVAFQBUAVAFQCPQujCAGYYPwh6GIJZhu+/RvQ+AABeiDH4lQB4IwyALAAvxQMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO4DuA8AgDvBAAAAgAfidFUAngZVj0R7H0C9EKMKgCoAqgCoAqAKgCoAqocBgEDT4wdAAXBBFQCPQigAQz8R6uD1EAAz/6V47wMY/5QAvBEGAAAAADAKgDMReCkegOHGDwAAAAAAAAAAABAFcBYCAAAYcvwAAADAJL8GAQBA9lvAfQDjT38LAABA9lvAv4QY/1LfAvdCMAQAlgVwC4IRAJBBoDrE+AHQPAAIND1+ADQPAAJNjx8AzQOAQNPjB0DzACDQ9Pgh0Pz4AdA8AAg0PX4ANA8AAk2PHwLNjx8AzQOAQNPjh0Dz44dA8+MHQPMAIND0+CHQ/Pgh0Pz4IdD8+CHQ/Pgh0E0gMH6BwPgFAuMXCIxfIDB+gcD4xXiMHwIjMn4BwfAFAuMXIzN+AcHwBQLjFxAMX0AwfIHA+AUEwxcQDF9AMHwBwfAFBqMXEAxf6hicrqRAOD3JYXBKkkHh6svSQFw9EREREREREREREXkgv4tc2NvaHuOxAAAAAElFTkSuQmCC
ZZEOF

mkdir -p app/src/main/res/mipmap-xxxhdpi
base64 -d << 'ZZEOF' > app/src/main/res/mipmap-xxxhdpi/ic_launcher_round.png
iVBORw0KGgoAAAANSUhEUgAAAMAAAADACAYAAABS3GwHAAADNklEQVR42u3d0U3rQABEUdcCpdAG9VECTeWbPyT4j0CJHNnZ3XtGmgLwzknQs/3YNhEREREREREREREREdmd78vnz966erL0wB+tqy+ZsUMhRg+DGDwQYvQwiOGDIEYPgxg+CGL4IIjhg2D4RguC8SsEhq8gGL6CYPwKgeErCMavEBi/QmD4CoLxKwTGrxAYv0Jg/AqB8SsExq8QGL9CYPwKgfErBMavEBi/QmD8CoHxKwTGrxAAoAAYv0Jg/AqB8SsEAGgagMPTLAKHpmkEDkyzAByWphE4KM0CcEiaReBwNI3AwWgWgEPRNAIHolkADkPTCByEZgE4BE0jcACaBfCMH/br4/XPGgIESwP4b/gQ6NIA7hn+LQjvby+ZArDYp/8eANcIAIAg8+kPAAD5T/9rBABAkPr0BwAAAAAAoPzrDwAQAAAAAAAAAAAAAAAw37M/7gMAMBQCAAAAYAIEBqBLPfdv/Pp0BCP8QIavaQCqAKgCoHoiABdT0whcSAVAFQBVAFQBUAVAFQCPQujCAGYYPwh6GIJZhu+/RvQ+AABeiDH4lQB4IwyALAAvxQMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO4DuA8AgDvBAAAAgAfidFUAngZVj0R7H0C9EKMKgCoAqgCoAqAKgCoAqocBgEDT4wdAAXBBFQCPQigAQz8R6uD1EAAz/6V47wMY/5QAvBEGAAAAADAKgDMReCkegOHGDwAAAAAAAAAAABAFcBYCAAAYcvwAAADAJL8GAQBA9lvAfQDjT38LAABA9lvAv4QY/1LfAvdCMAQAlgVwC4IRAJBBoDrE+AHQPAAIND1+ADQPAAJNjx8AzQOAQNPjB0DzACDQ9Pgh0Pz4AdA8AAg0PX4ANA8AAk2PHwLNjx8AzQOAQNPjh0Dz44dA8+MHQPMAIND0+CHQ/Pgh0Pz4IdD8+CHQ/Pgh0E0gMH6BwPgFAuMXCIxfIDB+gcD4xXiMHwIjMn4BwfAFAuMXIzN+AcHwBQLjFxAMX0AwfIHA+AUEwxcQDF9AMHwBwfAFBqMXEAxf6hicrqRAOD3JYXBKkkHh6svSQFw9EREREREREREREXkgv4tc2NvaHuOxAAAAAElFTkSuQmCC
ZZEOF

mkdir -p app/src/main/res/drawable
base64 -d << 'ZZEOF' > app/src/main/res/drawable/ic_launcher_foreground.png
iVBORw0KGgoAAAANSUhEUgAAAGwAAABsCAYAAACPZlfNAAABi0lEQVR42u3cQUrEQBRF0axFl+I2XJ9LcFOOnQk6zcCGhk40t/558GcNgXdoqKSS2jYRERERuZ2vj/fvR0eLFwcCGAcCuAgUuCASvDjUeLgy1ii0FaBGwK0ItSzcBKxl0CZhpdEmQmXhYIXQIIXQ4ITQoITQYITQIMTQAITAlB9CU3oITdkxNEWHwJQcQ1NwCEy5ITSlxtAUGgJTZgxNkUPAPt+ef539b15fnv59lgJ75OK3wPZowA5GOwNrjwbsQLCz/l3ATkIDBgwYMGCH3Xvds0o0B6EddVFYMTADDBisOJqigBlgwE4Bs6wPgdleCYF5NAUMGDBgwIABu9Qq0bgPA2aAGWDAjE1M4xUBYN6aGgtmeyX0MqlHU17VBgYMGLDqR33AYp/MWiUGP0y3F+acDmDAHF9kHA4GDJpDLo0jZIFBG4cFLAgGLYYFLYgFLYgFLAgGLYYFLYgFLYgFLYgFLYgFLYg1HW6rBxY0WOBALQ+3TQsscKDgQcrAUbg4oJYvDqhFERGRv8sPdpYOFu+YTvEAAAAASUVORK5CYII=
ZZEOF

mkdir -p app/src/main/res/drawable
base64 -d << 'ZZEOF' > app/src/main/res/drawable/ic_launcher_background.png
iVBORw0KGgoAAAANSUhEUgAAAGwAAABsCAYAAACPZlfNAAAAt0lEQVR42u3RQQkAAAgAMfsHspQVBK2hsMcVuEVXjv4UJgATMAEDJmACBkzABAyYgAkYMAETMGACJmDABEzAgAmYgAETMAEDZgIwARMwYAImYMAETMCACZiAARMwAQMmYAIGTMAEDJiACRgwARMwYAImYAIGTMAEDJiACRgwARMwYAImYMAETMCACZiAARMwAQMmYAIGTMAETMCACZiAARMwAQMmYAIGTMAEDJiACRgwARMwYLrYAhFDfV371VUzAAAAAElFTkSuQmCC
ZZEOF

echo "Archivos actualizados. Compilando..."
./gradlew assembleDebug

