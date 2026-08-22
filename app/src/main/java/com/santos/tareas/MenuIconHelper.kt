package com.santos.tareas

import android.widget.PopupMenu

/**
 * Android oculta los iconos de un PopupMenu por defecto. No hay API pública
 * para forzarlos, así que usamos el método interno setOptionalIconsVisible
 * vía reflexión (técnica estándar y ampliamente usada para esto).
 */
object MenuIconHelper {
    fun forceShowIcons(popupMenu: PopupMenu) {
        try {
            val menu = popupMenu.menu
            val method = menu.javaClass.getDeclaredMethod(
                "setOptionalIconsVisible", Boolean::class.javaPrimitiveType
            )
            method.isAccessible = true
            method.invoke(menu, true)
        } catch (e: Exception) {
            // Si el fabricante cambió la API interna, simplemente no se muestran iconos
        }
    }
}
