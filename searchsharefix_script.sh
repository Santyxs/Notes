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
    <string name="tocar_para_editar">Tocar para crear una tarea</string>
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
    <string name="todas_las_notas">Todas las notas</string>
    <string name="todas_las_tareas">Todas las tareas</string>
    <string name="papelera">Papelera</string>
    <string name="ajustes">Ajustes</string>
    <string name="papelera_vacia">La papelera está vacía</string>
    <string name="vaciar_papelera">Vaciar papelera</string>
    <string name="restaurar">Restaurar</string>
    <string name="eliminar_definitivamente">Eliminar definitivamente</string>
    <string name="acerca_de">Acerca de</string>
    <string name="nota_bloqueada">Nota bloqueada</string>
    <string name="anclar">Anclar</string>
    <string name="desanclar">Desanclar</string>
    <string name="bloquear">Bloquear</string>
    <string name="desbloquear">Desbloquear</string>
    <string name="compartir">Compartir</string>
    <string name="color_de_fondo">Color de fondo</string>
    <string name="desbloquear_nota">Desbloquea la nota para continuar</string>
    <string name="pendiente_de_completar">Pendiente de completar</string>
    <string name="completado">Completado</string>
    <string name="todo_completado">Sin tareas</string>
    <string name="deshacer">Deshacer</string>
    <string name="rehacer">Rehacer</string>
    <string name="tipografia">Tipografía</string>
    <string name="dibujar">Dibujar</string>
    <string name="insertar_imagen">Insertar imagen</string>
    <string name="insertar_tabla">Insertar tabla</string>
    <string name="guardar_dibujo">Guardar dibujo</string>
    <string name="borrar_todo">Borrar todo</string>
    <string name="filas">Filas</string>
    <string name="columnas">Columnas</string>
    <string name="crear_tabla">Crear tabla</string>
    <string name="eliminar_adjunto">Eliminar adjunto</string>
    <string name="predeterminada">Predeterminada</string>
    <string name="sans_serif">Sans-serif</string>
    <string name="serif">Serif</string>
    <string name="monoespaciada">Monoespaciada</string>
    <string name="dictar_voz">Dictar por voz</string>
    <string name="di_algo">Di algo...</string>
    <string name="cuerpo">Cuerpo</string>
    <string name="formato_texto">Formato de texto</string>
    <string name="color_de_texto">Color de texto</string>
    <string name="aa_boton">Aa</string>
    <string name="confirmar_vaciar_papelera">Se eliminarán para siempre todas las notas y tareas de la papelera. Esta acción no se puede deshacer.</string>
    <string name="confirmar_eliminar_definitivamente">Se eliminará para siempre. Esta acción no se puede deshacer.</string>
    <string name="ordenar_por">Ordenar por</string>
    <string name="fecha_reciente">Fecha (recientes primero)</string>
    <string name="fecha_antigua">Fecha (antiguas primero)</string>
    <string name="alfabetico_az">Alfabético (A-Z)</string>
    <string name="alfabetico_za">Alfabético (Z-A)</string>
    <string name="exportar_backup">Exportar copia de seguridad</string>
    <string name="importar_backup">Importar copia de seguridad</string>
    <string name="confirmar_importar_backup">Esto reemplazará todas tus notas y tareas actuales por las del archivo. ¿Continuar?</string>
    <string name="backup_exportado">Copia de seguridad lista para compartir</string>
    <string name="backup_importado">Copia de seguridad importada correctamente</string>
    <string name="backup_error">No se pudo leer el archivo de copia de seguridad</string>
    <string name="sin_resultados">Sin resultados</string>
</resources>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/item_search_result_row.xml << 'ZZEOF'
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
        android:id="@+id/resultIcon"
        android:layout_width="20dp"
        android:layout_height="20dp"
        android:layout_marginEnd="12dp" />

    <TextView
        android:id="@+id/resultTitle"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:textColor="@color/white"
        android:textSize="15sp" />

    <TextView
        android:id="@+id/resultType"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:textColor="@color/dark_text_secondary"
        android:textSize="12sp" />

</LinearLayout>
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/SearchResultAdapter.kt << 'ZZEOF'
package com.santos.tareas

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.santos.tareas.databinding.ItemSearchResultRowBinding

sealed class SearchResult {
    data class NoteResult(val note: Note) : SearchResult()
    data class TaskResult(val task: Task) : SearchResult()
}

