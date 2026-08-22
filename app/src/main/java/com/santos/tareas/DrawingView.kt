package com.santos.tareas

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Path
import android.util.AttributeSet
import android.view.MotionEvent
import android.view.View

class DrawingView(context: Context, attrs: AttributeSet? = null) : View(context, attrs) {

    private val paths = mutableListOf<Pair<Path, Paint>>()
    private var currentPath = Path()
    private var currentPaint = makePaint(Color.WHITE)
    private var currentColor = Color.WHITE

    private fun makePaint(color: Int): Paint = Paint().apply {
        this.color = color
        style = Paint.Style.STROKE
        strokeWidth = 10f
        strokeCap = Paint.Cap.ROUND
        strokeJoin = Paint.Join.ROUND
        isAntiAlias = true
    }

    fun setColor(color: Int) {
        currentColor = color
    }

    override fun onTouchEvent(event: MotionEvent): Boolean {
        val x = event.x
        val y = event.y
        when (event.action) {
            MotionEvent.ACTION_DOWN -> {
                currentPath = Path()
                currentPaint = makePaint(currentColor)
                currentPath.moveTo(x, y)
                paths.add(currentPath to currentPaint)
            }
            MotionEvent.ACTION_MOVE -> {
                currentPath.lineTo(x, y)
            }
            MotionEvent.ACTION_UP -> {
                currentPath.lineTo(x, y)
            }
        }
        invalidate()
        return true
    }

    override fun onDraw(canvas: Canvas) {
        super.onDraw(canvas)
        canvas.drawColor(Color.parseColor("#1C1C1E"))
        for ((path, paint) in paths) {
            canvas.drawPath(path, paint)
        }
    }

    fun clear() {
        paths.clear()
        invalidate()
    }

    fun undoLastStroke() {
        if (paths.isNotEmpty()) {
            paths.removeAt(paths.size - 1)
            invalidate()
        }
    }

    fun isEmpty(): Boolean = paths.isEmpty()

    fun exportBitmap(): Bitmap {
        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        draw(canvas)
        return bitmap
    }
}
