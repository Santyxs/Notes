package com.santos.tareas

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.santos.tareas.databinding.ActivityTrashBinding
import com.santos.tareas.databinding.ItemTrashRowBinding

private data class TrashItem(val id: Long, val text: String, val isNote: Boolean)

class TrashActivity : AppCompatActivity() {

    private lateinit var binding: ActivityTrashBinding
    private lateinit var adapter: TrashAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityTrashBinding.inflate(layoutInflater)
        setContentView(binding.root)

        adapter = TrashAdapter(
            onRestore = { item ->
                if (item.isNote) NoteRepository.restoreNote(this, item.id)
                else TaskRepository.restoreTask(this, item.id)
                load()
            },
            onDeleteForever = { item ->
                android.app.AlertDialog.Builder(this)
                    .setTitle(R.string.eliminar_definitivamente)
                    .setMessage(R.string.confirmar_eliminar_definitivamente)
                    .setPositiveButton(R.string.eliminar_definitivamente) { _, _ ->
                        if (item.isNote) NoteRepository.permanentlyDeleteNote(this, item.id)
                        else TaskRepository.permanentlyDeleteTask(this, item.id)
                        load()
                    }
                    .setNegativeButton(android.R.string.cancel, null)
                    .show()
            }
        )
        binding.recyclerView.layoutManager = LinearLayoutManager(this)
        binding.recyclerView.adapter = adapter

        binding.backButton.setOnClickListener { finish() }
        binding.emptyTrashButton.setOnClickListener {
            android.app.AlertDialog.Builder(this)
                .setTitle(R.string.vaciar_papelera)
                .setMessage(R.string.confirmar_vaciar_papelera)
                .setPositiveButton(R.string.eliminar_definitivamente) { _, _ ->
                    NoteRepository.emptyTrash(this)
                    TaskRepository.emptyTrash(this)
                    load()
                }
                .setNegativeButton(android.R.string.cancel, null)
                .show()
        }
    }

    override fun onResume() {
        super.onResume()
        load()
    }

    private fun load() {
        val notes = NoteRepository.getDeletedNotes(this).map {
            TrashItem(it.id, it.title.ifBlank { HtmlUtils.toPlainText(it.text) }.ifBlank { getString(R.string.notas) }, true)
        }
        val tasks = TaskRepository.getDeletedTasks(this).map {
            TrashItem(it.id, it.title, false)
        }
        val all = notes + tasks
        adapter.submitList(all)
        binding.emptyView.visibility = if (all.isEmpty()) View.VISIBLE else View.GONE
    }
}

private class TrashAdapter(
    private val onRestore: (TrashItem) -> Unit,
    private val onDeleteForever: (TrashItem) -> Unit
) : RecyclerView.Adapter<TrashAdapter.ViewHolder>() {

    private var items: List<TrashItem> = emptyList()

    fun submitList(newItems: List<TrashItem>) {
        items = newItems
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding = ItemTrashRowBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(items[position])
    }

    override fun getItemCount(): Int = items.size

    inner class ViewHolder(private val binding: ItemTrashRowBinding) :
        RecyclerView.ViewHolder(binding.root) {
        fun bind(item: TrashItem) {
            binding.itemText.text = item.text
            binding.restoreButton.setOnClickListener { onRestore(item) }
            binding.deleteForeverButton.setOnClickListener { onDeleteForever(item) }
        }
    }
}
