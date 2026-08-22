#!/bin/bash
set -e

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/Note.kt << 'ZZEOF'
package com.santos.tareas

data class Note(
    val id: Long,
    var title: String = "",
    var text: String,
    var deleted: Boolean = false,
    var createdAt: Long = System.currentTimeMillis(),
    var pinned: Boolean = false,
    var locked: Boolean = false,
    var color: String? = null,
    var fontFamily: String? = null,
    var attachments: MutableList<String> = mutableListOf()
)
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteRepository.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/**
 * Almacena las notas en SharedPreferences como JSON. "Eliminar" mueve la nota
 * a la papelera en vez de borrarla directamente.
 */
object NoteRepository {

    private const val PREFS = "notas_prefs"
    private const val KEY_NOTES = "notes_json"
    private const val KEY_NEXT_ID = "next_id"

    private fun getAllRaw(context: Context): MutableList<Note> {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val json = prefs.getString(KEY_NOTES, null)
        if (json == null) {
            val seed = mutableListOf(
                Note(id = nextId(context), title = "Bienvenido a Notas", text = ""),
                Note(id = nextId(context), title = "", text = "Toca + para crear una nota nueva")
            )
            saveNotes(context, seed)
            return seed
        }
        val array = JSONArray(json)
        val list = mutableListOf<Note>()
        for (i in 0 until array.length()) {
            val o = array.getJSONObject(i)
            val attachments = mutableListOf<String>()
            if (o.has("attachments")) {
                val arr = o.getJSONArray("attachments")
                for (j in 0 until arr.length()) attachments.add(arr.getString(j))
            }
            list.add(
                Note(
                    id = o.getLong("id"),
                    title = if (o.has("title")) o.getString("title") else "",
                    text = o.getString("text"),
                    deleted = if (o.has("deleted")) o.getBoolean("deleted") else false,
                    createdAt = if (o.has("createdAt")) o.getLong("createdAt") else 0L,
                    pinned = if (o.has("pinned")) o.getBoolean("pinned") else false,
                    locked = if (o.has("locked")) o.getBoolean("locked") else false,
                    color = if (o.has("color") && !o.isNull("color")) o.getString("color") else null,
                    fontFamily = if (o.has("fontFamily") && !o.isNull("fontFamily")) o.getString("fontFamily") else null,
                    attachments = attachments
                )
            )
        }
        return list
    }

    /** Notas activas (no eliminadas), ancladas primero. */
    fun getNotes(context: Context): MutableList<Note> =
        getAllRaw(context).filter { !it.deleted }
            .sortedByDescending { it.pinned }
            .toMutableList()

    /** Notas en la papelera. */
    fun getDeletedNotes(context: Context): MutableList<Note> =
        getAllRaw(context).filter { it.deleted }.toMutableList()

    private fun saveNotes(context: Context, notes: List<Note>) {
        val array = JSONArray()
        for (n in notes) {
            val o = JSONObject()
            o.put("id", n.id)
            o.put("title", n.title)
            o.put("text", n.text)
            o.put("deleted", n.deleted)
            o.put("createdAt", n.createdAt)
            o.put("pinned", n.pinned)
            o.put("locked", n.locked)
            o.put("color", n.color)
            o.put("fontFamily", n.fontFamily)
            val attArray = JSONArray()
            n.attachments.forEach { attArray.put(it) }
            o.put("attachments", attArray)
            array.put(o)
        }
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .edit()
            .putString(KEY_NOTES, array.toString())
            .apply()
    }

    private fun nextId(context: Context): Long {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val id = prefs.getLong(KEY_NEXT_ID, 1L)
        prefs.edit().putLong(KEY_NEXT_ID, id + 1).apply()
        return id
    }

    fun addNote(context: Context, title: String, text: String): Long {
        val notes = getAllRaw(context)
        val id = nextId(context)
        notes.add(0, Note(id = id, title = title, text = text))
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
        return id
    }

    fun updateNote(context: Context, note: Note) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == note.id }
        if (idx >= 0) {
            notes[idx] = note
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun deleteNote(context: Context, id: Long) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(deleted = true)
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun restoreNote(context: Context, id: Long) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(deleted = false)
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun permanentlyDeleteNote(context: Context, id: Long) {
        val notes = getAllRaw(context)
        notes.removeAll { it.id == id }
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
    }

    fun emptyTrash(context: Context) {
        val notes = getAllRaw(context)
        notes.removeAll { it.deleted }
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
    }

    fun setPinned(context: Context, id: Long, pinned: Boolean) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(pinned = pinned)
            saveNotes(context, notes)
        }
    }

    fun setLocked(context: Context, id: Long, locked: Boolean) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(locked = locked)
            saveNotes(context, notes)
        }
    }

    fun setColor(context: Context, id: Long, color: String?) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(color = color)
            saveNotes(context, notes)
        }
    }

    fun setFontFamily(context: Context, id: Long, fontFamily: String?) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(fontFamily = fontFamily)
            saveNotes(context, notes)
        }
    }

    fun addAttachment(context: Context, id: Long, path: String) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            val updated = notes[idx].attachments.toMutableList().apply { add(path) }
            notes[idx] = notes[idx].copy(attachments = updated)
            saveNotes(context, notes)
        }
    }

    fun removeAttachment(context: Context, id: Long, path: String) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            val updated = notes[idx].attachments.toMutableList().apply { remove(path) }
            notes[idx] = notes[idx].copy(attachments = updated)
            saveNotes(context, notes)
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteAdapter.kt << 'ZZEOF'
package com.santos.tareas

import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.RecyclerView
import com.santos.tareas.databinding.ItemNoteRowBinding

