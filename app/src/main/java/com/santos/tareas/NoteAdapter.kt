package com.santos.tareas

import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
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
            val context = binding.root.context

            if (flatStyle) {
                binding.root.setBackgroundResource(R.drawable.dark_row_flat_background)
            } else {
                val bg = ContextCompat.getDrawable(context, R.drawable.dark_row_background)
                    ?.mutate() as GradientDrawable
                bg.setColor(
                    if (note.color != null) Color.parseColor(note.color)
                    else ContextCompat.getColor(context, R.color.dark_surface)
                )
                binding.root.background = bg
            }

            binding.pinIcon.visibility = if (note.pinned) View.VISIBLE else View.GONE
            binding.lockIcon.visibility = if (note.locked) View.VISIBLE else View.GONE

            if (note.locked) {
                binding.noteTitle.visibility = View.VISIBLE
                binding.noteTitle.text = context.getString(R.string.nota_bloqueada)
                binding.text.text = ""
            } else if (note.title.isNotBlank()) {
                binding.noteTitle.visibility = View.VISIBLE
                binding.noteTitle.text = note.title
                binding.text.text = HtmlUtils.toPlainText(note.text)
            } else {
                binding.noteTitle.visibility = View.GONE
                binding.text.text = HtmlUtils.toPlainText(note.text)
            }

            binding.noteDate.text = DateUtils.format(note.createdAt)
            binding.root.setOnClickListener { onClick(note) }
            binding.deleteButton.setOnClickListener { onDelete(note) }
        }
    }
}
