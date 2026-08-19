package com.santos.tareas

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.santos.tareas.databinding.ActivityAddEditNoteBinding

class AddEditNoteActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_NOTE_ID = "extra_note_id"
    }

    private lateinit var binding: ActivityAddEditNoteBinding
    private var editingNoteId: Long? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddEditNoteBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val noteId = intent.getLongExtra(EXTRA_NOTE_ID, -1L)
        if (noteId != -1L) {
            editingNoteId = noteId
            val note = NoteRepository.getNotes(this).find { it.id == noteId }
            binding.noteInput.setText(note?.text ?: "")
            binding.saveButton.text = getString(R.string.guardar)
        }

        binding.saveButton.setOnClickListener {
            val text = binding.noteInput.text.toString().trim()
            if (text.isNotEmpty()) {
                val id = editingNoteId
                if (id != null) {
                    NoteRepository.updateNote(this, Note(id = id, text = text))
                } else {
                    NoteRepository.addNote(this, text)
                }
                finish()
            }
        }

        binding.cancelButton.setOnClickListener { finish() }
    }
}
