package com.santos.tareas

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.santos.tareas.databinding.ItemSearchResultRowBinding

sealed class SearchResult {
    data class NoteResult(val note: Note) : SearchResult()
    data class TaskResult(val task: Task) : SearchResult()
}

private fun SearchResult.stableId(): String = when (this) {
    is SearchResult.NoteResult -> "note-${note.id}"
    is SearchResult.TaskResult -> "task-${task.id}"
}

class SearchResultAdapter(
    private val onClickNote: (Note) -> Unit,
    private val onClickTask: (Task) -> Unit
) : RecyclerView.Adapter<SearchResultAdapter.ViewHolder>() {

    private var items: List<SearchResult> = emptyList()

    fun submitList(newItems: List<SearchResult>) {
        val diff = DiffUtil.calculateDiff(object : DiffUtil.Callback() {
            override fun getOldListSize() = items.size
            override fun getNewListSize() = newItems.size
            override fun areItemsTheSame(oldPos: Int, newPos: Int) =
                items[oldPos].stableId() == newItems[newPos].stableId()
            override fun areContentsTheSame(oldPos: Int, newPos: Int) =
                items[oldPos] == newItems[newPos]
        })
        items = newItems
        diff.dispatchUpdatesTo(this)
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
