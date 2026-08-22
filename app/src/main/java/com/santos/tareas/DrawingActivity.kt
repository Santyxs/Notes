package com.santos.tareas

import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.santos.tareas.databinding.ActivityDrawingBinding
import java.io.File
import java.io.FileOutputStream
import java.util.UUID

class DrawingActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_RESULT_PATH = "extra_result_path"
    }

    private lateinit var binding: ActivityDrawingBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityDrawingBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.backButton.setOnClickListener { finish() }
        binding.clearButton.setOnClickListener { binding.drawingView.clear() }

        binding.colorWhite.setOnClickListener { binding.drawingView.setColor(Color.WHITE) }
        binding.colorYellow.setOnClickListener { binding.drawingView.setColor(Color.parseColor("#F5A623")) }
        binding.colorRed.setOnClickListener { binding.drawingView.setColor(Color.parseColor("#E5484D")) }
        binding.colorBlue.setOnClickListener { binding.drawingView.setColor(Color.parseColor("#4A9EFF")) }
        binding.colorGreen.setOnClickListener { binding.drawingView.setColor(Color.parseColor("#4CC38A")) }

        binding.saveDrawingButton.setOnClickListener {
            if (binding.drawingView.isEmpty()) {
                finish()
                return@setOnClickListener
            }
            val bitmap = binding.drawingView.exportBitmap()
            val dir = File(filesDir, "drawings").apply { mkdirs() }
            val file = File(dir, "${UUID.randomUUID()}.png")
            FileOutputStream(file).use { out ->
                bitmap.compress(android.graphics.Bitmap.CompressFormat.PNG, 100, out)
            }
            val resultIntent = Intent()
            resultIntent.putExtra(EXTRA_RESULT_PATH, file.absolutePath)
            setResult(RESULT_OK, resultIntent)
            finish()
        }
    }
}
