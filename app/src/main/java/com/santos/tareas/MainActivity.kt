package com.santos.tareas

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.santos.tareas.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.notesCard.setOnClickListener {
            startActivity(Intent(this, NotesActivity::class.java))
        }
        binding.tasksCard.setOnClickListener {
            startActivity(Intent(this, TasksActivity::class.java))
        }
    }
}
