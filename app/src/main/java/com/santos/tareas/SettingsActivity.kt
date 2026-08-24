package com.santos.tareas

import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.santos.tareas.databinding.ActivitySettingsBinding

class SettingsActivity : AppCompatActivity() {

    private lateinit var binding: ActivitySettingsBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySettingsBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.backButton.setOnClickListener { finish() }
        binding.emptyTrashRow.setOnClickListener {
            android.app.AlertDialog.Builder(this)
                .setTitle(R.string.vaciar_papelera)
                .setMessage(R.string.confirmar_vaciar_papelera)
                .setPositiveButton(R.string.eliminar_definitivamente) { _, _ ->
                    NoteRepository.emptyTrash(this)
                    TaskRepository.emptyTrash(this)
                    Toast.makeText(this, R.string.papelera, Toast.LENGTH_SHORT).show()
                }
                .setNegativeButton(android.R.string.cancel, null)
                .show()
        }
    }
}
