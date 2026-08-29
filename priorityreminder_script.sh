#!/bin/bash
set -e

mkdir -p app/src/main
cat > app/src/main/AndroidManifest.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <uses-permission android:name="android.permission.USE_BIOMETRIC" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
    <uses-permission android:name="android.permission.USE_EXACT_ALARM" />
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.Tareas">

        <activity
            android:name=".MainActivity"
            android:launchMode="singleTop"
            android:exported="true"
            android:label="@string/app_name">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <activity
            android:name=".TasksActivity"
            android:exported="false"
            android:label="@string/tareas" />

        <activity
            android:name=".NotesActivity"
            android:exported="false"
            android:label="@string/notas" />

        <activity
            android:name=".TrashActivity"
            android:exported="false"
            android:label="@string/papelera"
            android:theme="@style/Theme.Tareas.Dialog" />

        <activity
            android:name=".SettingsActivity"
            android:exported="false"
            android:label="@string/ajustes"
            android:theme="@style/Theme.Tareas.Dialog" />

        <activity
            android:name=".AddEditTaskActivity"
            android:exported="false"
            android:label="@string/tareas"
            android:theme="@style/Theme.Tareas.Dialog" />

        <activity
            android:name=".AddEditNoteActivity"
            android:exported="false"
            android:label="@string/notas"
            android:theme="@style/Theme.Tareas.Dialog" />

        <activity
            android:name=".DrawingActivity"
            android:exported="false"
            android:label="@string/dibujar"
            android:theme="@style/Theme.Tareas.Dialog" />

        <receiver
            android:name=".TaskWidgetProvider"
            android:exported="false"
            android:label="">
            <intent-filter>
                <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
            </intent-filter>
            <meta-data
                android:name="android.appwidget.provider"
                android:resource="@xml/task_widget_info" />
        </receiver>

        <receiver
            android:name=".TaskWidgetProviderNoMargin"
            android:exported="false"
            android:label="">
            <intent-filter>
                <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
            </intent-filter>
            <meta-data
                android:name="android.appwidget.provider"
                android:resource="@xml/task_widget_info_full" />
        </receiver>

        <receiver
            android:name=".NoteWidgetProvider"
            android:exported="false"
            android:label="">
            <intent-filter>
                <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
            </intent-filter>
            <meta-data
                android:name="android.appwidget.provider"
                android:resource="@xml/note_widget_info" />
        </receiver>

        <receiver
            android:name=".NoteWidgetProviderNoMargin"
            android:exported="false"
            android:label="">
            <intent-filter>
                <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
            </intent-filter>
            <meta-data
                android:name="android.appwidget.provider"
                android:resource="@xml/note_widget_info_full" />
        </receiver>

        <service
            android:name=".TaskWidgetService"
            android:exported="false"
            android:permission="android.permission.BIND_REMOTEVIEWS" />

        <service
            android:name=".NoteWidgetService"
            android:exported="false"
            android:permission="android.permission.BIND_REMOTEVIEWS" />

        <provider
            android:name="androidx.core.content.FileProvider"
            android:authorities="${applicationId}.fileprovider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/file_paths" />
        </provider>

        <receiver
            android:name=".ReminderReceiver"
            android:exported="false" />

        <receiver
            android:name=".BootReceiver"
            android:exported="false">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED" />
            </intent-filter>
        </receiver>

    </application>

</manifest>
ZZEOF

