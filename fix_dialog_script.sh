#!/bin/bash
set -e

mkdir -p app/src/main/res/values
cat > app/src/main/res/values/themes.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Theme.Tareas" parent="Theme.MaterialComponents.DayNight.NoActionBar">
        <item name="colorPrimary">@color/accent_yellow</item>
        <item name="android:statusBarColor">@color/dark_bg</item>
        <item name="android:windowBackground">@color/dark_bg</item>
    </style>

    <style name="Theme.Tareas.Dialog" parent="Theme.MaterialComponents.DayNight.NoActionBar">
        <item name="android:statusBarColor">@color/dark_bg</item>
        <item name="android:windowBackground">@color/dark_bg</item>
        <item name="windowNoTitle">true</item>
    </style>
</resources>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_add_edit_task.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/dark_bg">

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:padding="16dp">

        <ImageView
            android:id="@+id/backButton"
            android:layout_width="44dp"
            android:layout_height="44dp"
            android:layout_alignParentStart="true"
            android:background="@drawable/circle_button_dark"
            android:padding="11dp"
            android:src="@drawable/ic_back" />

    </RelativeLayout>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:padding="20dp">

        <EditText
            android:id="@+id/taskInput"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:hint="@string/tocar_para_editar"
            android:textColor="@color/white"
            android:textColorHint="@color/dark_text_secondary"
            android:background="@android:color/transparent"
            android:textSize="20sp"
            android:fontFamily="casual" />

    </LinearLayout>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="end"
        android:padding="16dp">

        <TextView
            android:id="@+id/cancelButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/cancelar"
            android:textColor="@color/dark_text_secondary"
            android:padding="10dp" />

        <TextView
            android:id="@+id/saveButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/guardar"
            android:textColor="@color/accent_yellow"
            android:textStyle="bold"
            android:padding="10dp"
            android:layout_marginStart="8dp" />

    </LinearLayout>

</LinearLayout>
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/AddEditTaskActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.santos.tareas.databinding.ActivityAddEditTaskBinding

class AddEditTaskActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_TASK_ID = "extra_task_id"
    }

    private lateinit var binding: ActivityAddEditTaskBinding
    private var editingTaskId: Long? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddEditTaskBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val taskId = intent.getLongExtra(EXTRA_TASK_ID, -1L)
        if (taskId != -1L) {
            editingTaskId = taskId
            val task = TaskRepository.getTasks(this).find { it.id == taskId }
            binding.taskInput.setText(task?.title ?: "")
        }

        binding.backButton.setOnClickListener { saveAndFinish() }
        binding.cancelButton.setOnClickListener { finish() }
        binding.saveButton.setOnClickListener { saveAndFinish() }
    }

    private fun saveAndFinish() {
        val title = binding.taskInput.text.toString().trim()
        if (title.isEmpty()) {
            finish()
            return
        }
        val id = editingTaskId
        if (id != null) {
            TaskRepository.updateTask(this, Task(id = id, title = title, done = false))
        } else {
            TaskRepository.addTask(this, title)
        }
        finish()
    }
}
ZZEOF

echo "Pantallas de añadir arregladas (pantalla completa, sin titulo flotante). Compilando..."
./gradlew assembleDebug