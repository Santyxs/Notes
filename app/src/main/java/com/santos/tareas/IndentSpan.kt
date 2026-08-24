package com.santos.tareas

import android.text.style.LeadingMarginSpan

/** Sangría real de párrafo (margen), en vez de insertar espacios en el texto. */
class IndentSpan(val level: Int) : LeadingMarginSpan {
    companion object {
        const val PX_PER_LEVEL = 48
    }

    override fun getLeadingMargin(first: Boolean): Int = level * PX_PER_LEVEL

    override fun drawLeadingMargin(
        c: android.graphics.Canvas?,
        p: android.graphics.Paint?,
        x: Int, dir: Int,
        top: Int, baseline: Int, bottom: Int,
        text: CharSequence?, start: Int, end: Int,
        first: Boolean, layout: android.text.Layout?
    ) {
        // No dibuja nada extra: solo reserva el margen.
    }
}
