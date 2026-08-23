#!/bin/bash
set -e

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/formatting_toolbar.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/formattingPanel"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical"
    android:background="@color/dark_surface"
    android:padding="10dp"
    android:visibility="gone">

    <!-- Fila 1: encabezados -->
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:layout_marginBottom="8dp">

        <TextView android:id="@+id/btnH1" style="@style/FormatButton" android:layout_weight="1" android:text="H1" android:textSize="16sp" />
        <TextView android:id="@+id/btnH2" style="@style/FormatButton" android:layout_weight="1" android:text="H2" android:textSize="15sp" />
        <TextView android:id="@+id/btnH3" style="@style/FormatButton" android:layout_weight="1" android:text="H3" android:textSize="14sp" />
        <TextView android:id="@+id/btnH4" style="@style/FormatButton" android:layout_weight="1" android:text="H4" android:textSize="13sp" />
        <TextView android:id="@+id/btnBody" style="@style/FormatButton" android:layout_weight="1.3" android:text="@string/cuerpo" android:textSize="13sp" />
    </LinearLayout>

    <!-- Fila 2: negrita, cursiva, subrayado, tachado, sangría -->
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:layout_marginBottom="8dp">

        <TextView android:id="@+id/btnBold" style="@style/FormatButton" android:layout_weight="1" android:text="B" android:textStyle="bold" android:textSize="17sp" />
        <TextView android:id="@+id/btnItalic" style="@style/FormatButton" android:layout_weight="1" android:text="I" android:textStyle="italic" android:textSize="17sp" />
        <TextView android:id="@+id/btnUnderline" style="@style/FormatButton" android:layout_weight="1" android:text="U" android:textSize="17sp" />
        <TextView android:id="@+id/btnStrike" style="@style/FormatButton" android:layout_weight="1" android:text="S" android:textSize="17sp" />
        <ImageView android:id="@+id/btnIndentDec" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_indent_decrease" />
        <ImageView android:id="@+id/btnIndentInc" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_indent_increase" />
    </LinearLayout>

    <!-- Fila 3: listas y alineación -->
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:layout_marginBottom="8dp">

        <ImageView android:id="@+id/btnListNumbered" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_list_numbered" />
        <ImageView android:id="@+id/btnListBullet" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_list_bullet" />
        <ImageView android:id="@+id/btnChecklist" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_checklist" />
        <ImageView android:id="@+id/btnAlignLeft" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_align_left" />
        <ImageView android:id="@+id/btnAlignCenter" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_align_center" />
        <ImageView android:id="@+id/btnAlignRight" style="@style/FormatIconButton" android:layout_weight="1" android:src="@drawable/ic_align_right" />
    </LinearLayout>


</LinearLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_add_edit_note.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/rootLayout"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/dark_bg">

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:padding="16dp">

        <ImageView
            android:id="@+id/backButton"
            android:layout_width="44dp"
            android:layout_height="44dp"
            android:layout_alignParentStart="true"
            android:background="@drawable/circle_button_dark"
            android:padding="11dp"
            android:src="@drawable/ic_back" />

        <ImageView
            android:id="@+id/menuButton"
            android:layout_width="44dp"
            android:layout_height="44dp"
            android:layout_alignParentEnd="true"
            android:background="@drawable/circle_button_dark"
            android:padding="11dp"
            android:src="@drawable/ic_more_vert" />

    </RelativeLayout>

    <ScrollView
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="vertical"
            android:padding="20dp">

            <EditText
                android:id="@+id/titleInput"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:hint="@string/titulo"
                android:textColor="@color/white"
                android:textColorHint="@color/dark_text_secondary"
                android:textSize="24sp"
                android:textStyle="bold"
                android:background="@android:color/transparent"
                android:fontFamily="casual" />

            <TextView
                android:id="@+id/dateLabel"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginTop="4dp"
                android:textColor="@color/dark_text_secondary"
                android:textSize="12sp"
                android:visibility="gone" />

            <EditText
                android:id="@+id/bodyInput"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:layout_marginTop="12dp"
                android:hint="@string/anota_algo"
                android:textColor="@color/white"
                android:textColorHint="@color/dark_text_secondary"
                android:textSize="16sp"
                android:minLines="8"
                android:gravity="top"
                android:background="@android:color/transparent" />

            <HorizontalScrollView
                android:id="@+id/attachmentsScroll"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:layout_marginTop="12dp"
                android:visibility="gone"
                android:scrollbars="none">

                <LinearLayout
                    android:id="@+id/attachmentsContainer"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:orientation="horizontal" />

            </HorizontalScrollView>

        </LinearLayout>

    </ScrollView>

    <include layout="@layout/formatting_toolbar" android:id="@+id/formattingPanelInclude" />

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="center"
        android:paddingVertical="10dp"
        android:background="@color/dark_surface">

        <ImageView
            android:id="@+id/undoButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:padding="9dp"
            android:src="@drawable/ic_undo"
            android:contentDescription="@string/deshacer" />

        <ImageView
            android:id="@+id/redoButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_redo"
            android:contentDescription="@string/rehacer" />

        <View
            android:layout_width="0dp"
            android:layout_height="1dp"
            android:layout_weight="1" />

        <TextView
            android:id="@+id/formatToggleButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:gravity="center"
            android:text="@string/aa_boton"
            android:textColor="@color/white"
            android:textStyle="bold"
            android:contentDescription="@string/formato_texto" />

        <ImageView
            android:id="@+id/fontButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_font"
            android:contentDescription="@string/tipografia" />

        <ImageView
            android:id="@+id/textColorButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_text_color"
            android:contentDescription="@string/color_de_texto" />

        <ImageView
            android:id="@+id/drawButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_draw"
            android:contentDescription="@string/dibujar" />

        <ImageView
            android:id="@+id/imageButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_image"
            android:contentDescription="@string/insertar_imagen" />

        <ImageView
            android:id="@+id/tableButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_table"
            android:contentDescription="@string/insertar_tabla" />

        <ImageView
            android:id="@+id/micButton"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:layout_marginStart="4dp"
            android:padding="9dp"
            android:src="@drawable/ic_mic"
            android:contentDescription="@string/dictar_voz" />

    </LinearLayout>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="end"
        android:padding="16dp">

        <TextView
            android:id="@+id/cancelButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/cancelar"
            android:textColor="@color/dark_text_secondary"
            android:padding="10dp" />

        <TextView
            android:id="@+id/saveButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/guardar"
            android:textColor="@color/accent_yellow"
            android:textStyle="bold"
            android:padding="10dp"
            android:layout_marginStart="8dp" />

    </LinearLayout>