class NoteAdapter(
    private val onClick: (Note) -> Unit,
    private val onDelete: (Note) -> Unit
) : RecyclerView.Adapter<NoteAdapter.NoteViewHolder>() {

    private var items: List<Note> = emptyList()
    var flatStyle: Boolean = false

    fun submitList(newItems: List<Note>) {
        items = newItems
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): NoteViewHolder {
        val binding = ItemNoteRowBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return NoteViewHolder(binding)
    }

    override fun onBindViewHolder(holder: NoteViewHolder, position: Int) {
        holder.bind(items[position])
    }

    override fun getItemCount(): Int = items.size

    inner class NoteViewHolder(private val binding: ItemNoteRowBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(note: Note) {
            val context = binding.root.context

            if (flatStyle) {
                binding.root.setBackgroundResource(R.drawable.dark_row_flat_background)
            } else {
                val bg = ContextCompat.getDrawable(context, R.drawable.dark_row_background)
                    ?.mutate() as GradientDrawable
                bg.setColor(
                    if (note.color != null) Color.parseColor(note.color)
                    else ContextCompat.getColor(context, R.color.dark_surface)
                )
                binding.root.background = bg
            }

            binding.pinIcon.visibility = if (note.pinned) View.VISIBLE else View.GONE
            binding.lockIcon.visibility = if (note.locked) View.VISIBLE else View.GONE

            if (note.locked) {
                binding.noteTitle.visibility = View.VISIBLE
                binding.noteTitle.text = context.getString(R.string.nota_bloqueada)
                binding.text.text = ""
            } else if (note.title.isNotBlank()) {
                binding.noteTitle.visibility = View.VISIBLE
                binding.noteTitle.text = note.title
                binding.text.text = note.text
            } else {
                binding.noteTitle.visibility = View.GONE
                binding.text.text = note.text
            }

            binding.noteDate.text = DateUtils.format(note.createdAt)
            binding.root.setOnClickListener { onClick(note) }
            binding.deleteButton.setOnClickListener { onDelete(note) }
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteRemoteViewsFactory.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import android.widget.RemoteViewsService.RemoteViewsFactory

class NoteRemoteViewsFactory(private val context: Context) : RemoteViewsFactory {

    private var notes: List<Note> = emptyList()

    override fun onCreate() {
        notes = NoteRepository.getNotes(context)
    }

    override fun onDataSetChanged() {
        notes = NoteRepository.getNotes(context)
    }

    override fun onDestroy() {
        notes = emptyList()
    }

    override fun getCount(): Int = notes.size

    override fun getViewAt(position: Int): RemoteViews {
        val note = notes[position]
        val views = RemoteViews(context.packageName, R.layout.widget_note_item)
        val display = if (note.title.isNotBlank()) note.title else note.text
        views.setTextViewText(R.id.note_item_text, display)

        val fillInIntent = Intent().apply {
            putExtra(AddEditNoteActivity.EXTRA_NOTE_ID, note.id)
        }
        views.setOnClickFillInIntent(R.id.note_item_row, fillInIntent)

        return views
    }

    override fun getLoadingView(): RemoteViews? = null
    override fun getViewTypeCount(): Int = 1
    override fun getItemId(position: Int): Long = notes[position].id
    override fun hasStableIds(): Boolean = true
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/AddEditNoteActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.app.AlertDialog
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Typeface
import android.os.Bundle
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
import androidx.appcompat.app.AppCompatActivity
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import com.santos.tareas.databinding.ActivityAddEditNoteBinding
import java.io.File
import java.io.FileOutputStream
import java.util.UUID

class AddEditNoteActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_NOTE_ID = "extra_note_id"
        private const val REQUEST_IMAGE_PICK = 100
        private const val REQUEST_DRAWING = 101

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
        MenuIconHelper.forceShowIcons(popup)
        popup.setOnMenuItemClickListener { item ->
            when (item.itemId) {
                0 -> togglePinned()
                1 -> toggleLocked()
                2 -> shareNote()
                3 -> showColorPicker()
            }
            true
        }
        popup.show()
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
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/item_note_row.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:gravity="center_vertical"
    android:background="@drawable/dark_row_background"
    android:layout_marginBottom="8dp"
    android:padding="14dp">

    <LinearLayout
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:orientation="vertical">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical">

            <ImageView
                android:id="@+id/pinIcon"
                android:layout_width="14dp"
                android:layout_height="14dp"
                android:layout_marginEnd="6dp"
                android:src="@drawable/ic_pin"
                android:visibility="gone" />

            <TextView
                android:id="@+id/noteTitle"
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_weight="1"
                android:textColor="@color/white"
                android:textSize="16sp"
                android:textStyle="bold"
                android:maxLines="1"
                android:ellipsize="end"
                android:visibility="gone" />

            <ImageView
                android:id="@+id/lockIcon"
                android:layout_width="14dp"
                android:layout_height="14dp"
                android:layout_marginStart="6dp"
                android:src="@drawable/ic_lock"
                android:visibility="gone" />

        </LinearLayout>

        <TextView
            android:id="@+id/text"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="2dp"
            android:maxLines="3"
            android:ellipsize="end"
            android:textColor="@color/dark_text_secondary"
            android:textSize="14sp" />

        <TextView
            android:id="@+id/noteDate"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="6dp"
            android:textColor="@color/dark_text_secondary"
            android:textSize="11sp"
            android:alpha="0.7" />

    </LinearLayout>

    <ImageView
        android:id="@+id/deleteButton"
        android:layout_width="22dp"
        android:layout_height="22dp"
        android:layout_marginStart="10dp"
        android:padding="1dp"
        android:src="@drawable/ic_trash"
        android:contentDescription="@string/eliminar_nota" />

</LinearLayout>
ZZEOF

echo "Modelo y repositorio de notas sincronizados. Compilando..."
./gradlew assembleDebug