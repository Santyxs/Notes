package com.santos.tareas

import android.content.Context
import android.content.Intent
import android.graphics.Paint
import android.text.SpannableString
import android.text.Spanned
import android.text.style.StrikethroughSpan
import android.widget.RemoteViews
import android.widget.RemoteViewsService.RemoteViewsFactory

class TaskRemoteViewsFactory(private val context: Context) : RemoteViewsFactory {

    private var tasks: List<Task> = emptyList()

    override fun onCreate() {
        tasks = TaskRepository.getTasks(context).filter { !it.done }
    }

    override fun onDataSetChanged() {
        tasks = TaskRepository.getTasks(context).filter { !it.done }
    }

    override fun onDestroy() {
        tasks = emptyList()
    }

    override fun getCount(): Int = tasks.size

    override fun getViewAt(position: Int): RemoteViews {
        val task = tasks[position]
        val views = RemoteViews(context.packageName, R.layout.widget_task_item)

        if (task.done) {
            val spannable = SpannableString(task.title)
            spannable.setSpan(StrikethroughSpan(), 0, task.title.length, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
            views.setTextViewText(R.id.item_title, spannable)
            views.setInt(R.id.item_title, "setTextColor", android.graphics.Color.parseColor("#A9895C"))
        } else {
            views.setTextViewText(R.id.item_title, task.title)
            views.setInt(R.id.item_title, "setTextColor", android.graphics.Color.parseColor("#5C4322"))
        }

        views.setImageViewResource(
            R.id.item_checkbox,
            if (task.done) R.drawable.ic_check_circle_filled else R.drawable.ic_check_circle_outline
        )

        val fillInIntent = Intent().apply {
            putExtra(TaskWidgetProvider.EXTRA_TASK_ID, task.id)
        }
        views.setOnClickFillInIntent(R.id.item_row, fillInIntent)

        return views
    }

    override fun getLoadingView(): RemoteViews? = null
    override fun getViewTypeCount(): Int = 1
    override fun getItemId(position: Int): Long = tasks[position].id
    override fun hasStableIds(): Boolean = true
}
