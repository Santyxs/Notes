#!/bin/bash
set -e

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

    <color name="dark_bg">#0E0E10</color>
    <color name="dark_surface">#232326</color>
    <color name="dark_surface_light">#2E2E32</color>
    <color name="dark_text_secondary">#8A8A8E</color>
    <color name="accent_blue">#3E9EFF</color>
</resources>
ZZEOF

mkdir -p app/src/main/res/values
cat > app/src/main/res/values/themes.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Theme.Tareas" parent="Theme.MaterialComponents.DayNight.NoActionBar">
        <item name="colorPrimary">@color/accent_yellow</item>
        <item name="android:statusBarColor">@color/dark_bg</item>
        <item name="android:windowBackground">@color/dark_bg</item>
    </style>

    <style name="Theme.Tareas.Dialog" parent="Theme.MaterialComponents.DayNight.Dialog">
        <item name="android:windowBackground">@android:color/transparent</item>
    </style>
</resources>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_search.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/dark_text_secondary">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M15.5,14h-0.79l-0.28,-0.27C15.41,12.59 16,11.11 16,9.5 16,5.91 13.09,3 9.5,3S3,5.91 3,9.5 5.91,16 9.5,16c1.61,0 3.09,-0.59 4.23,-1.57l0.27,0.28v0.79l5,4.99L20.49,19l-4.99,-5zM9.5,14C7.01,14 5,11.99 5,9.5S7.01,5 9.5,5 14,7.01 14,9.5 11.99,14 9.5,14z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_edit.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@android:color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M3,17.25V21h3.75L17.81,9.94l-3.75,-3.75L3,17.25zM20.71,7.04c0.39,-0.39 0.39,-1.02 0,-1.41l-2.34,-2.34c-0.39,-0.39 -1.02,-0.39 -1.41,0l-1.83,1.83 3.75,3.75 1.83,-1.83z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_empty_document.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="64dp"
    android:height="64dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/dark_surface_light">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M6,2 C4.9,2 4,2.9 4,4 L4,20 C4,21.1 4.9,22 6,22 L18,22 C19.1,22 20,21.1 20,20 L20,8 L14,2 L6,2 Z" />
    <path
        android:fillColor="#1A1A1D"
        android:fillAlpha="0.35"
        android:pathData="M14,2 L14,8 L20,8 Z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/pill_container_background.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="@color/dark_surface" />
    <corners android:radius="24dp" />
</shape>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/pill_selected_background.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="@color/dark_surface_light" />
    <corners android:radius="20dp" />
</shape>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/search_bar_background.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="@color/dark_surface" />
    <corners android:radius="28dp" />
</shape>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/circle_button_dark.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="oval">
    <solid android:color="@color/dark_surface" />
</shape>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_list_menu.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@android:color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M3,6h18v2L3,8zM3,11h18v2L3,13zM3,16h18v2L3,18z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_sidebar.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@android:color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M4,4h16c1.1,0 2,0.9 2,2v12c0,1.1 -0.9,2 -2,2L4,20c-1.1,0 -2,-0.9 -2,-2L2,6c0,-1.1 0.9,-2 2,-2zM9,6L4,6v12h5L9,6zM11,18h9L20,6h-9v12z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/dark_row_background.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="@color/dark_surface" />
    <corners android:radius="16dp" />