mkdir -p app/src/main/res/values
cat > app/src/main/res/values/strings.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Notas</string>
    <string name="notas">Notas</string>
    <string name="tareas">Tareas</string>
    <string name="buscar">Buscar</string>
    <string name="sin_tareas">No hay tareas todavía</string>
    <string name="sin_notas">No hay notas todavía</string>
    <string name="tocar_para_editar">Tocar para crear una tarea</string>
    <string name="titulo">Título</string>
    <string name="anota_algo">Anota algo</string>
    <string name="anadir">Añadir</string>
    <string name="guardar">Guardar</string>
    <string name="cancelar">Cancelar</string>
    <string name="anadir_tarea">Añadir tarea</string>
    <string name="anadir_nota">Añadir nota</string>
    <string name="marcar_tarea">Marcar tarea</string>
    <string name="eliminar_tarea">Eliminar tarea</string>
    <string name="eliminar_nota">Eliminar nota</string>
    <string name="vista_lista">Vista de lista</string>
    <string name="vista_tarjeta">Vista de tarjeta</string>
    <string name="vista_cuadricula">Vista de cuadrícula</string>
    <string name="todas_las_notas">Todas las notas</string>
    <string name="todas_las_tareas">Todas las tareas</string>
    <string name="papelera">Papelera</string>
    <string name="ajustes">Ajustes</string>
    <string name="papelera_vacia">La papelera está vacía</string>
    <string name="vaciar_papelera">Vaciar papelera</string>
    <string name="restaurar">Restaurar</string>
    <string name="eliminar_definitivamente">Eliminar definitivamente</string>
    <string name="acerca_de">Acerca de</string>
    <string name="nota_bloqueada">Nota bloqueada</string>
    <string name="anclar">Anclar</string>
    <string name="desanclar">Desanclar</string>
    <string name="bloquear">Bloquear</string>
    <string name="desbloquear">Desbloquear</string>
    <string name="compartir">Compartir</string>
    <string name="color_de_fondo">Color de fondo</string>
    <string name="desbloquear_nota">Desbloquea la nota para continuar</string>
    <string name="pendiente_de_completar">Pendiente de completar</string>
    <string name="completado">Completado</string>
    <string name="todo_completado">Sin tareas</string>
    <string name="deshacer">Deshacer</string>
    <string name="rehacer">Rehacer</string>
    <string name="tipografia">Tipografía</string>
    <string name="dibujar">Dibujar</string>
    <string name="insertar_imagen">Insertar imagen</string>
    <string name="insertar_tabla">Insertar tabla</string>
    <string name="guardar_dibujo">Guardar dibujo</string>
    <string name="borrar_todo">Borrar todo</string>
    <string name="filas">Filas</string>
    <string name="columnas">Columnas</string>
    <string name="crear_tabla">Crear tabla</string>
    <string name="eliminar_adjunto">Eliminar adjunto</string>
    <string name="predeterminada">Predeterminada</string>
    <string name="sans_serif">Sans-serif</string>
    <string name="serif">Serif</string>
    <string name="monoespaciada">Monoespaciada</string>
    <string name="dictar_voz">Dictar por voz</string>
    <string name="di_algo">Di algo...</string>
    <string name="cuerpo">Cuerpo</string>
    <string name="formato_texto">Formato de texto</string>
    <string name="color_de_texto">Color de texto</string>
    <string name="aa_boton">Aa</string>
    <string name="confirmar_vaciar_papelera">Se eliminarán para siempre todas las notas y tareas de la papelera. Esta acción no se puede deshacer.</string>
    <string name="confirmar_eliminar_definitivamente">Se eliminará para siempre. Esta acción no se puede deshacer.</string>
    <string name="ordenar_por">Ordenar por</string>
    <string name="fecha_reciente">Fecha (recientes primero)</string>
    <string name="fecha_antigua">Fecha (antiguas primero)</string>
    <string name="alfabetico_az">Alfabético (A-Z)</string>
    <string name="alfabetico_za">Alfabético (Z-A)</string>
    <string name="exportar_backup">Exportar copia de seguridad</string>
    <string name="importar_backup">Importar copia de seguridad</string>
    <string name="confirmar_importar_backup">Esto reemplazará todas tus notas y tareas actuales por las del archivo. ¿Continuar?</string>
    <string name="backup_exportado">Copia de seguridad lista para compartir</string>
    <string name="backup_importado">Copia de seguridad importada correctamente</string>
    <string name="backup_error">No se pudo leer el archivo de copia de seguridad</string>
    <string name="sin_resultados">Sin resultados</string>
    <string name="prioridad">Prioridad</string>
    <string name="prioridad_ninguna">Ninguna</string>
    <string name="prioridad_baja">Baja</string>
    <string name="prioridad_media">Media</string>
    <string name="prioridad_alta">Alta</string>
    <string name="recordatorio">Recordatorio</string>
    <string name="recordatorios">Recordatorios</string>
    <string name="recordatorios_desc">Avisos de tareas con recordatorio</string>
    <string name="recordatorio_titulo">Recordatorio de tarea</string>
    <string name="sin_recordatorio">Sin recordatorio</string>
    <string name="quitar_recordatorio">Quitar recordatorio</string>
    <string name="tareas_con_margen">Tareas (con margen)</string>
    <string name="tareas_sin_margen">Tareas (sin margen)</string>
    <string name="notas_con_margen">Notas (con margen)</string>
    <string name="notas_sin_margen">Notas (sin margen)</string>
</resources>
ZZEOF

