#!/bin/bash
set -e

mkdir -p app/src/main
cat > app/src/main/AndroidManifest.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <uses-permission android:name="android.permission.USE_BIOMETRIC" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />

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
    <string name="tareas_con_margen">Tareas (con margen)</string>
    <string name="tareas_sin_margen">Tareas (sin margen)</string>
    <string name="notas_con_margen">Notas (con margen)</string>
    <string name="notas_sin_margen">Notas (sin margen)</string>
    <string name="tareas_con_margen">Tareas (con margen)</string>
    <string name="notas_con_margen">Notas (con margen)</string>
</resources>
ZZEOF

mkdir -p app/src/main/res/xml
cat > app/src/main/res/xml/task_widget_info.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<appwidget-provider xmlns:android="http://schemas.android.com/apk/res/android"
    android:label="@string/tareas_con_margen"
    android:minWidth="40dp"
    android:minHeight="40dp"
    android:minResizeWidth="40dp"
    android:minResizeHeight="40dp"
    android:maxResizeWidth="360dp"
    android:maxResizeHeight="360dp"
    android:targetCellWidth="3"
    android:targetCellHeight="3"
    android:updatePeriodMillis="0"
    android:initialLayout="@layout/widget_task"
    android:resizeMode="vertical|horizontal"
    android:widgetCategory="home_screen" />
ZZEOF

mkdir -p app/src/main/res/xml
cat > app/src/main/res/xml/note_widget_info.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<appwidget-provider xmlns:android="http://schemas.android.com/apk/res/android"
    android:label="@string/notas_con_margen"
    android:minWidth="40dp"
    android:minHeight="40dp"
    android:minResizeWidth="40dp"
    android:minResizeHeight="40dp"
    android:maxResizeWidth="360dp"
    android:maxResizeHeight="360dp"
    android:targetCellWidth="3"
    android:targetCellHeight="3"
    android:updatePeriodMillis="0"
    android:initialLayout="@layout/widget_note"
    android:resizeMode="vertical|horizontal"
    android:widgetCategory="home_screen" />
ZZEOF

mkdir -p app/src/main/res/xml
cat > app/src/main/res/xml/task_widget_info_full.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<appwidget-provider xmlns:android="http://schemas.android.com/apk/res/android"
    android:label="@string/tareas_sin_margen"
    android:minWidth="40dp"
    android:minHeight="40dp"
    android:minResizeWidth="40dp"
    android:minResizeHeight="40dp"
    android:maxResizeWidth="360dp"
    android:maxResizeHeight="360dp"
    android:targetCellWidth="3"
    android:targetCellHeight="3"
    android:updatePeriodMillis="0"
    android:initialLayout="@layout/widget_task_full"
    android:resizeMode="vertical|horizontal"
    android:widgetCategory="home_screen" />
ZZEOF

mkdir -p app/src/main/res/xml
cat > app/src/main/res/xml/note_widget_info_full.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<appwidget-provider xmlns:android="http://schemas.android.com/apk/res/android"
    android:label="@string/notas_sin_margen"
    android:minWidth="40dp"
    android:minHeight="40dp"
    android:minResizeWidth="40dp"
    android:minResizeHeight="40dp"
    android:maxResizeWidth="360dp"
    android:maxResizeHeight="360dp"
    android:targetCellWidth="3"
    android:targetCellHeight="3"
    android:updatePeriodMillis="0"
    android:initialLayout="@layout/widget_note_full"
    android:resizeMode="vertical|horizontal"
    android:widgetCategory="home_screen" />
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/widget_task_full.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@drawable/widget_card_background">

    <RelativeLayout
        android:id="@+id/widget_header"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:background="@drawable/widget_header_background"
        android:paddingHorizontal="16dp"
        android:paddingVertical="12dp">

        <TextView
            android:id="@+id/widget_title"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_centerVertical="true"
            android:text="@string/tareas"
            android:textColor="@color/text_brown"
            android:textSize="20sp"
            android:textStyle="bold"
            android:fontFamily="casual" />

        <ImageView
            android:id="@+id/widget_add_button"
            android:layout_width="34dp"
            android:layout_height="34dp"
            android:layout_alignParentEnd="true"
            android:layout_centerVertical="true"
            android:background="@drawable/widget_add_button_background"
            android:padding="7dp"
            android:src="@drawable/ic_plus"
            android:contentDescription="@string/anadir_tarea" />
    </RelativeLayout>

    <ListView
        android:id="@+id/widget_list"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:paddingHorizontal="16dp"
        android:paddingTop="8dp"
        android:divider="@null"
        android:dividerHeight="4dp"
        android:listSelector="@android:color/transparent" />

    <TextView
        android:id="@+id/widget_empty"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:gravity="center"
        android:text="@string/sin_tareas"
        android:textColor="@color/text_brown_light"
        android:textSize="14sp" />

</LinearLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/widget_note_full.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@drawable/widget_card_background">

    <RelativeLayout
        android:id="@+id/widget_note_header"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:background="@drawable/widget_header_background"
        android:paddingHorizontal="16dp"
        android:paddingVertical="12dp">

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_centerVertical="true"
            android:text="@string/notas"
            android:textColor="@color/text_brown"
            android:textSize="20sp"
            android:textStyle="bold"
            android:fontFamily="casual" />

        <ImageView
            android:id="@+id/widget_note_add_button"
            android:layout_width="34dp"
            android:layout_height="34dp"
            android:layout_alignParentEnd="true"
            android:layout_centerVertical="true"
            android:background="@drawable/widget_add_button_background"
            android:padding="7dp"
            android:src="@drawable/ic_plus"
            android:contentDescription="@string/anadir_nota" />
    </RelativeLayout>

    <ListView
        android:id="@+id/widget_note_list"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:paddingHorizontal="16dp"
        android:paddingTop="8dp"
        android:divider="@null"
        android:dividerHeight="4dp"
        android:listSelector="@android:color/transparent" />

    <TextView
        android:id="@+id/widget_note_empty"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:gravity="center"
        android:text="@string/sin_notas"
        android:textColor="@color/text_brown_light"
        android:textSize="14sp" />

</LinearLayout>
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/TaskWidgetProvider.kt << 'ZZEOF'
package com.santos.tareas

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.RemoteViews

/** Versión con margen (tarjeta más pequeña que la celda que ocupa). */
open class TaskWidgetProvider : AppWidgetProvider() {

    companion object {
        const val ACTION_TOGGLE = "com.santos.tareas.ACTION_TOGGLE"
        const val EXTRA_TASK_ID = "extra_task_id"

        // Umbral de altura por debajo del cual usamos el layout compacto (sin lista)
        private const val COMPACT_HEIGHT_DP = 100
    }

