package com.santos.tareas

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.santos.tareas.databinding.ActivityAddEditTaskBinding

class AddEditTaskActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_TASK_ID = "extra_task_id"
    }

    private lateinit var binding: ActivityAddEditTaskBinding
    private var editingTaskId: Long? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddEditTaskBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val taskId = intent.getLongExtra(EXTRA_TASK_ID, -1L)
        if (taskId != -1L) {
            editingTaskId = taskId
            val task = TaskRepository.getTasks(this).find { it.id == taskId }
            binding.taskInput.setText(task?.title ?: "")
            binding.saveButton.text = getString(R.string.guardar)
        }

        binding.saveButton.setOnClickListener {
            val title = binding.taskInput.text.toString().trim()
            if (title.isNotEmpty()) {
                val id = editingTaskId
                if (id != null) {
                    TaskRepository.updateTask(this, Task(id = id, title = title, done = false))
                } else {
                    TaskRepository.addTask(this, title)
                }
                finish()
            }
        }

        binding.cancelButton.setOnClickListener { finish() }
    }
}
