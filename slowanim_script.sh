#!/bin/bash
set -e

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/TaskAdapter.kt << 'ZZEOF'
package com.santos.tareas

import android.animation.ValueAnimator
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.animation.DecelerateInterpolator
import androidx.recyclerview.widget.RecyclerView
import com.santos.tareas.databinding.ItemSectionHeaderBinding
import com.santos.tareas.databinding.ItemTaskRowBinding

sealed class TaskListItem {
    data class Header(val title: String, val collapsible: Boolean, val expanded: Boolean) : TaskListItem()
    data class Row(val task: Task) : TaskListItem()
}

private const val VIEW_TYPE_HEADER = 0
private const val VIEW_TYPE_ROW = 1

class TaskAdapter(
    private val onToggle: (Task) -> Unit,
    private val onClick: (Task) -> Unit,
    private val onDelete: (Task) -> Unit,
    private val onHeaderToggle: () -> Unit = {}
) : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    private var items: List<TaskListItem> = emptyList()
    var flatStyle: Boolean = false

    /** Id de la tarea recién marcada como hecha: solo esa fila anima la tachadura. */
    var justToggledId: Long? = null

    /** Se llama cuando termina la animación de tachado, para entonces sí reordenar en secciones. */
    var onAnimationEnd: (() -> Unit)? = null

    /**
     * Actualiza visualmente una tarea a "hecha" en su posición actual (sin moverla
     * todavía a la sección Completado), para poder reproducir la animación de tachado
     * en el sitio donde el usuario la tocó.
     */
    fun markDoneInPlace(taskId: Long) {
        val index = items.indexOfFirst { it is TaskListItem.Row && it.task.id == taskId }
        if (index == -1) return
        val row = items[index] as TaskListItem.Row
        val updatedItems = items.toMutableList()
        updatedItems[index] = TaskListItem.Row(row.task.copy(done = true))
        items = updatedItems
        justToggledId = taskId
        notifyItemChanged(index)
    }

    /** Mantiene compatibilidad con el código que llamaba submitList(List<Task>) sin secciones. */
    fun submitList(tasks: List<Task>) {
        items = tasks.map { TaskListItem.Row(it) }
        notifyDataSetChanged()
    }

    fun submitSections(newItems: List<TaskListItem>) {
        items = newItems
        notifyDataSetChanged()
    }

    fun isHeaderAt(position: Int): Boolean = items.getOrNull(position) is TaskListItem.Header

    override fun getItemViewType(position: Int): Int =
        if (items[position] is TaskListItem.Header) VIEW_TYPE_HEADER else VIEW_TYPE_ROW

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return if (viewType == VIEW_TYPE_HEADER) {
            val binding = ItemSectionHeaderBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            HeaderViewHolder(binding)
        } else {
            val binding = ItemTaskRowBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            TaskViewHolder(binding)
        }
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        when (val item = items[position]) {
            is TaskListItem.Header -> (holder as HeaderViewHolder).bind(item)
            is TaskListItem.Row -> (holder as TaskViewHolder).bind(item.task)
        }
    }

    override fun getItemCount(): Int = items.size

    inner class HeaderViewHolder(private val binding: ItemSectionHeaderBinding) :
        RecyclerView.ViewHolder(binding.root) {
        fun bind(header: TaskListItem.Header) {
            binding.sectionHeaderTitle.text = header.title
            if (header.collapsible) {
                binding.sectionHeaderChevron.visibility = android.view.View.VISIBLE
                binding.sectionHeaderChevron.rotation = if (header.expanded) 180f else 0f
                binding.sectionHeaderRow.setOnClickListener { onHeaderToggle() }
            } else {
                binding.sectionHeaderChevron.visibility = android.view.View.GONE
                binding.sectionHeaderRow.setOnClickListener(null)
            }
        }
    }

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

            binding.strikeLine.animate().cancel()

            if (task.done) {
                val shouldAnimate = task.id == justToggledId
                // Esperamos a que el título tenga su ancho real medido
                binding.title.post {
                    val textWidth = binding.title.width
                    if (textWidth <= 0) return@post
                    val params = binding.strikeLine.layoutParams
                    binding.strikeLine.visibility = View.VISIBLE

                    if (shouldAnimate) {
                        params.width = 1
                        binding.strikeLine.layoutParams = params
                        val animator = ValueAnimator.ofInt(1, textWidth)
                        animator.duration = 1800
                        animator.interpolator = DecelerateInterpolator()
                        animator.addUpdateListener { anim ->
                            val p = binding.strikeLine.layoutParams
                            p.width = anim.animatedValue as Int
                            binding.strikeLine.layoutParams = p
                        }
                        animator.addListener(object : android.animation.AnimatorListenerAdapter() {
                            override fun onAnimationEnd(animation: android.animation.Animator) {
                                onAnimationEnd?.invoke()
                            }
                        })
                        animator.start()
                        justToggledId = null
                    } else {
                        params.width = textWidth
                        binding.strikeLine.layoutParams = params
                    }
                }
            } else {
                binding.strikeLine.visibility = View.INVISIBLE
            }

            binding.checkbox.setOnClickListener { onToggle(task) }
            binding.root.setOnClickListener { onClick(task) }
            binding.deleteButton.setOnClickListener { onDelete(task) }
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
                if (!task.done) {
                    // Marcamos hecha en su sitio y esperamos a que termine de tacharse
                    // antes de reordenar en secciones (para que se vea la animación).
                    TaskRepository.toggleDone(this, task.id)
                    taskAdapter.onAnimationEnd = {
                        binding.recyclerView.postDelayed({
                            completedExpanded = true
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
cat > app/src/main/java/com/santos/tareas/TaskRemoteViewsFactory.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Context
import android.content.Intent
import android.graphics.Paint
import android.text.SpannableString
import android.text.Spanned
import android.text.style.StrikethroughSpan
import android.widget.RemoteViews
import android.widget.RemoteViewsService.RemoteViewsFactory

class TaskRemoteViewsFactory(private val context: Context) : RemoteViewsFactory {

    private var tasks: List<Task> = emptyList()

    override fun onCreate() {
        tasks = TaskRepository.getTasks(context).filter { !it.done }
    }

    override fun onDataSetChanged() {
        tasks = TaskRepository.getTasks(context).filter { !it.done }
    }

    override fun onDestroy() {
        tasks = emptyList()
    }

    override fun getCount(): Int = tasks.size

    override fun getViewAt(position: Int): RemoteViews {
        val task = tasks[position]
        val views = RemoteViews(context.packageName, R.layout.widget_task_item)

        if (task.done) {
            val spannable = SpannableString(task.title)
            spannable.setSpan(StrikethroughSpan(), 0, task.title.length, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
            views.setTextViewText(R.id.item_title, spannable)
            views.setInt(R.id.item_title, "setTextColor", android.graphics.Color.parseColor("#A9895C"))
        } else {
            views.setTextViewText(R.id.item_title, task.title)
            views.setInt(R.id.item_title, "setTextColor", android.graphics.Color.parseColor("#5C4322"))
        }

        views.setImageViewResource(
            R.id.item_checkbox,
            if (task.done) R.drawable.ic_check_circle_filled else R.drawable.ic_check_circle_outline
        )

        val fillInIntent = Intent().apply {
            putExtra(TaskWidgetProvider.EXTRA_TASK_ID, task.id)
        }
        views.setOnClickFillInIntent(R.id.item_row, fillInIntent)

        return views
    }

    override fun getLoadingView(): RemoteViews? = null
    override fun getViewTypeCount(): Int = 1
    override fun getItemId(position: Int): Long = tasks[position].id
    override fun hasStableIds(): Boolean = true
}
ZZEOF

echo "Animacion mas lenta + widget sin completadas. Compilando..."
./gradlew assembleDebug