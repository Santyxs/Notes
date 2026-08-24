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
        for ((s, e) in lineRanges(editText)) {
            val currentLevel = editable.getSpans(s, s + 1, IndentSpan::class.java)
                .maxOfOrNull { it.level } ?: 0
            editable.getSpans(s, e, IndentSpan::class.java).forEach { editable.removeSpan(it) }
            val newLevel = (currentLevel + 1).coerceAtMost(6)
            val spanEnd = if (e < editable.length) e + 1 else e
            editable.setSpan(IndentSpan(newLevel), s, spanEnd, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        }
    }

    fun decreaseIndent(editText: EditText) {
        val editable = editText.text
        for ((s, e) in lineRanges(editText)) {
            val currentLevel = editable.getSpans(s, s + 1, IndentSpan::class.java)
                .maxOfOrNull { it.level } ?: 0
            editable.getSpans(s, e, IndentSpan::class.java).forEach { editable.removeSpan(it) }
            val newLevel = (currentLevel - 1).coerceAtLeast(0)
            if (newLevel > 0) {
                val spanEnd = if (e < editable.length) e + 1 else e
                editable.setSpan(IndentSpan(newLevel), s, spanEnd, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
            }
        }
    }
}
