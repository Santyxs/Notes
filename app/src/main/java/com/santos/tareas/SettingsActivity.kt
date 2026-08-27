package com.santos.tareas

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.FileProvider
import com.santos.tareas.databinding.ActivitySettingsBinding
import java.io.File

class SettingsActivity : AppCompatActivity() {

    companion object {
        private const val REQUEST_IMPORT_BACKUP = 300
    }

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

        binding.exportRow.setOnClickListener { exportBackup() }
        binding.importRow.setOnClickListener {
            android.app.AlertDialog.Builder(this)
                .setTitle(R.string.importar_backup)
                .setMessage(R.string.confirmar_importar_backup)
                .setPositiveButton(android.R.string.ok) { _, _ -> pickBackupFile() }
                .setNegativeButton(android.R.string.cancel, null)
                .show()
        }
    }

    private fun exportBackup() {
        try {
            val json = BackupManager.exportJson(this)
            val dir = File(cacheDir, "backups").apply { mkdirs() }
            val file = File(dir, "notas_backup.json")
            file.writeText(json)

            val uri: Uri = FileProvider.getUriForFile(this, "$packageName.fileprovider", file)
            val intent = Intent(Intent.ACTION_SEND).apply {
                type = "application/json"
                putExtra(Intent.EXTRA_STREAM, uri)
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }
            startActivity(Intent.createChooser(intent, getString(R.string.exportar_backup)))
            Toast.makeText(this, R.string.backup_exportado, Toast.LENGTH_SHORT).show()
        } catch (e: Exception) {
            Toast.makeText(this, R.string.backup_error, Toast.LENGTH_SHORT).show()
        }
    }

    private fun pickBackupFile() {
        val intent = Intent(Intent.ACTION_GET_CONTENT).apply { type = "*/*" }
        startActivityForResult(intent, REQUEST_IMPORT_BACKUP)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode != REQUEST_IMPORT_BACKUP || resultCode != RESULT_OK) return
        val uri = data?.data ?: return
        try {
            val json = contentResolver.openInputStream(uri)?.bufferedReader()?.use { it.readText() }
            if (json != null && BackupManager.importJson(this, json)) {
                Toast.makeText(this, R.string.backup_importado, Toast.LENGTH_SHORT).show()
            } else {
                Toast.makeText(this, R.string.backup_error, Toast.LENGTH_SHORT).show()
            }
        } catch (e: Exception) {
            Toast.makeText(this, R.string.backup_error, Toast.LENGTH_SHORT).show()
        }
    }
}
