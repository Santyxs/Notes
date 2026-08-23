package com.santos.tareas

import android.text.style.RelativeSizeSpan

/** Igual que RelativeSizeSpan pero identificable aparte, para poder quitar
 * solo los encabezados aplicados por la barra de formato sin tocar otros
 * cambios de tamaño que el usuario haya hecho por su cuenta. */
class HeadingSpan(scale: Float) : RelativeSizeSpan(scale)
