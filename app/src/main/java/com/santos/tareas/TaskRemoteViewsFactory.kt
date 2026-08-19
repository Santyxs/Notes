package com.santos.tareas

import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import android.widget.RemoteViewsService.RemoteViewsFactory

class TaskRemoteViewsFactory(private val context: Context) : RemoteViewsFactory {

    private var tasks: List<Task> = emptyList()

    override fun onCreate() {
        tasks = TaskRepository.getTasks(context)
    }

    override fun onDataSetChanged() {
        tasks = TaskRepository.getTasks(context)
    }

    override fun onDestroy() {
        tasks = emptyList()
    }

    override fun getCount(): Int = tasks.size

    override fun getViewAt(position: Int): RemoteViews {
        val task = tasks[position]
        val views = RemoteViews(context.packageName, R.layout.widget_task_item)

        views.setTextViewText(R.id.item_title, task.title)
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
