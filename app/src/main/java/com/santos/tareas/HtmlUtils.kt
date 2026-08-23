package com.santos.tareas

import android.text.Html
import android.text.Spanned

/**
 * El cuerpo de la nota se guarda como HTML (para conservar negrita, colores,
 * alineación, etc.), pero las vistas previas (lista, widget, papelera,
 * compartir) necesitan texto plano legible.
 */
object HtmlUtils {

    fun toHtml(spanned: Spanned): String {
        return Html.toHtml(spanned, Html.TO_HTML_PARAGRAPH_LINES_CONSECUTIVE)
    }

    fun fromHtml(html: String): Spanned {
        return Html.fromHtml(html, Html.FROM_HTML_MODE_LEGACY)
    }

    fun toPlainText(html: String): String {
        return Html.fromHtml(html, Html.FROM_HTML_MODE_LEGACY).toString().trim()
    }
}
