package com.santos.tareas

import android.graphics.Bitmap
import android.graphics.BitmapFactory

/**
 * Decodifica un archivo de imagen reduciendo su resolución al tamaño en el
 * que realmente se va a mostrar (p. ej. una miniatura de adjunto). Sin esto,
 * una foto de cámara de 12MP se carga entera en memoria (~36MB como
 * ARGB_8888) solo para pintar un cuadro de 220px, lo que puede provocar
 * OutOfMemoryError con varias fotos adjuntas y gasta CPU/batería de sobra.
 */
object BitmapUtils {

    fun decodeSampledBitmap(path: String, reqWidth: Int, reqHeight: Int): Bitmap? {
        val boundsOptions = BitmapFactory.Options().apply { inJustDecodeBounds = true }
        BitmapFactory.decodeFile(path, boundsOptions)
        if (boundsOptions.outWidth <= 0 || boundsOptions.outHeight <= 0) return null

        val options = BitmapFactory.Options().apply {
            inSampleSize = calculateInSampleSize(boundsOptions, reqWidth, reqHeight)
        }
        return BitmapFactory.decodeFile(path, options)
    }

    private fun calculateInSampleSize(options: BitmapFactory.Options, reqWidth: Int, reqHeight: Int): Int {
        val height = options.outHeight
        val width = options.outWidth
        var inSampleSize = 1
        if (height > reqHeight || width > reqWidth) {
            val halfHeight = height / 2
            val halfWidth = width / 2
            while (halfHeight / inSampleSize >= reqHeight && halfWidth / inSampleSize >= reqWidth) {
                inSampleSize *= 2
            }
        }
        return inSampleSize
    }
}
