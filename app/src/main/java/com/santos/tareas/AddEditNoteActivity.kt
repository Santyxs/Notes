package com.santos.tareas

import android.Manifest
import android.app.AlertDialog
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Typeface
import android.os.Bundle
import android.speech.RecognizerIntent
import android.text.Editable
import android.text.TextWatcher
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.FrameLayout
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.PopupMenu
import android.widget.TableLayout
import android.widget.TableRow
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.santos.tareas.databinding.ActivityAddEditNoteBinding
import java.io.File
import java.io.FileOutputStream
import java.util.Locale
import java.util.UUID

class AddEditNoteActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_NOTE_ID = "extra_note_id"
        private const val REQUEST_IMAGE_PICK = 100
        private const val REQUEST_DRAWING = 101
        private const val REQUEST_SPEECH = 102
        private const val REQUEST_RECORD_AUDIO_PERMISSION = 200

        val NOTE_COLORS: List<String?> = listOf(
            null, "#3A3A3E", "#2D4B73", "#2F5D50", "#6B3350", "#7A5A24"
        )

        val FONT_OPTIONS: List<Pair<String, Typeface?>> = listOf(
            "predeterminada" to Typeface.create("casual", Typeface.NORMAL),
            "sans" to Typeface.SANS_SERIF,
            "serif" to Typeface.SERIF,
            "monospace" to Typeface.MONOSPACE
        )
    }

    private lateinit var binding: ActivityAddEditNoteBinding
    private var editingNoteId: Long? = null
    private var currentNote: Note? = null
    private var attachments: MutableList<String> = mutableListOf()

    // Deshacer / rehacer del cuerpo de texto
    private val undoStack = mutableListOf<String>()
    private val redoStack = mutableListOf<String>()
    private var suppressWatcher = false
    private val debounceHandler = android.os.Handler(android.os.Looper.getMainLooper())
    private var debounceRunnable: Runnable? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddEditNoteBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.backButton.setOnClickListener { saveAndFinish() }
        binding.cancelButton.setOnClickListener { finish() }
        binding.saveButton.setOnClickListener { saveAndFinish() }
        binding.menuButton.setOnClickListener { showOptionsMenu() }

        binding.undoButton.setOnClickListener { performUndo() }
        binding.redoButton.setOnClickListener { performRedo() }
        binding.fontButton.setOnClickListener { showFontMenu() }
        binding.drawButton.setOnClickListener {
            startActivityForResult(Intent(this, DrawingActivity::class.java), REQUEST_DRAWING)
        }
        binding.imageButton.setOnClickListener {
            val intent = Intent(Intent.ACTION_GET_CONTENT).apply { type = "image/*" }
            startActivityForResult(intent, REQUEST_IMAGE_PICK)
        }
        binding.tableButton.setOnClickListener { showTableSizeDialog() }
        binding.micButton.setOnClickListener { startVoiceRecognition() }

        undoStack.add("")
        binding.bodyInput.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {}
            override fun afterTextChanged(s: Editable?) {
                if (suppressWatcher) return
                debounceRunnable?.let { debounceHandler.removeCallbacks(it) }
                debounceRunnable = Runnable {
                    val text = s.toString()
                    if (undoStack.lastOrNull() != text) {
                        undoStack.add(text)
                        redoStack.clear()
                    }
                }
                debounceHandler.postDelayed(debounceRunnable!!, 600)
            }
        })

        val noteId = intent.getLongExtra(EXTRA_NOTE_ID, -1L)
        if (noteId != -1L) {
            editingNoteId = noteId
            val note = NoteRepository.getNotes(this).find { it.id == noteId }
            if (note != null && note.locked) {
                requestUnlock(
                    onSuccess = { loadNote(note) },
                    onFail = { finish() }
                )
            } else if (note != null) {
                loadNote(note)
            }
        } else {
            binding.menuButton.visibility = View.GONE
        }
    }

    private fun loadNote(note: Note) {
        currentNote = note
        binding.titleInput.setText(note.title)
        binding.bodyInput.setText(note.text)
        binding.dateLabel.visibility = View.VISIBLE
        binding.dateLabel.text = DateUtils.format(note.createdAt)
        applyColor(note.color)
        applyFont(note.fontFamily)
        attachments = note.attachments.toMutableList()
        renderAttachments()
        undoStack.clear()
        undoStack.add(note.text)
    }

    private fun applyColor(color: String?) {
        val bg = if (color != null) Color.parseColor(color) else ContextCompat.getColor(this, R.color.dark_bg)
        binding.rootLayout.setBackgroundColor(bg)
    }

    private fun applyFont(fontKey: String?) {
        val typeface = FONT_OPTIONS.find { it.first == fontKey }?.second
            ?: Typeface.create("casual", Typeface.NORMAL)
        binding.bodyInput.typeface = typeface
    }

    // ---------- Deshacer / rehacer ----------

    private fun performUndo() {
        if (undoStack.size <= 1) return
        redoStack.add(undoStack.removeAt(undoStack.size - 1))
        val previous = undoStack.last()
        setBodyTextSilently(previous)
    }

    private fun performRedo() {
        if (redoStack.isEmpty()) return
        val next = redoStack.removeAt(redoStack.size - 1)
        undoStack.add(next)
        setBodyTextSilently(next)
    }

    private fun setBodyTextSilently(text: String) {
        suppressWatcher = true
        binding.bodyInput.setText(text)
        binding.bodyInput.setSelection(text.length)
        suppressWatcher = false
    }

    // ---------- Tipografía ----------

    private fun showFontMenu() {
        val popup = PopupMenu(this, binding.fontButton)
        popup.menu.add(0, 0, 0, getString(R.string.predeterminada))
        popup.menu.add(0, 1, 1, getString(R.string.sans_serif))
        popup.menu.add(0, 2, 2, getString(R.string.serif))
        popup.menu.add(0, 3, 3, getString(R.string.monoespaciada))
        popup.setOnMenuItemClickListener { item ->
            val key = when (item.itemId) {
                1 -> "sans"
                2 -> "serif"
                3 -> "monospace"
                else -> "predeterminada"
            }
            applyFont(key)
            currentNote?.let { NoteRepository.setFontFamily(this, it.id, key) }
            true
        }
        popup.show()
    }

    // ---------- Dictado por voz ----------

    private fun startVoiceRecognition() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO)
            != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this, arrayOf(Manifest.permission.RECORD_AUDIO), REQUEST_RECORD_AUDIO_PERMISSION
            )
            return
        }
        launchSpeechRecognizer()
    }

    private fun launchSpeechRecognizer() {
        val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
            putExtra(RecognizerIntent.EXTRA_LANGUAGE, Locale("es", "ES"))
            putExtra(RecognizerIntent.EXTRA_PROMPT, getString(R.string.di_algo))
        }
        try {
            startActivityForResult(intent, REQUEST_SPEECH)
        } catch (e: Exception) {
            Toast.makeText(this, R.string.dictar_voz, Toast.LENGTH_SHORT).show()
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_RECORD_AUDIO_PERMISSION &&
            grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED
        ) {
            launchSpeechRecognizer()
        }
    }

    private fun insertRecognizedText(text: String) {
        val current = binding.bodyInput.text
        val cursor = binding.bodyInput.selectionStart.coerceAtLeast(0)
        val prefix = if (current.isNotEmpty() && cursor > 0 && current[cursor - 1] != ' ' && current[cursor - 1] != '\n') " " else ""
        current.insert(cursor, "$prefix$text")
    }

    // ---------- Bloqueo ----------

    private fun requestUnlock(onSuccess: () -> Unit, onFail: () -> Unit) {
        val biometricManager = BiometricManager.from(this)
        val canUseBiometric = biometricManager.canAuthenticate(
            BiometricManager.Authenticators.BIOMETRIC_WEAK or BiometricManager.Authenticators.DEVICE_CREDENTIAL
        ) == BiometricManager.BIOMETRIC_SUCCESS

        if (canUseBiometric) {
            val executor = ContextCompat.getMainExecutor(this)
            val prompt = BiometricPrompt(this, executor, object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                    onSuccess()
                }
                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    onFail()
                }
                override fun onAuthenticationFailed() {}
            })
            val promptInfo = BiometricPrompt.PromptInfo.Builder()
                .setTitle(getString(R.string.nota_bloqueada))
                .setSubtitle(getString(R.string.desbloquear_nota))
                .setAllowedAuthenticators(
                    BiometricManager.Authenticators.BIOMETRIC_WEAK or BiometricManager.Authenticators.DEVICE_CREDENTIAL
                )
                .build()
            prompt.authenticate(promptInfo)
        } else if (PinLockManager.hasPin(this)) {
            PinDialogHelper.showEnterPinDialog(this, onCorrect = onSuccess, onCancel = onFail)
        } else {
            PinDialogHelper.showCreatePinDialog(this) { onSuccess() }
        }
    }

    // ---------- Menú de opciones (⋮) ----------

    private fun showOptionsMenu() {
        val note = currentNote ?: return
        val popup = PopupMenu(this, binding.menuButton)
        popup.menu.add(0, 0, 0, getString(if (note.pinned) R.string.desanclar else R.string.anclar))
            .setIcon(R.drawable.ic_pin)
        popup.menu.add(0, 1, 1, getString(if (note.locked) R.string.desbloquear else R.string.bloquear))
            .setIcon(R.drawable.ic_lock)
        popup.menu.add(0, 2, 2, getString(R.string.compartir)).setIcon(R.drawable.ic_share)
        popup.menu.add(0, 3, 3, getString(R.string.color_de_fondo)).setIcon(R.drawable.ic_palette)
        popup.menu.add(0, 4, 4, getString(R.string.eliminar_nota)).setIcon(R.drawable.ic_trash)
        MenuIconHelper.forceShowIcons(popup)
        popup.setOnMenuItemClickListener { item ->
            when (item.itemId) {
                0 -> togglePinned()
                1 -> toggleLocked()
                2 -> shareNote()
                3 -> showColorPicker()
                4 -> deleteNote()
            }
            true
        }
        popup.show()
    }

    private fun deleteNote() {
        val note = currentNote ?: return
        NoteRepository.deleteNote(this, note.id)
        finish()
    }

    private fun togglePinned() {
        val note = currentNote ?: return
        val updated = note.copy(pinned = !note.pinned)
        currentNote = updated
        NoteRepository.setPinned(this, note.id, updated.pinned)
    }

    private fun toggleLocked() {
        val note = currentNote ?: return
        if (!note.locked && !PinLockManager.hasPin(this)) {
            val biometricManager = BiometricManager.from(this)
            val canUseBiometric = biometricManager.canAuthenticate(
                BiometricManager.Authenticators.BIOMETRIC_WEAK
            ) == BiometricManager.BIOMETRIC_SUCCESS
            if (!canUseBiometric) {
                PinDialogHelper.showCreatePinDialog(this) {
                    applyLock(note, true)
                }
                return
            }
        }
        applyLock(note, !note.locked)
    }

    private fun applyLock(note: Note, locked: Boolean) {
        val updated = note.copy(locked = locked)
        currentNote = updated
        NoteRepository.setLocked(this, note.id, locked)
    }

    private fun shareNote() {
        val note = currentNote ?: return
        val shareText = if (note.title.isNotBlank()) "${note.title}\n\n${note.text}" else note.text
        val intent = Intent(Intent.ACTION_SEND).apply {
            type = "text/plain"
            putExtra(Intent.EXTRA_TEXT, shareText)
        }
        startActivity(Intent.createChooser(intent, getString(R.string.compartir)))
    }

    private fun showColorPicker() {
        val note = currentNote ?: return
        val row = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            setPadding(32, 32, 32, 32)
        }
        for (colorHex in NOTE_COLORS) {
            val swatch = View(this)
            val size = 140
            val params = LinearLayout.LayoutParams(size, size).apply { setMargins(12, 0, 12, 0) }
            swatch.layoutParams = params
            val drawable = android.graphics.drawable.GradientDrawable()
            drawable.shape = android.graphics.drawable.GradientDrawable.OVAL
            drawable.setColor(
                if (colorHex != null) Color.parseColor(colorHex) else ContextCompat.getColor(this, R.color.dark_surface)
            )
            drawable.setStroke(3, ContextCompat.getColor(this, R.color.dark_text_secondary))
            swatch.background = drawable
            row.addView(swatch)

            swatch.setOnClickListener {
                val updated = note.copy(color = colorHex)
                currentNote = updated
                NoteRepository.setColor(this, note.id, colorHex)
                applyColor(colorHex)
            }
        }

        val dialog = AlertDialog.Builder(this)
            .setTitle(R.string.color_de_fondo)
            .setView(row)
            .setPositiveButton(android.R.string.ok, null)
            .show()
        dialog.getButton(AlertDialog.BUTTON_POSITIVE)
            ?.setTextColor(ContextCompat.getColor(this, R.color.accent_yellow))
    }

    // ---------- Adjuntos (imágenes, dibujos, tablas) ----------

    private fun renderAttachments() {
        binding.attachmentsContainer.removeAllViews()
        binding.attachmentsScroll.visibility = if (attachments.isEmpty()) View.GONE else View.VISIBLE

        for (path in attachments) {
            val frame = FrameLayout(this)
            val frameParams = LinearLayout.LayoutParams(220, 220).apply { setMargins(0, 0, 16, 0) }
            frame.layoutParams = frameParams

            val imageView = ImageView(this)
            imageView.layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT
            )
            imageView.scaleType = ImageView.ScaleType.CENTER_CROP
            val bitmap = android.graphics.BitmapFactory.decodeFile(path)
            if (bitmap != null) imageView.setImageBitmap(bitmap)
            frame.addView(imageView)

            val deleteButton = ImageView(this)
            val deleteSize = 48
            val deleteParams = FrameLayout.LayoutParams(deleteSize, deleteSize).apply {
                gravity = Gravity.TOP or Gravity.END
                setMargins(0, 6, 6, 0)
            }
            deleteButton.layoutParams = deleteParams
            deleteButton.setImageResource(R.drawable.ic_close_circle)
            deleteButton.contentDescription = getString(R.string.eliminar_adjunto)
            deleteButton.setOnClickListener {
                attachments.remove(path)
                currentNote?.let { NoteRepository.removeAttachment(this, it.id, path) }
                renderAttachments()
            }
            frame.addView(deleteButton)

            binding.attachmentsContainer.addView(frame)
        }
    }

    private fun addAttachment(path: String) {
        attachments.add(path)
        currentNote?.let {
            NoteRepository.addAttachment(this, it.id, path)
        } ?: run {
            // Nota nueva todavía sin guardar: se persistirá al pulsar Guardar
        }
        renderAttachments()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode != RESULT_OK || data == null) return

        when (requestCode) {
            REQUEST_DRAWING -> {
                val path = data.getStringExtra(DrawingActivity.EXTRA_RESULT_PATH)
                if (path != null) addAttachment(path)
            }
            REQUEST_IMAGE_PICK -> {
                val uri = data.data ?: return
                try {
                    val dir = File(filesDir, "images").apply { mkdirs() }
                    val outFile = File(dir, "${UUID.randomUUID()}.jpg")
                    contentResolver.openInputStream(uri)?.use { input ->
                        FileOutputStream(outFile).use { output -> input.copyTo(output) }
                    }
                    addAttachment(outFile.absolutePath)
                } catch (e: Exception) {
                    // si falla la copia, simplemente no se añade el adjunto
                }
            }
            REQUEST_SPEECH -> {
                val results = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS)
                val recognized = results?.firstOrNull()
                if (!recognized.isNullOrBlank()) {
                    insertRecognizedText(recognized)
                }
            }
        }
    }

    // ---------- Tablas ----------

    private fun showTableSizeDialog() {
        val container = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(48, 24, 48, 0)
        }
        val rowsInput = EditText(this).apply {
            hint = getString(R.string.filas)
            inputType = android.text.InputType.TYPE_CLASS_NUMBER
            setText("3")
        }
        val colsInput = EditText(this).apply {
            hint = getString(R.string.columnas)
            inputType = android.text.InputType.TYPE_CLASS_NUMBER
            setText("3")
        }
        container.addView(rowsInput)
        container.addView(colsInput)

        AlertDialog.Builder(this)
            .setTitle(R.string.crear_tabla)
            .setView(container)
            .setPositiveButton(android.R.string.ok) { _, _ ->
                val rows = (rowsInput.text.toString().toIntOrNull() ?: 3).coerceIn(1, 8)
                val cols = (colsInput.text.toString().toIntOrNull() ?: 3).coerceIn(1, 8)
                showTableEditorDialog(rows, cols)
            }
            .setNegativeButton(android.R.string.cancel, null)
            .show()
    }

    private fun showTableEditorDialog(rows: Int, cols: Int) {
        val table = TableLayout(this).apply {
            setPadding(24, 24, 24, 24)
        }
        val cellInputs = Array(rows) { arrayOfNulls<EditText>(cols) }

        for (r in 0 until rows) {
            val row = TableRow(this)
            for (c in 0 until cols) {
                val cell = EditText(this)
                cell.layoutParams = TableRow.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f)
                cell.setPadding(12, 12, 12, 12)
                cell.textSize = 13f
                row.addView(cell)
                cellInputs[r][c] = cell
            }
            table.addView(row)
        }

        val scroll = android.widget.ScrollView(this)
        scroll.addView(table)

        AlertDialog.Builder(this)
            .setTitle(R.string.crear_tabla)
            .setView(scroll)
            .setPositiveButton(android.R.string.ok) { _, _ ->
                val texts = Array(rows) { r -> Array(cols) { c -> cellInputs[r][c]?.text?.toString().orEmpty() } }
                val bitmap = renderTableBitmap(rows, cols, texts)
                val dir = File(filesDir, "tables").apply { mkdirs() }
                val file = File(dir, "${UUID.randomUUID()}.png")
                FileOutputStream(file).use { out -> bitmap.compress(Bitmap.CompressFormat.PNG, 100, out) }
                addAttachment(file.absolutePath)
            }
            .setNegativeButton(android.R.string.cancel, null)
            .show()
    }

    private fun renderTableBitmap(rows: Int, cols: Int, texts: Array<Array<String>>): Bitmap {
        val cellWidth = 180
        val cellHeight = 90
        val width = cellWidth * cols
        val height = cellHeight * rows
        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        canvas.drawColor(Color.WHITE)

        val linePaint = Paint().apply {
            color = Color.parseColor("#5C4322")
            strokeWidth = 3f
        }
        val textPaint = Paint().apply {
            color = Color.parseColor("#5C4322")
            textSize = 26f
            isAntiAlias = true
        }

        for (r in 0..rows) {
            canvas.drawLine(0f, (r * cellHeight).toFloat(), width.toFloat(), (r * cellHeight).toFloat(), linePaint)
        }
        for (c in 0..cols) {
            canvas.drawLine((c * cellWidth).toFloat(), 0f, (c * cellWidth).toFloat(), height.toFloat(), linePaint)
        }
        for (r in 0 until rows) {
            for (c in 0 until cols) {
                val text = texts[r][c]
                canvas.drawText(
                    text,
                    (c * cellWidth + 12).toFloat(),
                    (r * cellHeight + cellHeight / 2 + 8).toFloat(),
                    textPaint
                )
            }
        }
        return bitmap
    }

    // ---------- Guardar ----------

    private fun saveAndFinish() {
        val title = binding.titleInput.text.toString().trim()
        val body = binding.bodyInput.text.toString().trim()

        if (title.isEmpty() && body.isEmpty() && attachments.isEmpty()) {
            finish()
            return
        }

        val existing = currentNote
        if (existing != null) {
            NoteRepository.updateNote(this, existing.copy(title = title, text = body, attachments = attachments))
        } else {
            NoteRepository.addNote(this, title, body)
            // Si se añadieron adjuntos antes de guardar por primera vez, los enlazamos ahora
            if (attachments.isNotEmpty()) {
                val created = NoteRepository.getNotes(this).firstOrNull { it.title == title && it.text == body }
                created?.let { note ->
                    NoteRepository.updateNote(this, note.copy(attachments = attachments))
                }
            }
        }
        finish()
    }
}