mkdir -p app/src/main/res/values
cat > app/src/main/res/values/colors.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="card_cream">#FCEBB6</color>
    <color name="accent_yellow">#F5A623</color>
    <color name="text_brown">#5C4322</color>
    <color name="text_brown_light">#A9895C</color>
    <color name="background_app">#0B1E45</color>
    <color name="white">#FFFFFF</color>

    <color name="dark_bg">#0E0E10</color>
    <color name="dark_surface">#232326</color>
    <color name="dark_surface_light">#2E2E32</color>
    <color name="dark_text_secondary">#8A8A8E</color>
    <color name="accent_blue">#3E9EFF</color>
    <color name="priority_high">#E5484D</color>
    <color name="priority_medium">#F5A623</color>
    <color name="priority_low">#4CC38A</color>
    <color name="priority_none">#5A5A60</color>
</resources>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_priority_flag.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp"
    android:height="20dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M14.4,6L14,4L5,4v17h2v-7h5.6l0.4,2h7L20,6z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_reminder.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="20dp"
    android:height="20dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M12,22c1.1,0 2,-0.9 2,-2h-4c0,1.1 0.89,2 2,2zM18,16v-5c0,-3.07 -1.64,-5.64 -4.5,-6.32L13.5,4c0,-0.83 -0.67,-1.5 -1.5,-1.5s-1.5,0.67 -1.5,1.5v0.68C7.63,5.36 6,7.92 6,11v5l-2,2v1h16v-1l-2,-2z" />
</vector>
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

    <ScrollView
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="vertical">

            <LinearLayout
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:orientation="horizontal"
                android:gravity="center_vertical"
                android:padding="20dp">

                <ImageView
                    android:layout_width="26dp"
                    android:layout_height="26dp"
                    android:layout_marginEnd="14dp"
                    android:layout_marginTop="2dp"
                    android:src="@drawable/ic_check_circle_outline" />

                <EditText
                    android:id="@+id/taskInput"
                    android:layout_width="0dp"
                    android:layout_height="wrap_content"
                    android:layout_weight="1"
                    android:hint="@string/tocar_para_editar"
                    android:textColor="@color/white"
                    android:textColorHint="@color/dark_text_secondary"
                    android:textSize="24sp"
                    android:textStyle="bold"
                    android:background="@android:color/transparent"
                    android:fontFamily="casual"
                    android:includeFontPadding="false"
                    android:paddingTop="0dp"
                    android:paddingBottom="0dp"
                    android:gravity="center_vertical" />

            </LinearLayout>

            <LinearLayout
                android:id="@+id/priorityRow"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:orientation="horizontal"
                android:gravity="center_vertical"
                android:background="@drawable/dark_row_background"
                android:layout_marginHorizontal="20dp"
                android:layout_marginBottom="12dp"
                android:padding="14dp">

                <ImageView
                    android:id="@+id/priorityIcon"
                    android:layout_width="20dp"
                    android:layout_height="20dp"
                    android:layout_marginEnd="14dp"
                    android:src="@drawable/ic_priority_flag" />

                <TextView
                    android:layout_width="0dp"
                    android:layout_height="wrap_content"
                    android:layout_weight="1"
                    android:text="@string/prioridad"
                    android:textColor="@color/white"
                    android:textSize="15sp" />

                <TextView
                    android:id="@+id/priorityValueLabel"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:text="@string/prioridad_ninguna"
                    android:textColor="@color/dark_text_secondary"
                    android:textSize="14sp" />

            </LinearLayout>

            <LinearLayout
                android:id="@+id/reminderRow"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:orientation="horizontal"
                android:gravity="center_vertical"
                android:background="@drawable/dark_row_background"
                android:layout_marginHorizontal="20dp"
                android:padding="14dp">

                <ImageView
                    android:layout_width="20dp"
                    android:layout_height="20dp"
                    android:layout_marginEnd="14dp"
                    android:src="@drawable/ic_reminder" />

                <TextView
                    android:layout_width="0dp"
                    android:layout_height="wrap_content"
                    android:layout_weight="1"
                    android:text="@string/recordatorio"
                    android:textColor="@color/white"
                    android:textSize="15sp" />

                <TextView
                    android:id="@+id/reminderValueLabel"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:text="@string/sin_recordatorio"
                    android:textColor="@color/dark_text_secondary"
                    android:textSize="14sp" />

            </LinearLayout>

        </LinearLayout>

    </ScrollView>

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

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/item_task_row.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:gravity="center_vertical"
    android:background="@drawable/dark_row_background"
    android:layout_marginBottom="8dp"
    android:padding="14dp">

    <View
        android:id="@+id/priorityStripe"
        android:layout_width="4dp"
        android:layout_height="28dp"
        android:layout_marginEnd="10dp"
        android:visibility="gone" />

    <ImageView
        android:id="@+id/checkbox"
        android:layout_width="24dp"
        android:layout_height="24dp"
        android:layout_marginEnd="12dp"
        android:src="@drawable/ic_check_circle_outline" />

    <FrameLayout
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1">

        <TextView
            android:id="@+id/title"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_gravity="start|center_vertical"
            android:textColor="@color/white"
            android:textSize="16sp" />

        <View
            android:id="@+id/strikeLine"
            android:layout_width="wrap_content"
            android:layout_height="2dp"
            android:layout_gravity="start|center_vertical"
            android:background="@color/dark_text_secondary"
            android:visibility="invisible" />

    </FrameLayout>

    <ImageView
        android:id="@+id/reminderIndicator"
        android:layout_width="16dp"
        android:layout_height="16dp"
        android:layout_marginEnd="8dp"
        android:src="@drawable/ic_reminder"
        android:visibility="gone" />

    <ImageView
        android:id="@+id/deleteButton"
        android:layout_width="22dp"
        android:layout_height="22dp"
        android:padding="1dp"
        android:src="@drawable/ic_trash"
        android:contentDescription="@string/eliminar_tarea" />

