package com.santos.tareas

import android.Manifest
import android.app.AlertDialog
import android.app.DatePickerDialog
import android.app.TimePickerDialog
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.widget.PopupMenu
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.santos.tareas.databinding.ActivityAddEditTaskBinding
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale

class AddEditTaskActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_TASK_ID = "extra_task_id"
        private const val REQUEST_NOTIFICATION_PERMISSION = 400
    }

    private lateinit var binding: ActivityAddEditTaskBinding
    private var editingTaskId: Long? = null
    private var currentPriority: Int = 0
    private var currentReminderAt: Long = 0L
    private var currentDone: Boolean = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddEditTaskBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val taskId = intent.getLongExtra(EXTRA_TASK_ID, -1L)
        if (taskId != -1L) {
            editingTaskId = taskId
            val task = TaskRepository.getTasks(this).find { it.id == taskId }
            binding.taskInput.setText(task?.title ?: "")
            currentPriority = task?.priority ?: 0
            currentReminderAt = task?.reminderAt ?: 0L
            currentDone = task?.done ?: false
        }

        updatePriorityUi()
        updateReminderUi()

        binding.backButton.setOnClickListener { saveAndFinish() }
        binding.cancelButton.setOnClickListener { finish() }
        binding.saveButton.setOnClickListener { saveAndFinish() }
        binding.priorityRow.setOnClickListener { showPriorityMenu() }
        binding.reminderRow.setOnClickListener { showReminderPicker() }
    }

    // ---------- Prioridad ----------

    private fun showPriorityMenu() {
        val popup = PopupMenu(this, binding.priorityRow)
        popup.menu.add(0, 0, 0, getString(R.string.prioridad_ninguna))
        popup.menu.add(0, 1, 1, getString(R.string.prioridad_baja))
        popup.menu.add(0, 2, 2, getString(R.string.prioridad_media))
        popup.menu.add(0, 3, 3, getString(R.string.prioridad_alta))
        popup.setOnMenuItemClickListener { item ->
            currentPriority = item.itemId
            updatePriorityUi()
            true
        }
        popup.show()
    }

    private fun updatePriorityUi() {
        val (labelRes, colorRes) = when (currentPriority) {
            1 -> R.string.prioridad_baja to R.color.priority_low
            2 -> R.string.prioridad_media to R.color.priority_medium
            3 -> R.string.prioridad_alta to R.color.priority_high
            else -> R.string.prioridad_ninguna to R.color.priority_none
        }
        binding.priorityValueLabel.text = getString(labelRes)
        binding.priorityIcon.setColorFilter(ContextCompat.getColor(this, colorRes))
    }

    // ---------- Recordatorio ----------

    private fun showReminderPicker() {
        val calendar = Calendar.getInstance()
        if (currentReminderAt > 0) calendar.timeInMillis = currentReminderAt

        DatePickerDialog(
            this,
            { _, year, month, day ->
                calendar.set(year, month, day)
                TimePickerDialog(
                    this,
                    { _, hour, minute ->
                        calendar.set(Calendar.HOUR_OF_DAY, hour)
                        calendar.set(Calendar.MINUTE, minute)
                        calendar.set(Calendar.SECOND, 0)
                        if (calendar.timeInMillis <= System.currentTimeMillis()) {
                            calendar.add(Calendar.DAY_OF_YEAR, 1)
                        }
                        currentReminderAt = calendar.timeInMillis
                        updateReminderUi()
                        ensureNotificationPermission()
                    },
                    calendar.get(Calendar.HOUR_OF_DAY),
                    calendar.get(Calendar.MINUTE),
                    true
                ).show()
            },
            calendar.get(Calendar.YEAR),
            calendar.get(Calendar.MONTH),
            calendar.get(Calendar.DAY_OF_MONTH)
        ).show()
    }

    private fun ensureNotificationPermission() {
        if (Build.VERSION.SDK_INT >= 33) {
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS)
                != PackageManager.PERMISSION_GRANTED
            ) {
                ActivityCompat.requestPermissions(
                    this, arrayOf(Manifest.permission.POST_NOTIFICATIONS), REQUEST_NOTIFICATION_PERMISSION
                )
            }
        }
    }

    private fun updateReminderUi() {
        if (currentReminderAt > 0) {
            val formatter = SimpleDateFormat("d MMM, HH:mm", Locale("es", "ES"))
            binding.reminderValueLabel.text = formatter.format(currentReminderAt)
            binding.reminderRow.setOnLongClickListener {
                confirmRemoveReminder()
                true
            }
        } else {
            binding.reminderValueLabel.text = getString(R.string.sin_recordatorio)
            binding.reminderRow.setOnLongClickListener(null)
        }
    }

    private fun confirmRemoveReminder() {
        AlertDialog.Builder(this)
            .setTitle(R.string.quitar_recordatorio)
            .setPositiveButton(android.R.string.ok) { _, _ ->
                currentReminderAt = 0L
                updateReminderUi()
            }
            .setNegativeButton(android.R.string.cancel, null)
            .show()
    }

    // ---------- Guardar ----------

    private fun saveAndFinish() {
        val title = binding.taskInput.text.toString().trim()
        if (title.isEmpty()) {
            val id = editingTaskId
            if (id != null) ReminderManager.cancel(this, id)
            finish()
            return
        }
        val id = editingTaskId
        val savedId: Long
        if (id != null) {
            TaskRepository.updateTask(
                this,
                Task(
                    id = id,
                    title = title,
                    done = currentDone,
                    priority = currentPriority,
                    reminderAt = currentReminderAt
                )
            )
            savedId = id
        } else {
            TaskRepository.addTask(this, title)
            val created = TaskRepository.getTasks(this).lastOrNull { it.title == title }
            savedId = created?.id ?: -1L
            if (created != null) {
                TaskRepository.updateTask(
                    this,
                    created.copy(priority = currentPriority, reminderAt = currentReminderAt)
                )
            }
        }

        if (savedId != -1L) {
            if (currentReminderAt > 0) {
                ReminderManager.schedule(this, savedId, currentReminderAt)
            } else {
                ReminderManager.cancel(this, savedId)
            }
        }
        finish()
    }
}
