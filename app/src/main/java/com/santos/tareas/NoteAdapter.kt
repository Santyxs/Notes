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
            binding.noteDate.text = DateUtils.format(note.createdAt)
            binding.root.setOnClickListener { onClick(note) }
            binding.deleteButton.setOnClickListener { onDelete(note) }
        }
    }
}