</LinearLayout>
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/Task.kt << 'ZZEOF'
package com.santos.tareas

/** 0 = sin prioridad, 1 = baja, 2 = media, 3 = alta */
data class Task(
    val id: Long,
    var title: String,
    var done: Boolean = false,
    var deleted: Boolean = false,
    var createdAt: Long = System.currentTimeMillis(),
    var priority: Int = 0,
    var reminderAt: Long = 0L
)
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/TaskRepository.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/**
 * Almacena la lista de tareas en SharedPreferences como JSON.
 * Es la única fuente de datos: la usan tanto MainActivity/AddEditTaskActivity
 * como el widget (TaskWidgetService), así que cualquier cambio se refleja
 * en ambos sitios en cuanto se notifica la actualización del widget.
 *
 * "Eliminar" no borra al momento: marca la tarea como `deleted` para que
 * pase a la papelera, igual que las notas.
 */
object TaskRepository {

    private const val PREFS = "tareas_prefs"
    private const val KEY_TASKS = "tasks_json"
    private const val KEY_NEXT_ID = "next_id"

    private fun getAllRaw(context: Context): MutableList<Task> {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val json = prefs.getString(KEY_TASKS, null)
        if (json == null) {
            val seed = mutableListOf(
                Task(id = nextId(context), title = "Bienvenido a Tareas", done = false),
                Task(id = nextId(context), title = "Crear una tarea", done = false),
                Task(id = nextId(context), title = "Tocar para editar", done = false)
            )
            saveTasks(context, seed)
            return seed
        }
        val array = JSONArray(json)
        val list = mutableListOf<Task>()
        for (i in 0 until array.length()) {
            val o = array.getJSONObject(i)
            list.add(
                Task(
                    id = o.getLong("id"),
                    title = o.getString("title"),
                    done = o.getBoolean("done"),
                    deleted = if (o.has("deleted")) o.getBoolean("deleted") else false,
                    createdAt = if (o.has("createdAt")) o.getLong("createdAt") else o.getLong("id"),
                    priority = if (o.has("priority")) o.getInt("priority") else 0,
                    reminderAt = if (o.has("reminderAt")) o.getLong("reminderAt") else 0L
                )
            )
        }
        return list
    }

    /** Tareas activas (no eliminadas) — lo que se muestra normalmente. */
    fun getTasks(context: Context): MutableList<Task> =
        getAllRaw(context).filter { !it.deleted }.toMutableList()

    /** Tareas en la papelera. */
    fun getDeletedTasks(context: Context): MutableList<Task> =
        getAllRaw(context).filter { it.deleted }.toMutableList()

    private fun saveTasks(context: Context, tasks: List<Task>) {
        val array = JSONArray()
        for (t in tasks) {
            val o = JSONObject()
            o.put("id", t.id)
            o.put("title", t.title)
            o.put("done", t.done)
            o.put("deleted", t.deleted)
            o.put("createdAt", t.createdAt)
            o.put("priority", t.priority)
            o.put("reminderAt", t.reminderAt)
            array.put(o)
        }
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .edit()
            .putString(KEY_TASKS, array.toString())
            .apply()
    }

    private fun nextId(context: Context): Long {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val id = prefs.getLong(KEY_NEXT_ID, 1L)
        prefs.edit().putLong(KEY_NEXT_ID, id + 1).apply()
        return id
    }

    fun addTask(context: Context, title: String) {
        val tasks = getAllRaw(context)
        tasks.add(Task(id = nextId(context), title = title, done = false, createdAt = System.currentTimeMillis()))
        saveTasks(context, tasks)
        WidgetUpdater.updateAll(context)
    }

