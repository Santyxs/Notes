package com.santos.tareas

import android.text.Html
import android.text.Spanned
import android.util.LruCache

/**
 * El cuerpo de la nota se guarda como HTML (para conservar negrita, colores,
 * alineación, etc.), pero las vistas previas (lista, widget, papelera,
 * compartir, búsqueda) necesitan texto plano legible.
 *
 * `toPlainText` se llama muy a menudo con el mismo contenido: en cada bind
 * de fila al hacer scroll y, sobre todo, en cada nota por cada pulsación de
 * tecla al buscar. Parsear el HTML cada vez es costoso, así que se cachea
 * el resultado por contenido para evitar recalcularlo.
 */
object HtmlUtils {

    private val plainTextCache = LruCache<String, String>(300)

    fun toHtml(spanned: Spanned): String {
        return Html.toHtml(spanned, Html.TO_HTML_PARAGRAPH_LINES_CONSECUTIVE)
    }

    fun fromHtml(html: String): Spanned {
        return Html.fromHtml(html, Html.FROM_HTML_MODE_LEGACY)
    }

    fun toPlainText(html: String): String {
        plainTextCache.get(html)?.let { return it }
        val result = Html.fromHtml(html, Html.FROM_HTML_MODE_LEGACY).toString().trim()
        plainTextCache.put(html, result)
        return result
    }
}
