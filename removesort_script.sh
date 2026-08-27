#!/bin/bash
set -e

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_main.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<androidx.drawerlayout.widget.DrawerLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/drawerLayout"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <!-- Contenido principal -->
    <RelativeLayout
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

    <!-- Panel lateral -->
    <LinearLayout
        android:layout_width="280dp"
        android:layout_height="match_parent"
        android:layout_gravity="start"
        android:orientation="vertical"
        android:background="@color/dark_surface"
        android:paddingTop="32dp"
        android:paddingHorizontal="8dp">

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/app_name"
            android:textColor="@color/white"
            android:textSize="22sp"
            android:textStyle="bold"
            android:layout_marginStart="12dp"
            android:layout_marginBottom="24dp" />

        <LinearLayout
            android:id="@+id/drawerAllNotes"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:padding="12dp"
            android:background="?attr/selectableItemBackground">

            <ImageView
                android:layout_width="22dp"
                android:layout_height="22dp"
                android:src="@drawable/ic_folder"
                android:layout_marginEnd="16dp" />

            <TextView
                android:id="@+id/drawerAllNotesLabel"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="@string/todas_las_notas"
                android:textColor="@color/white"
                android:textSize="15sp" />

        </LinearLayout>

        <LinearLayout
            android:id="@+id/drawerTrash"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:padding="12dp"
            android:background="?attr/selectableItemBackground">

            <ImageView
                android:layout_width="22dp"
                android:layout_height="22dp"
                android:src="@drawable/ic_trash_outline"
                android:layout_marginEnd="16dp" />

            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="@string/papelera"
                android:textColor="@color/white"
                android:textSize="15sp" />

        </LinearLayout>

        <View
            android:layout_width="match_parent"
            android:layout_height="1dp"
            android:background="@color/dark_surface_light"
            android:layout_marginVertical="12dp" />

        <LinearLayout
            android:id="@+id/drawerSettings"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:padding="12dp"
            android:background="?attr/selectableItemBackground">

            <ImageView
                android:layout_width="22dp"
                android:layout_height="22dp"
                android:src="@drawable/ic_settings"
                android:layout_marginEnd="16dp" />

            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="@string/ajustes"
                android:textColor="@color/white"
                android:textSize="15sp" />

        </LinearLayout>

    </LinearLayout>

</androidx.drawerlayout.widget.DrawerLayout>
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/MainActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.Gravity
import android.widget.PopupMenu
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import com.santos.tareas.databinding.ActivityMainBinding

enum class ViewMode { LIST, CARD, GRID }

class MainActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_SHOW_NOTES = "extra_show_notes"
    }

    private lateinit var binding: ActivityMainBinding
    private lateinit var noteAdapter: NoteAdapter
    private lateinit var taskAdapter: TaskAdapter

    private var showingNotes = true
    private var searchQuery = ""
    private var viewMode = ViewMode.CARD
    private var completedExpanded = false

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
                if (!task.done) {
                    // Marcamos hecha en su sitio y esperamos a que termine de tacharse
                    // antes de reordenar en secciones (para que se vea la animación).
                    TaskRepository.toggleDone(this, task.id)
                    taskAdapter.onAnimationEnd = {
                        binding.recyclerView.postDelayed({
                            refresh()
                            taskAdapter.onAnimationEnd = null
                        }, 900)
                    }
                    taskAdapter.markDoneInPlace(task.id)
                } else {
                    TaskRepository.toggleDone(this, task.id)
                    refresh()
                }
            },
            onClick = { task ->
                val intent = Intent(this, AddEditTaskActivity::class.java)
                intent.putExtra(AddEditTaskActivity.EXTRA_TASK_ID, task.id)
                startActivity(intent)
            },
            onDelete = { task ->
                TaskRepository.deleteTask(this, task.id)
                refresh()
            },
            onHeaderToggle = {
                completedExpanded = !completedExpanded
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

        binding.sidebarButton.setOnClickListener {
            binding.drawerLayout.openDrawer(Gravity.START)
        }
        binding.drawerAllNotes.setOnClickListener {
            binding.drawerLayout.closeDrawer(Gravity.START)
        }
        binding.drawerTrash.setOnClickListener {
            binding.drawerLayout.closeDrawer(Gravity.START)
            startActivity(Intent(this, TrashActivity::class.java))
        }
        binding.drawerSettings.setOnClickListener {
            binding.drawerLayout.closeDrawer(Gravity.START)
            startActivity(Intent(this, SettingsActivity::class.java))
        }

        binding.searchInput.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                searchQuery = s?.toString().orEmpty()
                refresh()
            }
            override fun afterTextChanged(s: Editable?) {}
        })

        applyViewMode()
        val showNotes = intent.getBooleanExtra(EXTRA_SHOW_NOTES, true)
        selectTab(notes = showNotes)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        if (intent.hasExtra(EXTRA_SHOW_NOTES)) {
            selectTab(notes = intent.getBooleanExtra(EXTRA_SHOW_NOTES, true))
        }
    }

    override fun onResume() {
        super.onResume()
        refresh()
    }

    private fun showViewModeMenu() {
        val popup = PopupMenu(this, binding.menuButton)
        popup.menu.add(0, 0, 0, getString(R.string.vista_lista)).setIcon(R.drawable.ic_view_list)
        popup.menu.add(0, 1, 1, getString(R.string.vista_tarjeta)).setIcon(R.drawable.ic_view_card)
        popup.menu.add(0, 2, 2, getString(R.string.vista_cuadricula)).setIcon(R.drawable.ic_view_grid)
        MenuIconHelper.forceShowIcons(popup)
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
        if (viewMode == ViewMode.GRID) {
            val gridManager = GridLayoutManager(this, 2)
            gridManager.spanSizeLookup = object : GridLayoutManager.SpanSizeLookup() {
                override fun getSpanSize(position: Int): Int {
                    return if (!showingNotes && taskAdapter.isHeaderAt(position)) 2 else 1
                }
            }
            binding.recyclerView.layoutManager = gridManager
        } else {
            binding.recyclerView.layoutManager = LinearLayoutManager(this)
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
        binding.drawerAllNotesLabel.text = getString(if (notes) R.string.todas_las_notas else R.string.todas_las_tareas)
        applyViewMode()
    }

    private fun refresh() {
        if (showingNotes) {
            var notes = NoteRepository.getNotes(this).filter {
                searchQuery.isBlank() ||
                    it.title.contains(searchQuery, ignoreCase = true) ||
                    HtmlUtils.toPlainText(it.text).contains(searchQuery, ignoreCase = true)
            }
            // Las notas ancladas siempre van primero
            notes = notes.sortedByDescending { it.pinned }
            noteAdapter.submitList(notes)
            binding.emptyView.visibility = if (notes.isEmpty()) android.view.View.VISIBLE else android.view.View.GONE
        } else {
            val allTasks = TaskRepository.getTasks(this).filter {
                searchQuery.isBlank() || it.title.contains(searchQuery, ignoreCase = true)
            }
            val pending = allTasks.filter { !it.done }
            val completed = allTasks.filter { it.done }

            val sections = mutableListOf<TaskListItem>()
            if (pending.isNotEmpty()) {
                sections.add(TaskListItem.Header(getString(R.string.pendiente_de_completar), collapsible = false, expanded = true))
                sections.addAll(pending.map { TaskListItem.Row(it) })
            }
            if (completed.isNotEmpty()) {
                sections.add(TaskListItem.Header(getString(R.string.completado), collapsible = true, expanded = completedExpanded))
                if (completedExpanded) {
                    sections.addAll(completed.map { TaskListItem.Row(it) })
                }
            }
            taskAdapter.submitSections(sections)
            binding.emptyView.visibility = if (allTasks.isEmpty()) android.view.View.VISIBLE else android.view.View.GONE
        }
    }
}
ZZEOF

echo "Boton de ordenar quitado. Compilando..."
./gradlew assembleDebug
rm -- "$0"