    fun updateTask(context: Context, task: Task) {
        val tasks = getAllRaw(context)
        val idx = tasks.indexOfFirst { it.id == task.id }
        if (idx >= 0) {
            tasks[idx] = task
            saveTasks(context, tasks)
            WidgetUpdater.updateAll(context)
        }
    }

    fun toggleDone(context: Context, id: Long) {
        val tasks = getAllRaw(context)
        val idx = tasks.indexOfFirst { it.id == id }
        if (idx >= 0) {
            val updated = tasks[idx].copy(done = !tasks[idx].done)
            tasks[idx] = updated
            saveTasks(context, tasks)
            if (updated.done) {
                ReminderManager.cancel(context, id)
            } else if (updated.reminderAt > System.currentTimeMillis()) {
                ReminderManager.schedule(context, id, updated.reminderAt)
            }
            WidgetUpdater.updateAll(context)
        }
    }

    /** Mueve la tarea a la papelera (no la borra todavía). */
    fun deleteTask(context: Context, id: Long) {
        val tasks = getAllRaw(context)
        val idx = tasks.indexOfFirst { it.id == id }
        if (idx >= 0) {
            tasks[idx] = tasks[idx].copy(deleted = true)
            saveTasks(context, tasks)
            ReminderManager.cancel(context, id)
            WidgetUpdater.updateAll(context)
        }
    }

    fun restoreTask(context: Context, id: Long) {
        val tasks = getAllRaw(context)
        val idx = tasks.indexOfFirst { it.id == id }
        if (idx >= 0) {
            tasks[idx] = tasks[idx].copy(deleted = false)
            saveTasks(context, tasks)
            WidgetUpdater.updateAll(context)
        }
    }

    /** Borra definitivamente una tarea de la papelera. */
    fun permanentlyDeleteTask(context: Context, id: Long) {
        val tasks = getAllRaw(context)
        tasks.removeAll { it.id == id }
        saveTasks(context, tasks)
        ReminderManager.cancel(context, id)
        WidgetUpdater.updateAll(context)
    }

    /** Todas las tareas, incluidas las de la papelera (para copia de seguridad). */
    fun getAllIncludingDeleted(context: Context): List<Task> = getAllRaw(context)

    /** Sustituye todos los datos por una lista importada (copia de seguridad). */
    fun replaceAll(context: Context, tasks: List<Task>) {
        saveTasks(context, tasks)
    }