</LinearLayout>
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/TextFormatter.kt << 'ZZEOF'
package com.santos.tareas

import android.graphics.Typeface
import android.text.Layout
import android.text.Spanned
import android.text.style.AlignmentSpan
import android.text.style.StrikethroughSpan
import android.text.style.StyleSpan
import android.text.style.UnderlineSpan
import android.text.style.ForegroundColorSpan
import android.widget.EditText

/**
 * Aplica formato de texto enriquecido (negrita, cursiva, subrayado, tachado,
 * encabezados, listas, alineación, sangría, color) directamente sobre el
 * Editable de un EditText usando spans nativos de Android.
 */
object TextFormatter {

    private fun selectionRange(editText: EditText): Pair<Int, Int> {
        val start = editText.selectionStart.coerceAtLeast(0)
        val end = editText.selectionEnd.coerceAtLeast(0)
        return if (start <= end) start to end else end to start
    }

    /** Si no hay selección, usa la línea completa donde está el cursor. */
    private fun effectiveRange(editText: EditText): Pair<Int, Int> {
        val (start, end) = selectionRange(editText)
        if (start != end) return start to end
        val text = editText.text
        var lineStart = start
        while (lineStart > 0 && text[lineStart - 1] != '\n') lineStart--
        var lineEnd = start
        while (lineEnd < text.length && text[lineEnd] != '\n') lineEnd++
        return lineStart to lineEnd
    }

    private fun lineRanges(editText: EditText): List<Pair<Int, Int>> {
        val (selStart, selEnd) = effectiveRange(editText)
        val text = editText.text
        val ranges = mutableListOf<Pair<Int, Int>>()
        var pos = selStart
        while (pos <= selEnd) {
            var lineStart = pos
            while (lineStart > 0 && text[lineStart - 1] != '\n') lineStart--
            var lineEnd = pos
            while (lineEnd < text.length && text[lineEnd] != '\n') lineEnd++
            ranges.add(lineStart to lineEnd)
            pos = lineEnd + 1
        }
        return ranges
    }

    fun toggleBold(editText: EditText) = toggleStyle(editText, Typeface.BOLD)
    fun toggleItalic(editText: EditText) = toggleStyle(editText, Typeface.ITALIC)

