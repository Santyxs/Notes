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
            binding.checkbox.isChecked = task.done
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
