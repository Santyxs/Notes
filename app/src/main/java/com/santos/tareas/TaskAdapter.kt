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
                        animator.duration = 550
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
