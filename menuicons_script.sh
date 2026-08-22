#!/bin/bash
set -e

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_view_list.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="22dp"
    android:height="22dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M4,14h4v-4L4,10v4zM4,19h4v-4L4,15v4zM4,9h4L8,5L4,5v4zM9,14h11v-4L9,10v4zM9,19h11v-4L9,15v4zM9,5v4h11L20,5L9,5z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_view_card.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="22dp"
    android:height="22dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M4,6c0,-1.1 0.9,-2 2,-2h12c1.1,0 2,0.9 2,2v4c0,1.1 -0.9,2 -2,2L6,12c-1.1,0 -2,-0.9 -2,-2L4,6zM4,16c0,-1.1 0.9,-2 2,-2h12c1.1,0 2,0.9 2,2v2c0,1.1 -0.9,2 -2,2L6,20c-1.1,0 -2,-0.9 -2,-2v-2z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_view_grid.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="22dp"
    android:height="22dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M4,5c0,-0.55 0.45,-1 1,-1h6c0.55,0 1,0.45 1,1v6c0,0.55 -0.45,1 -1,1L5,12c-0.55,0 -1,-0.45 -1,-1L4,5zM12,5c0,-0.55 0.45,-1 1,-1h6c0.55,0 1,0.45 1,1v6c0,0.55 -0.45,1 -1,1h-6c-0.55,0 -1,-0.45 -1,-1L12,5zM4,13c0,-0.55 0.45,-1 1,-1h6c0.55,0 1,0.45 1,1v6c0,0.55 -0.45,1 -1,1L5,20c-0.55,0 -1,-0.45 -1,-1v-6zM12,13c0,-0.55 0.45,-1 1,-1h6c0.55,0 1,0.45 1,1v6c0,0.55 -0.45,1 -1,1h-6c-0.55,0 -1,-0.45 -1,-1v-6z" />
</vector>
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/MenuIconHelper.kt << 'ZZEOF'
package com.santos.tareas

import android.widget.PopupMenu

/**
 * Android oculta los iconos de un PopupMenu por defecto. No hay API pública
 * para forzarlos, así que usamos el método interno setOptionalIconsVisible
 * vía reflexión (técnica estándar y ampliamente usada para esto).
 */
object MenuIconHelper {
    fun forceShowIcons(popupMenu: PopupMenu) {
        try {
            val menu = popupMenu.menu
            val method = menu.javaClass.getDeclaredMethod(
                "setOptionalIconsVisible", Boolean::class.javaPrimitiveType
            )
            method.isAccessible = true
            method.invoke(menu, true)
        } catch (e: Exception) {
            // Si el fabricante cambió la API interna, simplemente no se muestran iconos
        }
    }
}
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
            val notes = NoteRepository.getNotes(this).filter {
                searchQuery.isBlank() ||
                    it.title.contains(searchQuery, ignoreCase = true) ||
                    it.text.contains(searchQuery, ignoreCase = true)
            }
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

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/AddEditNoteActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.app.AlertDialog
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.view.View
import android.widget.LinearLayout
import android.widget.PopupMenu
import androidx.appcompat.app.AppCompatActivity
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import com.santos.tareas.databinding.ActivityAddEditNoteBinding

class AddEditNoteActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_NOTE_ID = "extra_note_id"

        // Colores disponibles para el fondo de la nota (null = color por defecto)
        val NOTE_COLORS: List<String?> = listOf(
            null, "#3A3A3E", "#2D4B73", "#2F5D50", "#6B3350", "#7A5A24"
        )
    }

    private lateinit var binding: ActivityAddEditNoteBinding
    private var editingNoteId: Long? = null
    private var currentNote: Note? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddEditNoteBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.backButton.setOnClickListener { saveAndFinish() }
        binding.cancelButton.setOnClickListener { finish() }
        binding.saveButton.setOnClickListener { saveAndFinish() }
        binding.menuButton.setOnClickListener { showOptionsMenu() }

        val noteId = intent.getLongExtra(EXTRA_NOTE_ID, -1L)
        if (noteId != -1L) {
            editingNoteId = noteId
            val note = NoteRepository.getNotes(this).find { it.id == noteId }
            if (note != null && note.locked) {
                // No cargamos el contenido hasta que se desbloquee
                requestUnlock(
                    onSuccess = { loadNote(note) },
                    onFail = { finish() }
                )
            } else if (note != null) {
                loadNote(note)
            }
        } else {
            binding.menuButton.visibility = View.GONE
        }
    }

    private fun loadNote(note: Note) {
        currentNote = note
        binding.titleInput.setText(note.title)
        binding.bodyInput.setText(note.text)
        binding.dateLabel.visibility = View.VISIBLE
        binding.dateLabel.text = DateUtils.format(note.createdAt)
        applyColor(note.color)
    }

    private fun applyColor(color: String?) {
        val bg = if (color != null) Color.parseColor(color) else ContextCompat.getColor(this, R.color.dark_bg)
        binding.rootLayout.setBackgroundColor(bg)
    }

    private fun requestUnlock(onSuccess: () -> Unit, onFail: () -> Unit) {
        val biometricManager = BiometricManager.from(this)
        val canUseBiometric = biometricManager.canAuthenticate(
            BiometricManager.Authenticators.BIOMETRIC_WEAK or BiometricManager.Authenticators.DEVICE_CREDENTIAL
        ) == BiometricManager.BIOMETRIC_SUCCESS

        if (canUseBiometric) {
            val executor = ContextCompat.getMainExecutor(this)
            val prompt = BiometricPrompt(this, executor, object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                    onSuccess()
                }
                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    onFail()
                }
                override fun onAuthenticationFailed() {
                    // el usuario puede reintentar; no cerramos aquí
                }
            })
            val promptInfo = BiometricPrompt.PromptInfo.Builder()
                .setTitle(getString(R.string.nota_bloqueada))
                .setSubtitle(getString(R.string.desbloquear_nota))
                .setAllowedAuthenticators(
                    BiometricManager.Authenticators.BIOMETRIC_WEAK or BiometricManager.Authenticators.DEVICE_CREDENTIAL
                )
                .build()
            prompt.authenticate(promptInfo)
        } else if (PinLockManager.hasPin(this)) {
            PinDialogHelper.showEnterPinDialog(this, onCorrect = onSuccess, onCancel = onFail)
        } else {
            // No hay biometría ni PIN configurado todavía: pedimos crear uno
            PinDialogHelper.showCreatePinDialog(this) { onSuccess() }
        }
    }

    private fun showOptionsMenu() {
        val note = currentNote ?: return
        val popup = PopupMenu(this, binding.menuButton)
        popup.menu.add(0, 0, 0, getString(if (note.pinned) R.string.desanclar else R.string.anclar))
            .setIcon(R.drawable.ic_pin)
        popup.menu.add(0, 1, 1, getString(if (note.locked) R.string.desbloquear else R.string.bloquear))
            .setIcon(R.drawable.ic_lock)
        popup.menu.add(0, 2, 2, getString(R.string.compartir)).setIcon(R.drawable.ic_share)
        popup.menu.add(0, 3, 3, getString(R.string.color_de_fondo)).setIcon(R.drawable.ic_palette)
        MenuIconHelper.forceShowIcons(popup)
        popup.setOnMenuItemClickListener { item ->
            when (item.itemId) {
                0 -> togglePinned()
                1 -> toggleLocked()
                2 -> shareNote()
                3 -> showColorPicker()
            }
            true
        }
        popup.show()
    }

    private fun togglePinned() {
        val note = currentNote ?: return
        val updated = note.copy(pinned = !note.pinned)
        currentNote = updated
        NoteRepository.setPinned(this, note.id, updated.pinned)
    }

    private fun toggleLocked() {
        val note = currentNote ?: return
        if (!note.locked && !PinLockManager.hasPin(this)) {
            val biometricManager = BiometricManager.from(this)
            val canUseBiometric = biometricManager.canAuthenticate(
                BiometricManager.Authenticators.BIOMETRIC_WEAK
            ) == BiometricManager.BIOMETRIC_SUCCESS
            if (!canUseBiometric) {
                // sin huella disponible en el dispositivo: pedimos crear un PIN antes de bloquear
                PinDialogHelper.showCreatePinDialog(this) {
                    applyLock(note, true)
                }
                return
            }
        }
        applyLock(note, !note.locked)
    }

    private fun applyLock(note: Note, locked: Boolean) {
        val updated = note.copy(locked = locked)
        currentNote = updated
        NoteRepository.setLocked(this, note.id, locked)
    }

    private fun shareNote() {
        val note = currentNote ?: return
        val shareText = if (note.title.isNotBlank()) "${note.title}\n\n${note.text}" else note.text
        val intent = Intent(Intent.ACTION_SEND).apply {
            type = "text/plain"
            putExtra(Intent.EXTRA_TEXT, shareText)
        }
        startActivity(Intent.createChooser(intent, getString(R.string.compartir)))
    }

    private fun showColorPicker() {
        val note = currentNote ?: return
        val row = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            setPadding(32, 32, 32, 32)
        }
        for (colorHex in NOTE_COLORS) {
            val swatch = View(this)
            val size = 140
            val params = LinearLayout.LayoutParams(size, size).apply { setMargins(12, 0, 12, 0) }
            swatch.layoutParams = params
            val drawable = android.graphics.drawable.GradientDrawable()
            drawable.shape = android.graphics.drawable.GradientDrawable.OVAL
            drawable.setColor(
                if (colorHex != null) Color.parseColor(colorHex) else ContextCompat.getColor(this, R.color.dark_surface)
            )
            drawable.setStroke(3, ContextCompat.getColor(this, R.color.dark_text_secondary))
            swatch.background = drawable
            row.addView(swatch)

            swatch.setOnClickListener {
                val updated = note.copy(color = colorHex)
                currentNote = updated
                NoteRepository.setColor(this, note.id, colorHex)
                applyColor(colorHex)
            }
        }

        AlertDialog.Builder(this)
            .setTitle(R.string.color_de_fondo)
            .setView(row)
            .setPositiveButton(android.R.string.ok, null)
            .show()
    }

    private fun saveAndFinish() {
        val title = binding.titleInput.text.toString().trim()
        val body = binding.bodyInput.text.toString().trim()

        if (title.isEmpty() && body.isEmpty()) {
            finish()
            return
        }

        val existing = currentNote
        if (existing != null) {
            NoteRepository.updateNote(this, existing.copy(title = title, text = body))
        } else {
            NoteRepository.addNote(this, title, body)
        }
        finish()
    }
}
ZZEOF

echo "Iconos en menus de vista y opciones de nota listos. Compilando..."
./gradlew assembleDebug