    protected open val fullLayoutRes: Int = R.layout.widget_task

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (widgetId in appWidgetIds) {
            updateWidget(context, appWidgetManager, widgetId)
        }
    }

    override fun onAppWidgetOptionsChanged(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        newOptions: Bundle
    ) {
        updateWidget(context, appWidgetManager, appWidgetId)
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == ACTION_TOGGLE) {
            val taskId = intent.getLongExtra(EXTRA_TASK_ID, -1L)
            if (taskId != -1L) {
                TaskRepository.toggleDone(context, taskId)
            }
        }
    }

    private fun isCompact(appWidgetManager: AppWidgetManager, widgetId: Int): Boolean {
        val options = appWidgetManager.getAppWidgetOptions(widgetId)
        val minHeight = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_HEIGHT, 0)
        return minHeight in 1 until COMPACT_HEIGHT_DP
    }

    private fun updateWidget(context: Context, appWidgetManager: AppWidgetManager, widgetId: Int) {
        val compact = isCompact(appWidgetManager, widgetId)

        val addIntent = Intent(context, AddEditTaskActivity::class.java)
        val addPendingIntent = PendingIntent.getActivity(
            context, 0, addIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val openIntent = Intent(context, MainActivity::class.java).apply {
            putExtra(MainActivity.EXTRA_SHOW_NOTES, false)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK
        }
        val openPendingIntent = PendingIntent.getActivity(
            context, 2, openIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        if (compact) {
            val views = RemoteViews(context.packageName, R.layout.widget_task_small)
            views.setOnClickPendingIntent(R.id.widget_add_button_small, addPendingIntent)

            val tasks = TaskRepository.getTasks(context)
            val pending = tasks.count { !it.done }
            val summary = when {
                tasks.isEmpty() -> context.getString(R.string.sin_tareas)
                pending == 0 -> context.getString(R.string.todo_completado)
                else -> context.resources.getQuantityStringOrFallback(pending, tasks.size)
            }
            views.setTextViewText(R.id.widget_small_summary, summary)
            views.setOnClickPendingIntent(R.id.widget_small_summary, openPendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        } else {
            val views = RemoteViews(context.packageName, fullLayoutRes)
            views.setOnClickPendingIntent(R.id.widget_add_button, addPendingIntent)
            views.setOnClickPendingIntent(R.id.widget_header, openPendingIntent)

            val serviceIntent = Intent(context, TaskWidgetService::class.java).apply {
                putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
                data = Uri.parse(toUri(Intent.URI_INTENT_SCHEME))
            }
            views.setRemoteAdapter(R.id.widget_list, serviceIntent)
            views.setEmptyView(R.id.widget_list, R.id.widget_empty)

            val toggleIntent = Intent(context, javaClass).apply {
                action = ACTION_TOGGLE
            }
            val togglePendingIntent = PendingIntent.getBroadcast(
                context, 0, toggleIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
            )
            views.setPendingIntentTemplate(R.id.widget_list, togglePendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
            appWidgetManager.notifyAppWidgetViewDataChanged(widgetId, R.id.widget_list)
        }
    }
}

/** Versión sin margen: la tarjeta ocupa toda la celda que reserva. */
class TaskWidgetProviderNoMargin : TaskWidgetProvider() {
    override val fullLayoutRes: Int = R.layout.widget_task_full
}

private fun android.content.res.Resources.getQuantityStringOrFallback(pending: Int, total: Int): String {
    return "$pending de $total pendientes"
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/NoteWidgetProvider.kt << 'ZZEOF'
package com.santos.tareas

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.RemoteViews

/** Versión con margen (tarjeta más pequeña que la celda que ocupa). */
open class NoteWidgetProvider : AppWidgetProvider() {

    companion object {
        private const val COMPACT_HEIGHT_DP = 100
    }

    protected open val fullLayoutRes: Int = R.layout.widget_note

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (widgetId in appWidgetIds) {
            updateWidget(context, appWidgetManager, widgetId)
        }
    }

    override fun onAppWidgetOptionsChanged(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        newOptions: Bundle
    ) {
        updateWidget(context, appWidgetManager, appWidgetId)
    }

    private fun isCompact(appWidgetManager: AppWidgetManager, widgetId: Int): Boolean {
        val options = appWidgetManager.getAppWidgetOptions(widgetId)
        val minHeight = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_HEIGHT, 0)
        return minHeight in 1 until COMPACT_HEIGHT_DP
    }

    private fun updateWidget(context: Context, appWidgetManager: AppWidgetManager, widgetId: Int) {
        val compact = isCompact(appWidgetManager, widgetId)

        val addIntent = Intent(context, AddEditNoteActivity::class.java)
        val addPendingIntent = PendingIntent.getActivity(
            context, 0, addIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        if (compact) {
            val views = RemoteViews(context.packageName, R.layout.widget_note_small)
            views.setOnClickPendingIntent(R.id.widget_note_add_button_small, addPendingIntent)

            val notes = NoteRepository.getNotes(context)
            val summary = if (notes.isEmpty()) {
                context.getString(R.string.sin_notas)
            } else {
                val latest = notes.first()
                latest.title.ifBlank { latest.text }.ifBlank { context.getString(R.string.notas) }
            }
            views.setTextViewText(R.id.widget_note_small_summary, summary)

            val openIntent = Intent(context, MainActivity::class.java).apply {
                putExtra(MainActivity.EXTRA_SHOW_NOTES, true)
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
            val openPendingIntent = PendingIntent.getActivity(
                context, 3, openIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_note_small_summary, openPendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        } else {
            val views = RemoteViews(context.packageName, fullLayoutRes)
            views.setOnClickPendingIntent(R.id.widget_note_add_button, addPendingIntent)

            val openIntent = Intent(context, MainActivity::class.java).apply {
                putExtra(MainActivity.EXTRA_SHOW_NOTES, true)
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
            val openPendingIntent = PendingIntent.getActivity(
                context, 4, openIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_note_header, openPendingIntent)

            val serviceIntent = Intent(context, NoteWidgetService::class.java).apply {
                putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
                data = Uri.parse(toUri(Intent.URI_INTENT_SCHEME))
            }
            views.setRemoteAdapter(R.id.widget_note_list, serviceIntent)
            views.setEmptyView(R.id.widget_note_list, R.id.widget_note_empty)

            val itemOpenIntent = Intent(context, AddEditNoteActivity::class.java)
            val itemOpenPendingIntent = PendingIntent.getActivity(
                context, 1, itemOpenIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
            )
            views.setPendingIntentTemplate(R.id.widget_note_list, itemOpenPendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
            appWidgetManager.notifyAppWidgetViewDataChanged(widgetId, R.id.widget_note_list)
        }
    }
}

/** Versión sin margen: la tarjeta ocupa toda la celda que reserva. */
class NoteWidgetProviderNoMargin : NoteWidgetProvider() {
    override val fullLayoutRes: Int = R.layout.widget_note_full
}
ZZEOF

echo "Dos variantes de widget (con y sin margen) listas. Compilando..."
./gradlew assembleDebug
rm -- "$0"