    private fun toggleStyle(editText: EditText, style: Int) {
        val (start, end) = effectiveRange(editText)
        if (start == end) return
        val editable = editText.text
        val spans = editable.getSpans(start, end, StyleSpan::class.java).filter { it.style == style }
        val covered = spans.any { editable.getSpanStart(it) <= start && editable.getSpanEnd(it) >= end }
        if (covered) {
            spans.forEach { editable.removeSpan(it) }
        } else {
            editable.setSpan(StyleSpan(style), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        }
    }

    fun toggleUnderline(editText: EditText) {
        val (start, end) = effectiveRange(editText)
        if (start == end) return
        val editable = editText.text
        val spans = editable.getSpans(start, end, UnderlineSpan::class.java)
        val covered = spans.any { editable.getSpanStart(it) <= start && editable.getSpanEnd(it) >= end }
        if (covered) {
            spans.forEach { editable.removeSpan(it) }
        } else {
            editable.setSpan(UnderlineSpan(), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        }
    }

    fun toggleStrikethrough(editText: EditText) {
        val (start, end) = effectiveRange(editText)
        if (start == end) return
        val editable = editText.text
        val spans = editable.getSpans(start, end, StrikethroughSpan::class.java)
        val covered = spans.any { editable.getSpanStart(it) <= start && editable.getSpanEnd(it) >= end }
        if (covered) {
            spans.forEach { editable.removeSpan(it) }
        } else {
            editable.setSpan(StrikethroughSpan(), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        }
    }

    fun applyHeading(editText: EditText, scale: Float?) {
        val (start, end) = effectiveRange(editText)
        if (start == end) return
        val editable = editText.text
        editable.getSpans(start, end, HeadingSpan::class.java).forEach { editable.removeSpan(it) }
        if (scale != null) {
            editable.setSpan(HeadingSpan(scale), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        }
    }

    fun applyAlignment(editText: EditText, alignment: Layout.Alignment) {
        val (start, end) = effectiveRange(editText)
        val editable = editText.text
        editable.getSpans(start, end, AlignmentSpan::class.java).forEach { editable.removeSpan(it) }
        editable.setSpan(AlignmentSpan.Standard(alignment), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
    }

    fun applyTextColor(editText: EditText, color: Int) {
        val (start, end) = effectiveRange(editText)
        if (start == end) return
        val editable = editText.text
        editable.getSpans(start, end, ForegroundColorSpan::class.java).forEach { editable.removeSpan(it) }
        editable.setSpan(ForegroundColorSpan(color), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
    }

    fun toggleLinePrefix(editText: EditText, prefix: String, numbered: Boolean = false) {
        val editable = editText.text
        val ranges = lineRanges(editText)

        val alreadyAllPrefixed = if (numbered) {
            ranges.all { (s, _) ->
                Regex("^\\d+\\. ").containsMatchIn(editable.substring(s, minOf(s + 6, editable.length)))
            }
        } else {
            ranges.all { (s, _) ->
                editable.substring(s, minOf(s + prefix.length, editable.length)) == prefix
            }
        }

        // Aplicamos de atrás hacia adelante para no desajustar los índices
        var counter = ranges.size
        for ((s, _) in ranges.reversed()) {
            if (alreadyAllPrefixed) {
                if (numbered) {
                    val match = Regex("^\\d+\\. ").find(editable.substring(s, minOf(s + 6, editable.length)))
                    if (match != null) editable.delete(s, s + match.value.length)
                } else {
                    val end = minOf(s + prefix.length, editable.length)
                    if (editable.substring(s, end) == prefix) editable.delete(s, end)
                }
            } else {
                val insertText = if (numbered) "$counter. " else prefix
                editable.insert(s, insertText)
            }
            counter--
        }
    }

    fun increaseIndent(editText: EditText) {
        val editable = editText.text
        for ((s, _) in lineRanges(editText).reversed()) {
            editable.insert(s, "    ")
        }
    }

    fun decreaseIndent(editText: EditText) {
        val editable = editText.text
        for ((s, _) in lineRanges(editText).reversed()) {
            val end = minOf(s + 4, editable.length)
            if (editable.substring(s, end) == "    ") {
                editable.delete(s, end)
            } else if (s < editable.length && editable[s] == '\t') {
                editable.delete(s, s + 1)
            }
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/AddEditNoteActivity.kt << 'ZZEOF'
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
        binding.textColorButton.setOnClickListener { showTextColorPicker() }
        binding.drawButton.setOnClickListener {
            startActivityForResult(Intent(this, DrawingActivity::class.java), REQUEST_DRAWING)
        }
        binding.imageButton.setOnClickListener {
            val intent = Intent(Intent.ACTION_GET_CONTENT).apply { type = "image/*" }
            startActivityForResult(intent, REQUEST_IMAGE_PICK)
        }
        binding.tableButton.setOnClickListener { showTableSizeDialog() }
        binding.micButton.setOnClickListener { startVoiceRecognition() }

        setupFormattingToolbar()

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
        binding.bodyInput.setText(HtmlUtils.fromHtml(note.text))
        binding.dateLabel.visibility = View.VISIBLE
        binding.dateLabel.text = DateUtils.format(note.createdAt)
        applyColor(note.color)
        applyFont(note.fontFamily)
        attachments = note.attachments.toMutableList()
        renderAttachments()
        undoStack.clear()
        undoStack.add(binding.bodyInput.text.toString())
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

    // ---------- Barra de formato de texto ----------

    private fun setupFormattingToolbar() {
        val panel = binding.formattingPanelInclude
        binding.formatToggleButton.setOnClickListener {
            panel.formattingPanel.visibility =
                if (panel.formattingPanel.visibility == View.VISIBLE) View.GONE else View.VISIBLE
        }

        panel.btnH1.setOnClickListener { TextFormatter.applyHeading(binding.bodyInput, 1.8f) }
        panel.btnH2.setOnClickListener { TextFormatter.applyHeading(binding.bodyInput, 1.5f) }
        panel.btnH3.setOnClickListener { TextFormatter.applyHeading(binding.bodyInput, 1.3f) }
        panel.btnH4.setOnClickListener { TextFormatter.applyHeading(binding.bodyInput, 1.15f) }
        panel.btnBody.setOnClickListener { TextFormatter.applyHeading(binding.bodyInput, null) }

        panel.btnBold.setOnClickListener { TextFormatter.toggleBold(binding.bodyInput) }
        panel.btnItalic.setOnClickListener { TextFormatter.toggleItalic(binding.bodyInput) }
        panel.btnUnderline.setOnClickListener { TextFormatter.toggleUnderline(binding.bodyInput) }
        panel.btnStrike.setOnClickListener { TextFormatter.toggleStrikethrough(binding.bodyInput) }
        panel.btnIndentInc.setOnClickListener { TextFormatter.increaseIndent(binding.bodyInput) }
        panel.btnIndentDec.setOnClickListener { TextFormatter.decreaseIndent(binding.bodyInput) }

        panel.btnListNumbered.setOnClickListener {
            TextFormatter.toggleLinePrefix(binding.bodyInput, "", numbered = true)
        }
        panel.btnListBullet.setOnClickListener {
            TextFormatter.toggleLinePrefix(binding.bodyInput, "• ")
        }
        panel.btnChecklist.setOnClickListener {
            TextFormatter.toggleLinePrefix(binding.bodyInput, "☐ ")
        }
        panel.btnAlignLeft.setOnClickListener {
            TextFormatter.applyAlignment(binding.bodyInput, android.text.Layout.Alignment.ALIGN_NORMAL)
        }
        panel.btnAlignCenter.setOnClickListener {
            TextFormatter.applyAlignment(binding.bodyInput, android.text.Layout.Alignment.ALIGN_CENTER)
        }
        panel.btnAlignRight.setOnClickListener {
            TextFormatter.applyAlignment(binding.bodyInput, android.text.Layout.Alignment.ALIGN_OPPOSITE)
        }
    }

    private fun showTextColorPicker() {
        val colors = listOf(
            "#FFFFFF", "#F5A623", "#E5484D", "#4A9EFF", "#4CC38A", "#B784E0"
        )
        val row = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            setPadding(32, 32, 32, 32)
        }
        for (colorHex in colors) {
            val swatch = View(this)
            val size = 120
            val params = LinearLayout.LayoutParams(size, size).apply { setMargins(10, 0, 10, 0) }
            swatch.layoutParams = params
            val drawable = android.graphics.drawable.GradientDrawable()
            drawable.shape = android.graphics.drawable.GradientDrawable.OVAL
            drawable.setColor(Color.parseColor(colorHex))
            drawable.setStroke(2, ContextCompat.getColor(this, R.color.dark_text_secondary))
            swatch.background = drawable
            row.addView(swatch)
            swatch.setOnClickListener {
                TextFormatter.applyTextColor(binding.bodyInput, Color.parseColor(colorHex))
            }
        }
        AlertDialog.Builder(this)
            .setTitle(R.string.color_de_texto)
            .setView(row)
            .setPositiveButton(android.R.string.ok, null)
            .show()
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
        val plainText = HtmlUtils.toPlainText(note.text)
        val shareText = if (note.title.isNotBlank()) "${note.title}\n\n$plainText" else plainText
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
        val bodyPlain = binding.bodyInput.text.toString().trim()
        val bodyHtml = HtmlUtils.toHtml(binding.bodyInput.text)

        if (title.isEmpty() && bodyPlain.isEmpty() && attachments.isEmpty()) {
            finish()
            return
        }

        val existing = currentNote
        if (existing != null) {
            NoteRepository.updateNote(this, existing.copy(title = title, text = bodyHtml, attachments = attachments))
        } else {
            NoteRepository.addNote(this, title, bodyHtml)
            // Si se añadieron adjuntos antes de guardar por primera vez, los enlazamos ahora
            if (attachments.isNotEmpty()) {
                val created = NoteRepository.getNotes(this).firstOrNull { it.title == title && it.text == bodyHtml }
                created?.let { note ->
                    NoteRepository.updateNote(this, note.copy(attachments = attachments))
                }
            }
        }
        finish()
    }
}
ZZEOF

echo "Botones de formato arreglados y color movido junto a tipografia. Compilando..."
./gradlew assembleDebug
rm -- "$0"