</shape>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_trash.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/dark_text_secondary">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M6,19c0,1.1 0.9,2 2,2h8c1.1,0 2,-0.9 2,-2L18,7L6,7v12zM19,4h-3.5l-1,-1h-5l-1,1L5,4v2h14L19,4z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_main.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/dark_bg">

    <!-- Barra superior -->
    <RelativeLayout
        android:id="@+id/topBar"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_alignParentTop="true"
        android:padding="16dp">

        <ImageView
            android:id="@+id/sidebarButton"
            android:layout_width="44dp"
            android:layout_height="44dp"
            android:layout_alignParentStart="true"
            android:background="@drawable/circle_button_dark"
            android:padding="11dp"
            android:src="@drawable/ic_sidebar" />

        <LinearLayout
            android:id="@+id/tabPill"
            android:layout_width="wrap_content"
            android:layout_height="44dp"
            android:layout_centerHorizontal="true"
            android:orientation="horizontal"
            android:background="@drawable/pill_container_background"
            android:padding="4dp">

            <TextView
                android:id="@+id/tabNotas"
                android:layout_width="wrap_content"
                android:layout_height="match_parent"
                android:gravity="center"
                android:paddingHorizontal="22dp"
                android:text="@string/notas"
                android:textColor="@color/accent_yellow"
                android:textStyle="bold"
                android:background="@drawable/pill_selected_background" />

            <TextView
                android:id="@+id/tabTareas"
                android:layout_width="wrap_content"
                android:layout_height="match_parent"
                android:gravity="center"
                android:paddingHorizontal="22dp"
                android:text="@string/tareas"
                android:textColor="@color/white" />

        </LinearLayout>

        <ImageView
            android:id="@+id/menuButton"
            android:layout_width="44dp"
            android:layout_height="44dp"
            android:layout_alignParentEnd="true"
            android:background="@drawable/circle_button_dark"
            android:padding="11dp"
            android:src="@drawable/ic_list_menu" />

    </RelativeLayout>

    <!-- Lista / estado vacío -->
    <FrameLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:layout_below="@id/topBar"
        android:layout_above="@id/bottomBar">

        <androidx.recyclerview.widget.RecyclerView
            android:id="@+id/recyclerView"
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:paddingHorizontal="16dp"
            android:paddingTop="8dp"
            android:clipToPadding="false" />

        <LinearLayout
            android:id="@+id/emptyView"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_gravity="center"
            android:orientation="vertical"
            android:gravity="center"
            android:visibility="gone">

            <ImageView
                android:layout_width="64dp"
                android:layout_height="64dp"
                android:src="@drawable/ic_empty_document" />

            <TextView
                android:id="@+id/emptyText"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginTop="16dp"
                android:text="@string/sin_notas"
                android:textColor="@color/dark_text_secondary"
                android:textSize="15sp" />
        </LinearLayout>

    </FrameLayout>

    <!-- Barra inferior: buscador + botón flotante -->
    <RelativeLayout
        android:id="@+id/bottomBar"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_alignParentBottom="true"
        android:padding="16dp">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="52dp"
            android:layout_toStartOf="@id/fabAdd"
            android:layout_marginEnd="12dp"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:background="@drawable/search_bar_background"
            android:paddingHorizontal="16dp">

            <ImageView
                android:layout_width="20dp"
                android:layout_height="20dp"
                android:src="@drawable/ic_search"
                android:layout_marginEnd="10dp" />

            <EditText
                android:id="@+id/searchInput"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:background="@android:color/transparent"
                android:hint="@string/buscar"
                android:textColor="@color/white"
                android:textColorHint="@color/dark_text_secondary"
                android:textSize="15sp"
                android:singleLine="true"
                android:imeOptions="actionSearch" />

        </LinearLayout>

        <ImageView
            android:id="@+id/fabAdd"
            android:layout_width="52dp"
            android:layout_height="52dp"
            android:layout_alignParentEnd="true"
            android:background="@drawable/circle_button_dark"
            android:padding="14dp"
            android:src="@drawable/ic_edit" />

    </RelativeLayout>

</RelativeLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/item_task_row.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:gravity="center_vertical"
    android:background="@drawable/dark_row_background"
    android:layout_marginBottom="8dp"
    android:padding="14dp">

    <ImageView
        android:id="@+id/checkbox"
        android:layout_width="24dp"
        android:layout_height="24dp"
        android:layout_marginEnd="12dp"
        android:src="@drawable/ic_check_circle_outline" />

    <TextView
        android:id="@+id/title"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:textColor="@color/white"
        android:textSize="16sp" />

    <ImageView
        android:id="@+id/deleteButton"
        android:layout_width="22dp"
        android:layout_height="22dp"
        android:padding="1dp"
        android:src="@drawable/ic_trash"
        android:contentDescription="@string/eliminar_tarea" />

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

    <TextView
        android:id="@+id/text"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:maxLines="3"
        android:ellipsize="end"
        android:textColor="@color/white"
        android:textSize="15sp" />

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
cat > app/src/main/java/com/santos/tareas/MainActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.santos.tareas.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var noteAdapter: NoteAdapter
    private lateinit var taskAdapter: TaskAdapter

    private var showingNotes = true
    private var searchQuery = ""

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

        binding.recyclerView.layoutManager = LinearLayoutManager(this)

        binding.tabNotas.setOnClickListener { selectTab(notes = true) }
        binding.tabTareas.setOnClickListener { selectTab(notes = false) }

        binding.fabAdd.setOnClickListener {
            if (showingNotes) {
                startActivity(Intent(this, AddEditNoteActivity::class.java))
            } else {
                startActivity(Intent(this, AddEditTaskActivity::class.java))
            }
        }

        binding.searchInput.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                searchQuery = s?.toString().orEmpty()
                refresh()
            }
            override fun afterTextChanged(s: Editable?) {}
        })

        selectTab(notes = true)
    }

    override fun onResume() {
        super.onResume()
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
                searchQuery.isBlank() || it.text.contains(searchQuery, ignoreCase = true)
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

echo "Interfaz actualizada. Compilando..."
./gradlew assembleDebug