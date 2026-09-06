package com.santos.tareas

import android.app.Application
import androidx.appcompat.app.AppCompatDelegate

/**
 * La app está diseñada únicamente en modo oscuro (colores fijos en todo
 * el código). Al heredar de un tema DayNight, algunos fabricantes (p. ej.
 * MIUI en Xiaomi) resuelven los PopupMenu y otros componentes del sistema
 * contra la variante "day" cuando el sistema está en modo claro, lo que
 * puede mostrar texto blanco sobre fondo blanco. Forzamos MODE_NIGHT_YES
 * globalmente para que siempre se use la variante oscura, sin importar el
 * tema del sistema o del fabricante.
 */
class NotasApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_YES)
    }
}