class SearchResultAdapter(
    private val onClickNote: (Note) -> Unit,
    private val onClickTask: (Task) -> Unit
) : RecyclerView.Adapter<SearchResultAdapter.ViewHolder>() {

    private var items: List<SearchResult> = emptyList()

    fun submitList(newItems: List<SearchResult>) {
        items = newItems
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding = ItemSearchResultRowBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(items[position])
    }

    override fun getItemCount(): Int = items.size

    inner class ViewHolder(private val binding: ItemSearchResultRowBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(result: SearchResult) {
            when (result) {
                is SearchResult.NoteResult -> {
                    val note = result.note
                    binding.resultIcon.setImageResource(R.drawable.ic_note)
                    binding.resultTitle.text = note.title.ifBlank { HtmlUtils.toPlainText(note.text) }
                    binding.resultType.text = binding.root.context.getString(R.string.notas)
                    binding.root.setOnClickListener { onClickNote(note) }
                }
                is SearchResult.TaskResult -> {
                    val task = result.task
                    binding.resultIcon.setImageResource(
                        if (task.done) R.drawable.ic_check_circle_filled else R.drawable.ic_check_circle_outline
                    )
                    binding.resultTitle.text = task.title
                    binding.resultType.text = binding.root.context.getString(R.string.tareas)
                    binding.root.setOnClickListener { onClickTask(task) }
                }
            }
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
    private lateinit var searchResultAdapter: SearchResultAdapter

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

        searchResultAdapter = SearchResultAdapter(
            onClickNote = { note ->
                val intent = Intent(this, AddEditNoteActivity::class.java)
                intent.putExtra(AddEditNoteActivity.EXTRA_NOTE_ID, note.id)
                startActivity(intent)
            },
            onClickTask = { task ->
                val intent = Intent(this, AddEditTaskActivity::class.java)
                intent.putExtra(AddEditTaskActivity.EXTRA_TASK_ID, task.id)
                startActivity(intent)
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

    private fun configureLayoutManager() {
        if (searchQuery.isNotBlank()) {
            binding.recyclerView.layoutManager = LinearLayoutManager(this)
            return
        }
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
    }

    private fun applyViewMode() {
        configureLayoutManager()
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
        configureLayoutManager()

        if (searchQuery.isNotBlank()) {
            showCombinedSearchResults()
            return
        }

        binding.recyclerView.adapter = if (showingNotes) noteAdapter else taskAdapter
        binding.emptyText.text = getString(if (showingNotes) R.string.sin_notas else R.string.sin_tareas)

        if (showingNotes) {
            var notes: List<Note> = NoteRepository.getNotes(this)
            // Las notas ancladas siempre van primero
            notes = notes.sortedByDescending { it.pinned }
            noteAdapter.submitList(notes)
            binding.emptyView.visibility = if (notes.isEmpty()) android.view.View.VISIBLE else android.view.View.GONE
        } else {
            val allTasks = TaskRepository.getTasks(this)
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

    /** Con texto en el buscador, se muestran coincidencias de Notas y Tareas juntas,
     * sin importar qué pestaña esté seleccionada. */
    private fun showCombinedSearchResults() {
        binding.recyclerView.adapter = searchResultAdapter

        val matchingNotes = NoteRepository.getNotes(this).filter { note ->
            !note.locked && (
                note.title.contains(searchQuery, ignoreCase = true) ||
                    HtmlUtils.toPlainText(note.text).contains(searchQuery, ignoreCase = true)
                )
        }
        val matchingTasks = TaskRepository.getTasks(this).filter {
            it.title.contains(searchQuery, ignoreCase = true)
        }

        val results = mutableListOf<SearchResult>()
        results.addAll(matchingNotes.map { SearchResult.NoteResult(it) })
        results.addAll(matchingTasks.map { SearchResult.TaskResult(it) })

        searchResultAdapter.submitList(results)
        binding.emptyView.visibility = if (results.isEmpty()) android.view.View.VISIBLE else android.view.View.GONE
        binding.emptyText.text = getString(R.string.sin_resultados)
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/AddEditNoteActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.Manifest
import android.app.AlertDialog
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Typeface
import android.os.Bundle
import android.speech.RecognizerIntent
import android.text.Editable
import android.text.TextWatcher
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.FrameLayout
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.PopupMenu
import android.widget.TableLayout
import android.widget.TableRow
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.santos.tareas.databinding.ActivityAddEditNoteBinding
import java.io.File
import java.io.FileOutputStream
import java.util.Locale
import java.util.UUID

class AddEditNoteActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_NOTE_ID = "extra_note_id"
        private const val REQUEST_IMAGE_PICK = 100
        private const val REQUEST_DRAWING = 101
        private const val REQUEST_SPEECH = 102
        private const val REQUEST_RECORD_AUDIO_PERMISSION = 200

        val NOTE_COLORS: List<String?> = listOf(
            null, "#3A3A3E", "#2D4B73", "#2F5D50", "#6B3350", "#7A5A24"
        )

        val FONT_OPTIONS: List<Pair<String, Typeface?>> = listOf(
            "predeterminada" to Typeface.create("casual", Typeface.NORMAL),
            "sans" to Typeface.SANS_SERIF,
            "serif" to Typeface.SERIF,
            "monospace" to Typeface.MONOSPACE
        )
    }

    private lateinit var binding: ActivityAddEditNoteBinding
    private var editingNoteId: Long? = null
    private var currentNote: Note? = null
    private var attachments: MutableList<String> = mutableListOf()

    // Deshacer / rehacer del cuerpo de texto (con formato incluido)
    private val undoStack = mutableListOf<android.text.Spanned>()
    private val redoStack = mutableListOf<android.text.Spanned>()
    private var suppressWatcher = false
    private val debounceHandler = android.os.Handler(android.os.Looper.getMainLooper())
    private var debounceRunnable: Runnable? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddEditNoteBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.backButton.setOnClickListener { saveAndFinish() }
        binding.cancelButton.setOnClickListener { finish() }
        binding.saveButton.setOnClickListener { saveAndFinish() }
        binding.menuButton.setOnClickListener { showOptionsMenu() }

        binding.undoButton.setOnClickListener { performUndo() }
        binding.redoButton.setOnClickListener { performRedo() }
        binding.drawButton.setOnClickListener {
            startActivityForResult(Intent(this, DrawingActivity::class.java), REQUEST_DRAWING)
        }
        binding.imageButton.setOnClickListener {
            val intent = Intent(Intent.ACTION_GET_CONTENT).apply { type = "image/*" }
            startActivityForResult(intent, REQUEST_IMAGE_PICK)
        }
        binding.tableButton.setOnClickListener { showTableSizeDialog() }
        binding.micButton.setOnClickListener { startVoiceRecognition() }

        setupFormattingToolbar()

        undoStack.add(android.text.SpannableString(""))
        binding.bodyInput.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {}
            override fun afterTextChanged(s: Editable?) {
                if (suppressWatcher) return
                renumberListsIfNeeded()
                debounceRunnable?.let { debounceHandler.removeCallbacks(it) }
                debounceRunnable = Runnable {
                    val snapshot = android.text.SpannableString(s)
                    if (undoStack.lastOrNull()?.toString() != snapshot.toString()) {
                        undoStack.add(snapshot)
                        redoStack.clear()
                    }
                }
                debounceHandler.postDelayed(debounceRunnable!!, 600)
            }
        })

        val noteId = intent.getLongExtra(EXTRA_NOTE_ID, -1L)
        if (noteId != -1L) {
            editingNoteId = noteId
            val note = NoteRepository.getNotes(this).find { it.id == noteId }
            if (note != null && note.locked) {
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
        binding.bodyInput.setText(HtmlUtils.fromHtml(note.text))
        binding.dateLabel.visibility = View.VISIBLE
        binding.dateLabel.text = DateUtils.format(note.createdAt)
        applyColor(note.color)
        applyFont(note.fontFamily)
        attachments = note.attachments.toMutableList()
        renderAttachments()
        undoStack.clear()
        undoStack.add(android.text.SpannableString(binding.bodyInput.text))
    }

    private fun applyColor(color: String?) {
        val bg = if (color != null) Color.parseColor(color) else ContextCompat.getColor(this, R.color.dark_bg)
        binding.rootLayout.setBackgroundColor(bg)
    }

    private fun applyFont(fontKey: String?) {
        val typeface = FONT_OPTIONS.find { it.first == fontKey }?.second
            ?: Typeface.create("casual", Typeface.NORMAL)
        binding.bodyInput.typeface = typeface
    }

    // ---------- Deshacer / rehacer ----------

    private fun performUndo() {
        if (undoStack.size <= 1) return
        redoStack.add(undoStack.removeAt(undoStack.size - 1))
        val previous = undoStack.last()
        setBodyTextSilently(previous)
    }

    private fun performRedo() {
        if (redoStack.isEmpty()) return
        val next = redoStack.removeAt(redoStack.size - 1)
        undoStack.add(next)
        setBodyTextSilently(next)
    }

    private fun setBodyTextSilently(spanned: android.text.Spanned) {
        suppressWatcher = true
        binding.bodyInput.text.clear()
        binding.bodyInput.text.append(spanned)
        binding.bodyInput.setSelection(spanned.length)
        suppressWatcher = false
    }

    /** Se llama antes de aplicar un cambio de formato (negrita, color, lista, etc.)
     * para poder deshacerlo también, no solo los cambios de texto escrito. */
    private fun snapshotForUndo() {
        debounceRunnable?.let { debounceHandler.removeCallbacks(it) }
        val snapshot = android.text.SpannableString(binding.bodyInput.text)
        if (undoStack.lastOrNull()?.toString() != snapshot.toString() ||
            undoStack.lastOrNull() != snapshot
        ) {
            undoStack.add(snapshot)
            redoStack.clear()
        }
    }

    /** Se llama tras cada cambio de texto: renumera listas numeradas consecutivas
     * sin tocar el resto del contenido (para no perder negrita/color/etc). */
    private fun renumberListsIfNeeded() {
        val editable = binding.bodyInput.text
        val text = editable.toString()
        val regex = Regex("^(\\d+)\\. ")

        val lineStarts = mutableListOf(0)
        for (i in text.indices) {
            if (text[i] == '\n') lineStarts.add(i + 1)
        }

        var expected = 1
        var inBlock = false
        var offset = 0
        var didChange = false

        for (lineStart in lineStarts) {
            val adjStart = lineStart + offset
            if (adjStart > editable.length) break
            var lineEnd = adjStart
            while (lineEnd < editable.length && editable[lineEnd] != '\n') lineEnd++
            val lineText = editable.substring(adjStart, lineEnd)
            val match = regex.find(lineText)
            if (match != null) {
                if (!inBlock) {
                    expected = 1
                    inBlock = true
                }
                val oldNum = match.groupValues[1]
                val newNum = expected.toString()
                if (oldNum != newNum) {
                    if (!didChange) {
                        suppressWatcher = true
                        didChange = true
                    }
                    editable.replace(adjStart, adjStart + oldNum.length, newNum)
                    offset += newNum.length - oldNum.length
                }
                expected++
            } else {
                inBlock = false
            }
        }

        if (didChange) suppressWatcher = false
    }

    // ---------- Tipografía ----------

    private fun showFontMenu() {
        val popup = PopupMenu(this, binding.formattingPanelInclude.btnFontFamily)
        popup.menu.add(0, 0, 0, getString(R.string.predeterminada))
        popup.menu.add(0, 1, 1, getString(R.string.sans_serif))
        popup.menu.add(0, 2, 2, getString(R.string.serif))
        popup.menu.add(0, 3, 3, getString(R.string.monoespaciada))
        popup.setOnMenuItemClickListener { item ->
            val key = when (item.itemId) {
                1 -> "sans"
                2 -> "serif"
                3 -> "monospace"
                else -> "predeterminada"
            }
            applyFont(key)
            currentNote?.let { NoteRepository.setFontFamily(this, it.id, key) }
            true
        }
        popup.show()
    }

    // ---------- Dictado por voz ----------

    private fun startVoiceRecognition() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO)
            != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this, arrayOf(Manifest.permission.RECORD_AUDIO), REQUEST_RECORD_AUDIO_PERMISSION
            )
            return
        }
        launchSpeechRecognizer()
    }

    private fun launchSpeechRecognizer() {
        val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
            putExtra(RecognizerIntent.EXTRA_LANGUAGE, Locale("es", "ES"))
            putExtra(RecognizerIntent.EXTRA_PROMPT, getString(R.string.di_algo))
        }
        try {
            startActivityForResult(intent, REQUEST_SPEECH)
        } catch (e: Exception) {
            Toast.makeText(this, R.string.dictar_voz, Toast.LENGTH_SHORT).show()
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_RECORD_AUDIO_PERMISSION &&
            grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED
        ) {
            launchSpeechRecognizer()
        }
    }

    private fun insertRecognizedText(text: String) {
        val current = binding.bodyInput.text
        val cursor = binding.bodyInput.selectionStart.coerceAtLeast(0)
        val prefix = if (current.isNotEmpty() && cursor > 0 && current[cursor - 1] != ' ' && current[cursor - 1] != '\n') " " else ""
        current.insert(cursor, "$prefix$text")
    }

    // ---------- Barra de formato de texto ----------

    private fun setupFormattingToolbar() {
        val panel = binding.formattingPanelInclude
        binding.formatToggleButton.setOnClickListener {
            panel.formattingPanel.visibility =
                if (panel.formattingPanel.visibility == View.VISIBLE) View.GONE else View.VISIBLE
        }

        panel.btnH1.setOnClickListener { snapshotForUndo(); TextFormatter.applyHeading(binding.bodyInput, 1.8f) }
        panel.btnH2.setOnClickListener { snapshotForUndo(); TextFormatter.applyHeading(binding.bodyInput, 1.5f) }
        panel.btnH3.setOnClickListener { snapshotForUndo(); TextFormatter.applyHeading(binding.bodyInput, 1.3f) }
        panel.btnH4.setOnClickListener { snapshotForUndo(); TextFormatter.applyHeading(binding.bodyInput, 1.15f) }
        panel.btnBody.setOnClickListener { snapshotForUndo(); TextFormatter.applyHeading(binding.bodyInput, null) }

        panel.btnBold.setOnClickListener { snapshotForUndo(); TextFormatter.toggleBold(binding.bodyInput) }
        panel.btnItalic.setOnClickListener { snapshotForUndo(); TextFormatter.toggleItalic(binding.bodyInput) }
        panel.btnUnderline.setOnClickListener { snapshotForUndo(); TextFormatter.toggleUnderline(binding.bodyInput) }
        panel.btnStrike.setOnClickListener { snapshotForUndo(); TextFormatter.toggleStrikethrough(binding.bodyInput) }
        panel.btnIndentInc.setOnClickListener { snapshotForUndo(); TextFormatter.increaseIndent(binding.bodyInput) }
        panel.btnIndentDec.setOnClickListener { snapshotForUndo(); TextFormatter.decreaseIndent(binding.bodyInput) }

        panel.btnListNumbered.setOnClickListener {
            snapshotForUndo()
            TextFormatter.toggleLinePrefix(binding.bodyInput, "", numbered = true)
        }
        panel.btnListBullet.setOnClickListener {
            snapshotForUndo()
            TextFormatter.toggleLinePrefix(binding.bodyInput, "• ")
        }
        panel.btnChecklist.setOnClickListener {
            snapshotForUndo()
            TextFormatter.toggleLinePrefix(binding.bodyInput, "☐ ")
        }
        panel.btnAlignLeft.setOnClickListener {
            snapshotForUndo()
            TextFormatter.applyAlignment(binding.bodyInput, android.text.Layout.Alignment.ALIGN_NORMAL)
        }
        panel.btnAlignCenter.setOnClickListener {
            snapshotForUndo()
            TextFormatter.applyAlignment(binding.bodyInput, android.text.Layout.Alignment.ALIGN_CENTER)
        }
        panel.btnAlignRight.setOnClickListener {
            snapshotForUndo()
            TextFormatter.applyAlignment(binding.bodyInput, android.text.Layout.Alignment.ALIGN_OPPOSITE)
        }
        panel.btnFontFamily.setOnClickListener { showFontMenu() }
        panel.btnTextColor.setOnClickListener { showTextColorPicker() }
    }

    private fun showTextColorPicker() {
        val colors = listOf(
            "#FFFFFF", "#F5A623", "#E5484D", "#4A9EFF", "#4CC38A", "#B784E0"
        )
        val row = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            setPadding(32, 32, 32, 32)
        }
        for (colorHex in colors) {
            val swatch = View(this)
            val size = 120
            val params = LinearLayout.LayoutParams(size, size).apply { setMargins(10, 0, 10, 0) }
            swatch.layoutParams = params
            val drawable = android.graphics.drawable.GradientDrawable()
            drawable.shape = android.graphics.drawable.GradientDrawable.OVAL
            drawable.setColor(Color.parseColor(colorHex))
            drawable.setStroke(2, ContextCompat.getColor(this, R.color.dark_text_secondary))
            swatch.background = drawable
            row.addView(swatch)
            swatch.setOnClickListener {
                snapshotForUndo()
                TextFormatter.applyTextColor(binding.bodyInput, Color.parseColor(colorHex))
            }
        }
        AlertDialog.Builder(this)
            .setTitle(R.string.color_de_texto)
            .setView(row)
            .setPositiveButton(android.R.string.ok, null)
            .show()
    }

    // ---------- Bloqueo ----------

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
                override fun onAuthenticationFailed() {}
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
            PinDialogHelper.showCreatePinDialog(this) { onSuccess() }
        }
    }

    // ---------- Menú de opciones (⋮) ----------

    private fun showOptionsMenu() {
        val note = currentNote ?: return
        val popup = PopupMenu(this, binding.menuButton)
        popup.menu.add(0, 0, 0, getString(if (note.pinned) R.string.desanclar else R.string.anclar))
            .setIcon(R.drawable.ic_pin)
        popup.menu.add(0, 1, 1, getString(if (note.locked) R.string.desbloquear else R.string.bloquear))
            .setIcon(R.drawable.ic_lock)
        popup.menu.add(0, 2, 2, getString(R.string.compartir)).setIcon(R.drawable.ic_share)
        popup.menu.add(0, 3, 3, getString(R.string.color_de_fondo)).setIcon(R.drawable.ic_palette)
        popup.menu.add(0, 4, 4, getString(R.string.eliminar_nota)).setIcon(R.drawable.ic_trash)
        MenuIconHelper.forceShowIcons(popup)
        popup.setOnMenuItemClickListener { item ->
            when (item.itemId) {
                0 -> togglePinned()
                1 -> toggleLocked()
                2 -> shareNote()
                3 -> showColorPicker()
                4 -> deleteNote()
            }
            true
        }
        popup.show()
    }

    private fun deleteNote() {
        val note = currentNote ?: return
        NoteRepository.deleteNote(this, note.id)
        finish()
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
        val plainText = HtmlUtils.toPlainText(note.text)
        val shareText = if (note.title.isNotBlank()) "${note.title}\n\n$plainText" else plainText
        val shareHtml = if (note.title.isNotBlank()) {
            "<b>${note.title}</b><br><br>${note.text}"
        } else {
            note.text
        }
        val intent = Intent(Intent.ACTION_SEND).apply {
            type = "text/plain"
            putExtra(Intent.EXTRA_TEXT, shareText)
            putExtra(Intent.EXTRA_HTML_TEXT, shareHtml)
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

        val dialog = AlertDialog.Builder(this)
            .setTitle(R.string.color_de_fondo)
            .setView(row)
            .setPositiveButton(android.R.string.ok, null)
            .show()
        dialog.getButton(AlertDialog.BUTTON_POSITIVE)
            ?.setTextColor(ContextCompat.getColor(this, R.color.accent_yellow))
    }

    // ---------- Adjuntos (imágenes, dibujos, tablas) ----------

    private fun renderAttachments() {
        binding.attachmentsContainer.removeAllViews()
        binding.attachmentsScroll.visibility = if (attachments.isEmpty()) View.GONE else View.VISIBLE

        for (path in attachments) {
            val frame = FrameLayout(this)
            val frameParams = LinearLayout.LayoutParams(220, 220).apply { setMargins(0, 0, 16, 0) }
            frame.layoutParams = frameParams

            val imageView = ImageView(this)
            imageView.layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT
            )
            imageView.scaleType = ImageView.ScaleType.CENTER_CROP
            val bitmap = android.graphics.BitmapFactory.decodeFile(path)
            if (bitmap != null) imageView.setImageBitmap(bitmap)

            val tableData = loadTableData(path)
            if (tableData != null) {
                imageView.setOnClickListener {
                    showTableEditorDialog(tableData.first, tableData.second, tableData.third, existingPath = path)
                }
            }
            frame.addView(imageView)

            val deleteButton = ImageView(this)
            val deleteSize = 48
            val deleteParams = FrameLayout.LayoutParams(deleteSize, deleteSize).apply {
                gravity = Gravity.TOP or Gravity.END
                setMargins(0, 6, 6, 0)
            }
            deleteButton.layoutParams = deleteParams
            deleteButton.setImageResource(R.drawable.ic_close_circle)
            deleteButton.contentDescription = getString(R.string.eliminar_adjunto)
            deleteButton.setOnClickListener {
                attachments.remove(path)
                currentNote?.let { NoteRepository.removeAttachment(this, it.id, path) }
                File(jsonPathFor(path)).let { if (it.exists()) it.delete() }
                renderAttachments()
            }
            frame.addView(deleteButton)

            binding.attachmentsContainer.addView(frame)
        }
    }

    private fun addAttachment(path: String) {
        attachments.add(path)
        currentNote?.let {
            NoteRepository.addAttachment(this, it.id, path)
        } ?: run {
            // Nota nueva todavía sin guardar: se persistirá al pulsar Guardar
        }
        renderAttachments()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode != RESULT_OK || data == null) return

        when (requestCode) {
            REQUEST_DRAWING -> {
                val path = data.getStringExtra(DrawingActivity.EXTRA_RESULT_PATH)
                if (path != null) addAttachment(path)
            }
            REQUEST_IMAGE_PICK -> {
                val uri = data.data ?: return
                try {
                    val dir = File(filesDir, "images").apply { mkdirs() }
                    val outFile = File(dir, "${UUID.randomUUID()}.jpg")
                    contentResolver.openInputStream(uri)?.use { input ->
                        FileOutputStream(outFile).use { output -> input.copyTo(output) }
                    }
                    addAttachment(outFile.absolutePath)
                } catch (e: Exception) {
                    // si falla la copia, simplemente no se añade el adjunto
                }
            }
            REQUEST_SPEECH -> {
                val results = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS)
                val recognized = results?.firstOrNull()
                if (!recognized.isNullOrBlank()) {
                    insertRecognizedText(recognized)
                }
            }
        }
    }

    // ---------- Tablas ----------

    private fun jsonPathFor(pngPath: String): String = pngPath.removeSuffix(".png") + ".json"

    private fun loadTableData(path: String): Triple<Int, Int, Array<Array<String>>>? {
        val jsonFile = File(jsonPathFor(path))
        if (!jsonFile.exists()) return null
        return try {
            val json = org.json.JSONObject(jsonFile.readText())
            val rows = json.getInt("rows")
            val cols = json.getInt("cols")
            val cellsArray = json.getJSONArray("cells")
            val texts = Array(rows) { r ->
                val rowArray = cellsArray.getJSONArray(r)
                Array(cols) { c -> rowArray.getString(c) }
            }
            Triple(rows, cols, texts)
        } catch (e: Exception) {
            null
        }
    }

    private fun saveTableData(pngPath: String, rows: Int, cols: Int, texts: Array<Array<String>>) {
        val json = org.json.JSONObject()
        json.put("rows", rows)
        json.put("cols", cols)
        val cellsArray = org.json.JSONArray()
        for (r in 0 until rows) {
            val rowArray = org.json.JSONArray()
            for (c in 0 until cols) rowArray.put(texts[r][c])
            cellsArray.put(rowArray)
        }
        json.put("cells", cellsArray)
        File(jsonPathFor(pngPath)).writeText(json.toString())
    }

    private fun showTableSizeDialog() {
        val container = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(48, 24, 48, 0)
        }
        val rowsInput = EditText(this).apply {
            hint = getString(R.string.filas)
            inputType = android.text.InputType.TYPE_CLASS_NUMBER
            setText("3")
        }
        val colsInput = EditText(this).apply {
            hint = getString(R.string.columnas)
            inputType = android.text.InputType.TYPE_CLASS_NUMBER
            setText("3")
        }
        container.addView(rowsInput)
        container.addView(colsInput)

        AlertDialog.Builder(this)
            .setTitle(R.string.crear_tabla)
            .setView(container)
            .setPositiveButton(android.R.string.ok) { _, _ ->
                val rows = (rowsInput.text.toString().toIntOrNull() ?: 3).coerceIn(1, 8)
                val cols = (colsInput.text.toString().toIntOrNull() ?: 3).coerceIn(1, 8)
                showTableEditorDialog(rows, cols, null, null)
            }
            .setNegativeButton(android.R.string.cancel, null)
            .show()
    }

    private fun showTableEditorDialog(
        rows: Int,
        cols: Int,
        prefill: Array<Array<String>>?,
        existingPath: String?
    ) {
        val table = TableLayout(this).apply {
            setPadding(24, 24, 24, 24)
        }
        val cellInputs = Array(rows) { arrayOfNulls<EditText>(cols) }

        for (r in 0 until rows) {
            val row = TableRow(this)
            for (c in 0 until cols) {
                val cell = EditText(this)
                cell.layoutParams = TableRow.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f)
                cell.setPadding(12, 12, 12, 12)
                cell.textSize = 13f
                prefill?.getOrNull(r)?.getOrNull(c)?.let { cell.setText(it) }
                row.addView(cell)
                cellInputs[r][c] = cell
            }
            table.addView(row)
        }

        val scroll = android.widget.ScrollView(this)
        scroll.addView(table)

        val builder = AlertDialog.Builder(this)
            .setTitle(R.string.crear_tabla)
            .setView(scroll)
            .setPositiveButton(android.R.string.ok) { _, _ ->
                val texts = Array(rows) { r -> Array(cols) { c -> cellInputs[r][c]?.text?.toString().orEmpty() } }
                val bitmap = renderTableBitmap(rows, cols, texts)
                if (existingPath != null) {
                    // Editamos la tabla existente en el mismo archivo (misma miniatura)
                    FileOutputStream(existingPath).use { out -> bitmap.compress(Bitmap.CompressFormat.PNG, 100, out) }
                    saveTableData(existingPath, rows, cols, texts)
                    renderAttachments()
                } else {
                    val dir = File(filesDir, "tables").apply { mkdirs() }
                    val file = File(dir, "${UUID.randomUUID()}.png")
                    FileOutputStream(file).use { out -> bitmap.compress(Bitmap.CompressFormat.PNG, 100, out) }
                    saveTableData(file.absolutePath, rows, cols, texts)
                    addAttachment(file.absolutePath)
                }
            }
            .setNegativeButton(android.R.string.cancel, null)
        if (existingPath != null) {
            builder.setNeutralButton(R.string.eliminar_adjunto) { _, _ ->
                attachments.remove(existingPath)
                currentNote?.let { NoteRepository.removeAttachment(this, it.id, existingPath) }
                File(jsonPathFor(existingPath)).let { if (it.exists()) it.delete() }
                renderAttachments()
            }
        }
        builder.show()
    }

    private fun renderTableBitmap(rows: Int, cols: Int, texts: Array<Array<String>>): Bitmap {
        val cellWidth = 180
        val cellHeight = 90
        val width = cellWidth * cols
        val height = cellHeight * rows
        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        canvas.drawColor(Color.WHITE)

        val linePaint = Paint().apply {
            color = Color.parseColor("#5C4322")
            strokeWidth = 3f
        }
        val textPaint = Paint().apply {
            color = Color.parseColor("#5C4322")
            textSize = 26f
            isAntiAlias = true
        }

        for (r in 0..rows) {
            canvas.drawLine(0f, (r * cellHeight).toFloat(), width.toFloat(), (r * cellHeight).toFloat(), linePaint)
        }
        for (c in 0..cols) {
            canvas.drawLine((c * cellWidth).toFloat(), 0f, (c * cellWidth).toFloat(), height.toFloat(), linePaint)
        }
        for (r in 0 until rows) {
            for (c in 0 until cols) {
                val text = texts[r][c]
                canvas.drawText(
                    text,
                    (c * cellWidth + 12).toFloat(),
                    (r * cellHeight + cellHeight / 2 + 8).toFloat(),
                    textPaint
                )
            }
        }
        return bitmap
    }

    // ---------- Guardar ----------

    private fun saveAndFinish() {
        val title = binding.titleInput.text.toString().trim()
        val bodyPlain = binding.bodyInput.text.toString().trim()
        val bodyHtml = HtmlUtils.toHtml(binding.bodyInput.text)

        if (title.isEmpty() && bodyPlain.isEmpty() && attachments.isEmpty()) {
            finish()
            return
        }

        val existing = currentNote
        if (existing != null) {
            NoteRepository.updateNote(this, existing.copy(title = title, text = bodyHtml, attachments = attachments))
        } else {
            NoteRepository.addNote(this, title, bodyHtml)
            // Si se añadieron adjuntos antes de guardar por primera vez, los enlazamos ahora
            if (attachments.isNotEmpty()) {
                val created = NoteRepository.getNotes(this).firstOrNull { it.title == title && it.text == bodyHtml }
                created?.let { note ->
                    NoteRepository.updateNote(this, note.copy(attachments = attachments))
                }
            }
        }
        finish()
    }
}
ZZEOF

echo "Busqueda combinada, compartir con formato, y el bug de MutableList corregido. Compilando..."
./gradlew assembleDebug
rm -- "$0"