    fun emptyTrash(context: Context) {
        val tasks = getAllRaw(context)
        tasks.removeAll { it.deleted }
        saveTasks(context, tasks)
        WidgetUpdater.updateAll(context)
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/ReminderManager.kt << 'ZZEOF'
package com.santos.tareas

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent

object ReminderManager {

    private fun pendingIntentFor(context: Context, taskId: Long): PendingIntent {
        val intent = Intent(context, ReminderReceiver::class.java).apply {
            putExtra(ReminderReceiver.EXTRA_TASK_ID, taskId)
        }
        return PendingIntent.getBroadcast(
            context, taskId.toInt(), intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }

    fun schedule(context: Context, taskId: Long, timeMillis: Long) {
        if (timeMillis <= System.currentTimeMillis()) return
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val pendingIntent = pendingIntentFor(context, taskId)
        try {
            alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, timeMillis, pendingIntent)
        } catch (e: SecurityException) {
            // El usuario no concedió permiso de alarmas exactas: no programamos nada
        }
    }

    fun cancel(context: Context, taskId: Long) {
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        alarmManager.cancel(pendingIntentFor(context, taskId))
    }

    /** Reprograma todos los recordatorios pendientes (se llama tras reiniciar el móvil). */
    fun rescheduleAll(context: Context) {
        val tasks = TaskRepository.getTasks(context)
        for (task in tasks) {
            if (task.reminderAt > System.currentTimeMillis() && !task.done) {
                schedule(context, task.id, task.reminderAt)
            }
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/ReminderReceiver.kt << 'ZZEOF'
package com.santos.tareas

import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat

class ReminderReceiver : BroadcastReceiver() {

    companion object {
        const val EXTRA_TASK_ID = "extra_task_id"
    }

    override fun onReceive(context: Context, intent: Intent) {
        val taskId = intent.getLongExtra(EXTRA_TASK_ID, -1L)
        if (taskId == -1L) return

        val task = TaskRepository.getTasks(context).find { it.id == taskId } ?: return
        if (task.done) return

        NotificationHelper.ensureChannel(context)

        val openIntent = Intent(context, AddEditTaskActivity::class.java).apply {
            putExtra(AddEditTaskActivity.EXTRA_TASK_ID, task.id)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
        }
        val contentPendingIntent = PendingIntent.getActivity(
            context, taskId.toInt(), openIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val notification = NotificationCompat.Builder(context, NotificationHelper.CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_reminder)
            .setContentTitle(context.getString(R.string.recordatorio_titulo))
            .setContentText(task.title)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .setContentIntent(contentPendingIntent)
            .build()

        if (ContextCompat.checkSelfPermission(context, android.Manifest.permission.POST_NOTIFICATIONS)
            == PackageManager.PERMISSION_GRANTED || android.os.Build.VERSION.SDK_INT < 33
        ) {
            NotificationManagerCompat.from(context).notify(taskId.toInt(), notification)
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NotificationHelper.kt << 'ZZEOF'
package com.santos.tareas

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build

object NotificationHelper {
    const val CHANNEL_ID = "recordatorios_tareas"

    fun ensureChannel(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val manager = context.getSystemService(NotificationManager::class.java)
            val existing = manager.getNotificationChannel(CHANNEL_ID)
            if (existing == null) {
                val channel = NotificationChannel(
                    CHANNEL_ID,
                    context.getString(R.string.recordatorios),
                    NotificationManager.IMPORTANCE_HIGH
                )
                channel.description = context.getString(R.string.recordatorios_desc)
                manager.createNotificationChannel(channel)
            }
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/BootReceiver.kt << 'ZZEOF'
package com.santos.tareas

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            ReminderManager.rescheduleAll(context)
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/AddEditTaskActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.Manifest
import android.app.AlertDialog
import android.app.DatePickerDialog
import android.app.TimePickerDialog
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.widget.PopupMenu
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.santos.tareas.databinding.ActivityAddEditTaskBinding
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale

class AddEditTaskActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_TASK_ID = "extra_task_id"
        private const val REQUEST_NOTIFICATION_PERMISSION = 400
    }

    private lateinit var binding: ActivityAddEditTaskBinding
    private var editingTaskId: Long? = null
    private var currentPriority: Int = 0
    private var currentReminderAt: Long = 0L
    private var currentDone: Boolean = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddEditTaskBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val taskId = intent.getLongExtra(EXTRA_TASK_ID, -1L)
        if (taskId != -1L) {
            editingTaskId = taskId
            val task = TaskRepository.getTasks(this).find { it.id == taskId }
            binding.taskInput.setText(task?.title ?: "")
            currentPriority = task?.priority ?: 0
            currentReminderAt = task?.reminderAt ?: 0L
            currentDone = task?.done ?: false
        }

        updatePriorityUi()
        updateReminderUi()

        binding.backButton.setOnClickListener { saveAndFinish() }
        binding.cancelButton.setOnClickListener { finish() }
        binding.saveButton.setOnClickListener { saveAndFinish() }
        binding.priorityRow.setOnClickListener { showPriorityMenu() }
        binding.reminderRow.setOnClickListener { showReminderPicker() }
    }

    // ---------- Prioridad ----------

    private fun showPriorityMenu() {
        val popup = PopupMenu(this, binding.priorityRow)
        popup.menu.add(0, 0, 0, getString(R.string.prioridad_ninguna))
        popup.menu.add(0, 1, 1, getString(R.string.prioridad_baja))
        popup.menu.add(0, 2, 2, getString(R.string.prioridad_media))
        popup.menu.add(0, 3, 3, getString(R.string.prioridad_alta))
        popup.setOnMenuItemClickListener { item ->
            currentPriority = item.itemId
            updatePriorityUi()
            true
        }
        popup.show()
    }

    private fun updatePriorityUi() {
        val (labelRes, colorRes) = when (currentPriority) {
            1 -> R.string.prioridad_baja to R.color.priority_low
            2 -> R.string.prioridad_media to R.color.priority_medium
            3 -> R.string.prioridad_alta to R.color.priority_high
            else -> R.string.prioridad_ninguna to R.color.priority_none
        }
        binding.priorityValueLabel.text = getString(labelRes)
        binding.priorityIcon.setColorFilter(ContextCompat.getColor(this, colorRes))
    }

    // ---------- Recordatorio ----------

    private fun showReminderPicker() {
        val calendar = Calendar.getInstance()
        if (currentReminderAt > 0) calendar.timeInMillis = currentReminderAt

        DatePickerDialog(
            this,
            { _, year, month, day ->
                calendar.set(year, month, day)
                TimePickerDialog(
                    this,
                    { _, hour, minute ->
                        calendar.set(Calendar.HOUR_OF_DAY, hour)
                        calendar.set(Calendar.MINUTE, minute)
                        calendar.set(Calendar.SECOND, 0)
                        if (calendar.timeInMillis <= System.currentTimeMillis()) {
                            calendar.add(Calendar.DAY_OF_YEAR, 1)
                        }
                        currentReminderAt = calendar.timeInMillis
                        updateReminderUi()
                        ensureNotificationPermission()
                    },
                    calendar.get(Calendar.HOUR_OF_DAY),
                    calendar.get(Calendar.MINUTE),
                    true
                ).show()
            },
            calendar.get(Calendar.YEAR),
            calendar.get(Calendar.MONTH),
            calendar.get(Calendar.DAY_OF_MONTH)
        ).show()
    }

    private fun ensureNotificationPermission() {
        if (Build.VERSION.SDK_INT >= 33) {
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS)
                != PackageManager.PERMISSION_GRANTED
            ) {
                ActivityCompat.requestPermissions(
                    this, arrayOf(Manifest.permission.POST_NOTIFICATIONS), REQUEST_NOTIFICATION_PERMISSION
                )
            }
        }
    }

    private fun updateReminderUi() {
        if (currentReminderAt > 0) {
            val formatter = SimpleDateFormat("d MMM, HH:mm", Locale("es", "ES"))
            binding.reminderValueLabel.text = formatter.format(currentReminderAt)
            binding.reminderRow.setOnLongClickListener {
                confirmRemoveReminder()
                true
            }
        } else {
            binding.reminderValueLabel.text = getString(R.string.sin_recordatorio)
            binding.reminderRow.setOnLongClickListener(null)
        }
    }

    private fun confirmRemoveReminder() {
        AlertDialog.Builder(this)
            .setTitle(R.string.quitar_recordatorio)
            .setPositiveButton(android.R.string.ok) { _, _ ->
                currentReminderAt = 0L
                updateReminderUi()
            }
            .setNegativeButton(android.R.string.cancel, null)
            .show()
    }

    // ---------- Guardar ----------

    private fun saveAndFinish() {
        val title = binding.taskInput.text.toString().trim()
        if (title.isEmpty()) {
            val id = editingTaskId
            if (id != null) ReminderManager.cancel(this, id)
            finish()
            return
        }
        val id = editingTaskId
        val savedId: Long
        if (id != null) {
            TaskRepository.updateTask(
                this,
                Task(
                    id = id,
                    title = title,
                    done = currentDone,
                    priority = currentPriority,
                    reminderAt = currentReminderAt
                )
            )
            savedId = id
        } else {
            TaskRepository.addTask(this, title)
            val created = TaskRepository.getTasks(this).lastOrNull { it.title == title }
            savedId = created?.id ?: -1L
            if (created != null) {
                TaskRepository.updateTask(
                    this,
                    created.copy(priority = currentPriority, reminderAt = currentReminderAt)
                )
            }
        }

        if (savedId != -1L) {
            if (currentReminderAt > 0) {
                ReminderManager.schedule(this, savedId, currentReminderAt)
            } else {
                ReminderManager.cancel(this, savedId)
            }
        }
        finish()
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/TaskAdapter.kt << 'ZZEOF'
package com.santos.tareas

import android.animation.ValueAnimator
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.animation.DecelerateInterpolator
import androidx.recyclerview.widget.RecyclerView
import com.santos.tareas.databinding.ItemSectionHeaderBinding
import com.santos.tareas.databinding.ItemTaskRowBinding

sealed class TaskListItem {
    data class Header(val title: String, val collapsible: Boolean, val expanded: Boolean) : TaskListItem()
    data class Row(val task: Task) : TaskListItem()
}

private const val VIEW_TYPE_HEADER = 0
private const val VIEW_TYPE_ROW = 1

class TaskAdapter(
    private val onToggle: (Task) -> Unit,
    private val onClick: (Task) -> Unit,
    private val onDelete: (Task) -> Unit,
    private val onHeaderToggle: () -> Unit = {}
) : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    private var items: List<TaskListItem> = emptyList()
    var flatStyle: Boolean = false

    /** Id de la tarea recién marcada como hecha: solo esa fila anima la tachadura. */
    var justToggledId: Long? = null

    /** Se llama cuando termina la animación de tachado, para entonces sí reordenar en secciones. */
    var onAnimationEnd: (() -> Unit)? = null

    /**
     * Actualiza visualmente una tarea a "hecha" en su posición actual (sin moverla
     * todavía a la sección Completado), para poder reproducir la animación de tachado
     * en el sitio donde el usuario la tocó.
     */
    fun markDoneInPlace(taskId: Long) {
        val index = items.indexOfFirst { it is TaskListItem.Row && it.task.id == taskId }
        if (index == -1) return
        val row = items[index] as TaskListItem.Row
        val updatedItems = items.toMutableList()
        updatedItems[index] = TaskListItem.Row(row.task.copy(done = true))
        items = updatedItems
        justToggledId = taskId
        notifyItemChanged(index)
    }

    /** Mantiene compatibilidad con el código que llamaba submitList(List<Task>) sin secciones. */
    fun submitList(tasks: List<Task>) {
        items = tasks.map { TaskListItem.Row(it) }
        notifyDataSetChanged()
    }

    fun submitSections(newItems: List<TaskListItem>) {
        items = newItems
        notifyDataSetChanged()
    }

    fun isHeaderAt(position: Int): Boolean = items.getOrNull(position) is TaskListItem.Header

    override fun getItemViewType(position: Int): Int =
        if (items[position] is TaskListItem.Header) VIEW_TYPE_HEADER else VIEW_TYPE_ROW

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return if (viewType == VIEW_TYPE_HEADER) {
            val binding = ItemSectionHeaderBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            HeaderViewHolder(binding)
        } else {
            val binding = ItemTaskRowBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            TaskViewHolder(binding)
        }
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        when (val item = items[position]) {
            is TaskListItem.Header -> (holder as HeaderViewHolder).bind(item)
            is TaskListItem.Row -> (holder as TaskViewHolder).bind(item.task)
        }
    }

    override fun getItemCount(): Int = items.size

    inner class HeaderViewHolder(private val binding: ItemSectionHeaderBinding) :
        RecyclerView.ViewHolder(binding.root) {
        fun bind(header: TaskListItem.Header) {
            binding.sectionHeaderTitle.text = header.title
            if (header.collapsible) {
                binding.sectionHeaderChevron.visibility = android.view.View.VISIBLE
                binding.sectionHeaderChevron.rotation = if (header.expanded) 180f else 0f
                binding.sectionHeaderRow.setOnClickListener { onHeaderToggle() }
            } else {
                binding.sectionHeaderChevron.visibility = android.view.View.GONE
                binding.sectionHeaderRow.setOnClickListener(null)
            }
        }
    }

    inner class TaskViewHolder(private val binding: ItemTaskRowBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(task: Task) {
            binding.root.setBackgroundResource(
                if (flatStyle) R.drawable.dark_row_flat_background else R.drawable.dark_row_background
            )
            binding.title.text = task.title
            binding.checkbox.setImageResource(
                if (task.done) R.drawable.ic_check_circle_filled else R.drawable.ic_check_circle_outline
            )

            if (task.priority > 0) {
                binding.priorityStripe.visibility = View.VISIBLE
                val colorRes = when (task.priority) {
                    1 -> R.color.priority_low
                    2 -> R.color.priority_medium
                    else -> R.color.priority_high
                }
                binding.priorityStripe.setBackgroundColor(
                    binding.root.context.getColor(colorRes)
                )
            } else {
                binding.priorityStripe.visibility = View.GONE
            }

            binding.reminderIndicator.visibility =
                if (task.reminderAt > 0 && !task.done) View.VISIBLE else View.GONE

            binding.strikeLine.animate().cancel()

            if (task.done) {
                val shouldAnimate = task.id == justToggledId
                // Esperamos a que el título tenga su ancho real medido
                binding.title.post {
                    val textWidth = binding.title.width
                    if (textWidth <= 0) return@post
                    val params = binding.strikeLine.layoutParams
                    binding.strikeLine.visibility = View.VISIBLE

                    if (shouldAnimate) {
                        params.width = 1
                        binding.strikeLine.layoutParams = params
                        val animator = ValueAnimator.ofInt(1, textWidth)
                        animator.duration = 1800
                        animator.interpolator = DecelerateInterpolator()
                        animator.addUpdateListener { anim ->
                            val p = binding.strikeLine.layoutParams
                            p.width = anim.animatedValue as Int
                            binding.strikeLine.layoutParams = p
                        }
                        animator.addListener(object : android.animation.AnimatorListenerAdapter() {
                            override fun onAnimationEnd(animation: android.animation.Animator) {
                                onAnimationEnd?.invoke()
                            }
                        })
                        animator.start()
                        justToggledId = null
                    } else {
                        params.width = textWidth
                        binding.strikeLine.layoutParams = params
                    }
                }
            } else {
                binding.strikeLine.visibility = View.INVISIBLE
            }

            binding.checkbox.setOnClickListener { onToggle(task) }
            binding.root.setOnClickListener { onClick(task) }
            binding.deleteButton.setOnClickListener { onDelete(task) }
        }
    }
}
ZZEOF

echo "Prioridad y recordatorios de tareas listos. Compilando..."
./gradlew assembleDebug
rm -- "$0"