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
</resources>
ZZEOF

mkdir -p app/src/main/res/xml
cat > app/src/main/res/xml/file_paths.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <cache-path name="backups" path="backups/" />
</paths>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_sort.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24"
    android:tint="@color/white">
    <path
        android:fillColor="@android:color/white"
        android:pathData="M3,18h6v-2L3,16v2zM3,6v2h18L21,6L3,6zM3,13h12v-2L3,11v2z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_export.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="22dp" android:height="22dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/white">
    <path android:fillColor="@android:color/white" android:pathData="M19,12v7L5,19v-7L3,12v7c0,1.1 0.9,2 2,2h14c1.1,0 2,-0.9 2,-2v-7h-2zM13,12.67l2.59,-2.58L17,11.5l-5,5 -5,-5 1.41,-1.41L11,12.67L11,3h2z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/drawable
cat > app/src/main/res/drawable/ic_import.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="22dp" android:height="22dp" android:viewportWidth="24" android:viewportHeight="24" android:tint="@color/white">
    <path android:fillColor="@android:color/white" android:pathData="M19,12v7L5,19v-7L3,12v7c0,1.1 0.9,2 2,2h14c1.1,0 2,-0.9 2,-2v-7h-2zM13,3v9.67l2.59,-2.58L17,11.5l-5,5 -5,-5 1.41,-1.41L11,12.67L11,3h2z" />
</vector>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_main.xml << 'ZZEOF'
<?xml version="1.0" encoding="utf-8"?>
<androidx.drawerlayout.widget.DrawerLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/drawerLayout"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <!-- Contenido principal -->
    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:background="@color/dark_bg">

        <!-- Barra superior -->
        <RelativeLayout
            android:id="@+id/topBar"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_alignParentTop="true"
            android:padding="16dp">

            <ImageView
                android:id="@+id/sidebarButton"
                android:layout_width="44dp"
                android:layout_height="44dp"
                android:layout_alignParentStart="true"
                android:background="@drawable/circle_button_dark"
                android:padding="11dp"
                android:src="@drawable/ic_sidebar" />

            <LinearLayout
                android:id="@+id/tabPill"
                android:layout_width="wrap_content"
                android:layout_height="44dp"
                android:layout_centerHorizontal="true"
                android:orientation="horizontal"
                android:background="@drawable/pill_container_background"
                android:padding="4dp">

                <TextView
                    android:id="@+id/tabNotas"
                    android:layout_width="wrap_content"
                    android:layout_height="match_parent"
                    android:gravity="center"
                    android:paddingHorizontal="22dp"
                    android:text="@string/notas"
                    android:textColor="@color/accent_yellow"
                    android:textStyle="bold"
                    android:background="@drawable/pill_selected_background" />

                <TextView
                    android:id="@+id/tabTareas"
                    android:layout_width="wrap_content"
                    android:layout_height="match_parent"
                    android:gravity="center"
                    android:paddingHorizontal="22dp"
                    android:text="@string/tareas"
                    android:textColor="@color/white" />

            </LinearLayout>

            <ImageView
                android:id="@+id/sortButton"
                android:layout_width="44dp"
                android:layout_height="44dp"
                android:layout_toStartOf="@id/menuButton"
                android:layout_marginEnd="8dp"
                android:background="@drawable/circle_button_dark"
                android:padding="11dp"
                android:src="@drawable/ic_sort" />

            <ImageView
                android:id="@+id/menuButton"
                android:layout_width="44dp"
                android:layout_height="44dp"
                android:layout_alignParentEnd="true"
                android:background="@drawable/circle_button_dark"
                android:padding="11dp"
                android:src="@drawable/ic_list_menu" />

        </RelativeLayout>

        <!-- Lista / estado vacío -->
        <FrameLayout
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:layout_below="@id/topBar"
            android:layout_above="@id/bottomBar">

            <androidx.recyclerview.widget.RecyclerView
                android:id="@+id/recyclerView"
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                android:paddingHorizontal="16dp"
                android:paddingTop="8dp"
                android:clipToPadding="false" />

            <LinearLayout
                android:id="@+id/emptyView"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_gravity="center"
                android:orientation="vertical"
                android:gravity="center"
                android:visibility="gone">

                <ImageView
                    android:layout_width="64dp"
                    android:layout_height="64dp"
                    android:src="@drawable/ic_empty_document" />

                <TextView
                    android:id="@+id/emptyText"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:layout_marginTop="16dp"
                    android:text="@string/sin_notas"
                    android:textColor="@color/dark_text_secondary"
                    android:textSize="15sp" />
            </LinearLayout>

        </FrameLayout>

        <!-- Barra inferior: buscador + botón flotante -->
        <RelativeLayout
            android:id="@+id/bottomBar"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_alignParentBottom="true"
            android:padding="16dp">

            <LinearLayout
                android:layout_width="match_parent"
                android:layout_height="52dp"
                android:layout_toStartOf="@id/fabAdd"
                android:layout_marginEnd="12dp"
                android:orientation="horizontal"
                android:gravity="center_vertical"
                android:background="@drawable/search_bar_background"
                android:paddingHorizontal="16dp">

                <ImageView
                    android:layout_width="20dp"
                    android:layout_height="20dp"
                    android:src="@drawable/ic_search"
                    android:layout_marginEnd="10dp" />

                <EditText
                    android:id="@+id/searchInput"
                    android:layout_width="match_parent"
                    android:layout_height="wrap_content"
                    android:background="@android:color/transparent"
                    android:hint="@string/buscar"
                    android:textColor="@color/white"
                    android:textColorHint="@color/dark_text_secondary"
                    android:textSize="15sp"
                    android:singleLine="true"
                    android:imeOptions="actionSearch" />

            </LinearLayout>

            <ImageView
                android:id="@+id/fabAdd"
                android:layout_width="52dp"
                android:layout_height="52dp"
                android:layout_alignParentEnd="true"
                android:background="@drawable/circle_button_dark"
                android:padding="14dp"
                android:src="@drawable/ic_edit" />

        </RelativeLayout>

    </RelativeLayout>

    <!-- Panel lateral -->
    <LinearLayout
        android:layout_width="280dp"
        android:layout_height="match_parent"
        android:layout_gravity="start"
        android:orientation="vertical"
        android:background="@color/dark_surface"
        android:paddingTop="32dp"
        android:paddingHorizontal="8dp">

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/app_name"
            android:textColor="@color/white"
            android:textSize="22sp"
            android:textStyle="bold"
            android:layout_marginStart="12dp"
            android:layout_marginBottom="24dp" />

        <LinearLayout
            android:id="@+id/drawerAllNotes"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:padding="12dp"
            android:background="?attr/selectableItemBackground">

            <ImageView
                android:layout_width="22dp"
                android:layout_height="22dp"
                android:src="@drawable/ic_folder"
                android:layout_marginEnd="16dp" />

            <TextView
                android:id="@+id/drawerAllNotesLabel"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="@string/todas_las_notas"
                android:textColor="@color/white"
                android:textSize="15sp" />

        </LinearLayout>

        <LinearLayout
            android:id="@+id/drawerTrash"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:padding="12dp"
            android:background="?attr/selectableItemBackground">

            <ImageView
                android:layout_width="22dp"
                android:layout_height="22dp"
                android:src="@drawable/ic_trash_outline"
                android:layout_marginEnd="16dp" />

            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="@string/papelera"
                android:textColor="@color/white"
                android:textSize="15sp" />

        </LinearLayout>

        <View
            android:layout_width="match_parent"
            android:layout_height="1dp"
            android:background="@color/dark_surface_light"
            android:layout_marginVertical="12dp" />

        <LinearLayout
            android:id="@+id/drawerSettings"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:padding="12dp"
            android:background="?attr/selectableItemBackground">

            <ImageView
                android:layout_width="22dp"
                android:layout_height="22dp"
                android:src="@drawable/ic_settings"
                android:layout_marginEnd="16dp" />

            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="@string/ajustes"
                android:textColor="@color/white"
                android:textSize="15sp" />

        </LinearLayout>

    </LinearLayout>

</androidx.drawerlayout.widget.DrawerLayout>
ZZEOF

mkdir -p app/src/main/res/layout
cat > app/src/main/res/layout/activity_settings.xml << 'ZZEOF'
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

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_centerVertical="true"
            android:layout_toEndOf="@id/backButton"
            android:layout_marginStart="16dp"
            android:text="@string/ajustes"
            android:textColor="@color/white"
            android:textSize="20sp"
            android:textStyle="bold" />

    </RelativeLayout>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:padding="16dp">

        <LinearLayout
            android:id="@+id/emptyTrashRow"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:background="@drawable/dark_row_background"
            android:padding="16dp"
            android:layout_marginBottom="12dp">

            <ImageView
                android:layout_width="22dp"
                android:layout_height="22dp"
                android:src="@drawable/ic_trash_outline"
                android:layout_marginEnd="16dp" />

            <TextView
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_weight="1"
                android:text="@string/vaciar_papelera"
                android:textColor="@color/white"
                android:textSize="15sp" />

        </LinearLayout>

        <LinearLayout
            android:id="@+id/exportRow"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:background="@drawable/dark_row_background"
            android:padding="16dp"
            android:layout_marginBottom="12dp">

            <ImageView
                android:layout_width="22dp"
                android:layout_height="22dp"
                android:src="@drawable/ic_export"
                android:layout_marginEnd="16dp" />

            <TextView
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_weight="1"
                android:text="@string/exportar_backup"
                android:textColor="@color/white"
                android:textSize="15sp" />

        </LinearLayout>

        <LinearLayout
            android:id="@+id/importRow"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="horizontal"
            android:gravity="center_vertical"
            android:background="@drawable/dark_row_background"
            android:padding="16dp"
            android:layout_marginBottom="12dp">

            <ImageView
                android:layout_width="22dp"
                android:layout_height="22dp"
                android:src="@drawable/ic_import"
                android:layout_marginEnd="16dp" />

            <TextView
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_weight="1"
                android:text="@string/importar_backup"
                android:textColor="@color/white"
                android:textSize="15sp" />

        </LinearLayout>

        <TextView
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:background="@drawable/dark_row_background"
            android:padding="16dp"
            android:text="@string/acerca_de"
            android:textColor="@color/dark_text_secondary"
            android:textSize="13sp" />

    </LinearLayout>

</LinearLayout>
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/Task.kt << 'ZZEOF'
package com.santos.tareas

data class Task(
    val id: Long,
    var title: String,
    var done: Boolean = false,
    var deleted: Boolean = false,
    var createdAt: Long = System.currentTimeMillis()
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
                    createdAt = if (o.has("createdAt")) o.getLong("createdAt") else o.getLong("id")
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
            tasks[idx] = tasks[idx].copy(done = !tasks[idx].done)
            saveTasks(context, tasks)
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
cat > app/src/main/java/com/santos/tareas/NoteRepository.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/**
 * Almacena las notas en SharedPreferences como JSON. "Eliminar" mueve la nota
 * a la papelera en vez de borrarla directamente.
 */
object NoteRepository {

    private const val PREFS = "notas_prefs"
    private const val KEY_NOTES = "notes_json"
    private const val KEY_NEXT_ID = "next_id"

    private fun getAllRaw(context: Context): MutableList<Note> {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val json = prefs.getString(KEY_NOTES, null)
        if (json == null) {
            val seed = mutableListOf(
                Note(id = nextId(context), title = "Bienvenido a Notas", text = ""),
                Note(id = nextId(context), title = "", text = "Toca + para crear una nota nueva")
            )
            saveNotes(context, seed)
            return seed
        }
        val array = JSONArray(json)
        val list = mutableListOf<Note>()
        for (i in 0 until array.length()) {
            val o = array.getJSONObject(i)
            val attachments = mutableListOf<String>()
            if (o.has("attachments")) {
                val arr = o.getJSONArray("attachments")
                for (j in 0 until arr.length()) attachments.add(arr.getString(j))
            }
            list.add(
                Note(
                    id = o.getLong("id"),
                    title = if (o.has("title")) o.getString("title") else "",
                    text = o.getString("text"),
                    deleted = if (o.has("deleted")) o.getBoolean("deleted") else false,
                    createdAt = if (o.has("createdAt")) o.getLong("createdAt") else 0L,
                    pinned = if (o.has("pinned")) o.getBoolean("pinned") else false,
                    locked = if (o.has("locked")) o.getBoolean("locked") else false,
                    color = if (o.has("color") && !o.isNull("color")) o.getString("color") else null,
                    fontFamily = if (o.has("fontFamily") && !o.isNull("fontFamily")) o.getString("fontFamily") else null,
                    attachments = attachments
                )
            )
        }
        return list
    }

    /** Notas activas (no eliminadas), ancladas primero. */
    fun getNotes(context: Context): MutableList<Note> =
        getAllRaw(context).filter { !it.deleted }
            .sortedByDescending { it.pinned }
            .toMutableList()

    /** Notas en la papelera. */
    fun getDeletedNotes(context: Context): MutableList<Note> =
        getAllRaw(context).filter { it.deleted }.toMutableList()

    private fun saveNotes(context: Context, notes: List<Note>) {
        val array = JSONArray()
        for (n in notes) {
            val o = JSONObject()
            o.put("id", n.id)
            o.put("title", n.title)
            o.put("text", n.text)
            o.put("deleted", n.deleted)
            o.put("createdAt", n.createdAt)
            o.put("pinned", n.pinned)
            o.put("locked", n.locked)
            o.put("color", n.color)
            o.put("fontFamily", n.fontFamily)
            val attArray = JSONArray()
            n.attachments.forEach { attArray.put(it) }
            o.put("attachments", attArray)
            array.put(o)
        }
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .edit()
            .putString(KEY_NOTES, array.toString())
            .apply()
    }

    private fun nextId(context: Context): Long {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val id = prefs.getLong(KEY_NEXT_ID, 1L)
        prefs.edit().putLong(KEY_NEXT_ID, id + 1).apply()
        return id
    }

    fun addNote(context: Context, title: String, text: String): Long {
        val notes = getAllRaw(context)
        val id = nextId(context)
        notes.add(0, Note(id = id, title = title, text = text))
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
        return id
    }

    fun updateNote(context: Context, note: Note) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == note.id }
        if (idx >= 0) {
            notes[idx] = note
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun deleteNote(context: Context, id: Long) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(deleted = true)
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun restoreNote(context: Context, id: Long) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(deleted = false)
            saveNotes(context, notes)
            WidgetUpdater.updateAll(context)
        }
    }

    fun permanentlyDeleteNote(context: Context, id: Long) {
        val notes = getAllRaw(context)
        notes.removeAll { it.id == id }
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
    }

    /** Todas las notas, incluidas las de la papelera (para copia de seguridad). */
    fun getAllIncludingDeleted(context: Context): List<Note> = getAllRaw(context)

    /** Sustituye todos los datos por una lista importada (copia de seguridad). */
    fun replaceAll(context: Context, notes: List<Note>) {
        saveNotes(context, notes)
    }

    fun emptyTrash(context: Context) {
        val notes = getAllRaw(context)
        notes.removeAll { it.deleted }
        saveNotes(context, notes)
        WidgetUpdater.updateAll(context)
    }

    fun setPinned(context: Context, id: Long, pinned: Boolean) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(pinned = pinned)
            saveNotes(context, notes)
        }
    }

    fun setLocked(context: Context, id: Long, locked: Boolean) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(locked = locked)
            saveNotes(context, notes)
        }
    }

    fun setColor(context: Context, id: Long, color: String?) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(color = color)
            saveNotes(context, notes)
        }
    }

    fun setFontFamily(context: Context, id: Long, fontFamily: String?) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            notes[idx] = notes[idx].copy(fontFamily = fontFamily)
            saveNotes(context, notes)
        }
    }

    fun addAttachment(context: Context, id: Long, path: String) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            val updated = notes[idx].attachments.toMutableList().apply { add(path) }
            notes[idx] = notes[idx].copy(attachments = updated)
            saveNotes(context, notes)
        }
    }

    fun removeAttachment(context: Context, id: Long, path: String) {
        val notes = getAllRaw(context)
        val idx = notes.indexOfFirst { it.id == id }
        if (idx >= 0) {
            val updated = notes[idx].attachments.toMutableList().apply { remove(path) }
            notes[idx] = notes[idx].copy(attachments = updated)
            saveNotes(context, notes)
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/BackupManager.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/**
 * Exporta e importa todas las notas y tareas (incluidas las de la papelera)
 * como un único archivo JSON, para hacer copia de seguridad o pasar los
 * datos a otro dispositivo.
 */
object BackupManager {

    fun exportJson(context: Context): String {
        val root = JSONObject()
        root.put("version", 1)
        root.put("exportedAt", System.currentTimeMillis())

        val notesArray = JSONArray()
        for (note in NoteRepository.getAllIncludingDeleted(context)) {
            val o = JSONObject()
            o.put("id", note.id)
            o.put("title", note.title)
            o.put("text", note.text)
            o.put("deleted", note.deleted)
            o.put("createdAt", note.createdAt)
            o.put("pinned", note.pinned)
            o.put("locked", note.locked)
            o.put("color", note.color ?: JSONObject.NULL)
            o.put("fontFamily", note.fontFamily ?: JSONObject.NULL)
            o.put("attachments", JSONArray(note.attachments))
            notesArray.put(o)
        }
        root.put("notes", notesArray)

        val tasksArray = JSONArray()
        for (task in TaskRepository.getAllIncludingDeleted(context)) {
            val o = JSONObject()
            o.put("id", task.id)
            o.put("title", task.title)
            o.put("done", task.done)
            o.put("deleted", task.deleted)
            o.put("createdAt", task.createdAt)
            tasksArray.put(o)
        }
        root.put("tasks", tasksArray)

        return root.toString()
    }

    /** Sustituye todos los datos actuales por los del JSON importado. */
    fun importJson(context: Context, json: String): Boolean {
        return try {
            val root = JSONObject(json)
            val notesArray = root.getJSONArray("notes")
            val notes = mutableListOf<Note>()
            for (i in 0 until notesArray.length()) {
                val o = notesArray.getJSONObject(i)
                notes.add(
                    Note(
                        id = o.getLong("id"),
                        title = o.optString("title", ""),
                        text = o.optString("text", ""),
                        deleted = o.optBoolean("deleted", false),
                        createdAt = o.optLong("createdAt", System.currentTimeMillis()),
                        pinned = o.optBoolean("pinned", false),
                        locked = o.optBoolean("locked", false),
                        color = if (o.isNull("color")) null else o.optString("color"),
                        fontFamily = if (o.isNull("fontFamily")) null else o.optString("fontFamily"),
                        attachments = (0 until o.optJSONArray("attachments")?.length().let { it ?: 0 })
                            .map { idx -> o.getJSONArray("attachments").getString(idx) }
                            .toMutableList()
                    )
                )
            }

            val tasksArray = root.getJSONArray("tasks")
            val tasks = mutableListOf<Task>()
            for (i in 0 until tasksArray.length()) {
                val o = tasksArray.getJSONObject(i)
                tasks.add(
                    Task(
                        id = o.getLong("id"),
                        title = o.optString("title", ""),
                        done = o.optBoolean("done", false),
                        deleted = o.optBoolean("deleted", false),
                        createdAt = o.optLong("createdAt", System.currentTimeMillis())
                    )
                )
            }

            NoteRepository.replaceAll(context, notes)
            TaskRepository.replaceAll(context, tasks)
            WidgetUpdater.updateAll(context)
            true
        } catch (e: Exception) {
            false
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/MainActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.Gravity
import android.widget.PopupMenu
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import com.santos.tareas.databinding.ActivityMainBinding

enum class ViewMode { LIST, CARD, GRID }
enum class SortMode { DATE_DESC, DATE_ASC, ALPHA_ASC, ALPHA_DESC }

class MainActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_SHOW_NOTES = "extra_show_notes"
    }

    private lateinit var binding: ActivityMainBinding
    private lateinit var noteAdapter: NoteAdapter
    private lateinit var taskAdapter: TaskAdapter

    private var showingNotes = true
    private var searchQuery = ""
    private var viewMode = ViewMode.CARD
    private var sortMode = SortMode.DATE_DESC
    private var completedExpanded = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        noteAdapter = NoteAdapter(
            onClick = { note ->
                val intent = Intent(this, AddEditNoteActivity::class.java)
                intent.putExtra(AddEditNoteActivity.EXTRA_NOTE_ID, note.id)
                startActivity(intent)
            },
            onDelete = { note ->
                NoteRepository.deleteNote(this, note.id)
                refresh()
            }
        )

        taskAdapter = TaskAdapter(
            onToggle = { task ->
                if (!task.done) {
                    // Marcamos hecha en su sitio y esperamos a que termine de tacharse
                    // antes de reordenar en secciones (para que se vea la animación).
                    TaskRepository.toggleDone(this, task.id)
                    taskAdapter.onAnimationEnd = {
                        binding.recyclerView.postDelayed({
                            refresh()
                            taskAdapter.onAnimationEnd = null
                        }, 900)
                    }
                    taskAdapter.markDoneInPlace(task.id)
                } else {
                    TaskRepository.toggleDone(this, task.id)
                    refresh()
                }
            },
            onClick = { task ->
                val intent = Intent(this, AddEditTaskActivity::class.java)
                intent.putExtra(AddEditTaskActivity.EXTRA_TASK_ID, task.id)
                startActivity(intent)
            },
            onDelete = { task ->
                TaskRepository.deleteTask(this, task.id)
                refresh()
            },
            onHeaderToggle = {
                completedExpanded = !completedExpanded
                refresh()
            }
        )

        binding.tabNotas.setOnClickListener { selectTab(notes = true) }
        binding.tabTareas.setOnClickListener { selectTab(notes = false) }

        binding.fabAdd.setOnClickListener {
            if (showingNotes) {
                startActivity(Intent(this, AddEditNoteActivity::class.java))
            } else {
                startActivity(Intent(this, AddEditTaskActivity::class.java))
            }
        }

        binding.menuButton.setOnClickListener { showViewModeMenu() }
        binding.sortButton.setOnClickListener { showSortMenu() }

        binding.sidebarButton.setOnClickListener {
            binding.drawerLayout.openDrawer(Gravity.START)
        }
        binding.drawerAllNotes.setOnClickListener {
            binding.drawerLayout.closeDrawer(Gravity.START)
        }
        binding.drawerTrash.setOnClickListener {
            binding.drawerLayout.closeDrawer(Gravity.START)
            startActivity(Intent(this, TrashActivity::class.java))
        }
        binding.drawerSettings.setOnClickListener {
            binding.drawerLayout.closeDrawer(Gravity.START)
            startActivity(Intent(this, SettingsActivity::class.java))
        }

        binding.searchInput.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                searchQuery = s?.toString().orEmpty()
                refresh()
            }
            override fun afterTextChanged(s: Editable?) {}
        })

        applyViewMode()
        val showNotes = intent.getBooleanExtra(EXTRA_SHOW_NOTES, true)
        selectTab(notes = showNotes)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        if (intent.hasExtra(EXTRA_SHOW_NOTES)) {
            selectTab(notes = intent.getBooleanExtra(EXTRA_SHOW_NOTES, true))
        }
    }

    override fun onResume() {
        super.onResume()
        refresh()
    }

    private fun showViewModeMenu() {
        val popup = PopupMenu(this, binding.menuButton)
        popup.menu.add(0, 0, 0, getString(R.string.vista_lista)).setIcon(R.drawable.ic_view_list)
        popup.menu.add(0, 1, 1, getString(R.string.vista_tarjeta)).setIcon(R.drawable.ic_view_card)
        popup.menu.add(0, 2, 2, getString(R.string.vista_cuadricula)).setIcon(R.drawable.ic_view_grid)
        MenuIconHelper.forceShowIcons(popup)
        popup.setOnMenuItemClickListener { item ->
            viewMode = when (item.itemId) {
                0 -> ViewMode.LIST
                2 -> ViewMode.GRID
                else -> ViewMode.CARD
            }
            applyViewMode()
            true
        }
        popup.show()
    }

    private fun showSortMenu() {
        val popup = PopupMenu(this, binding.sortButton)
        popup.menu.add(0, 0, 0, getString(R.string.fecha_reciente))
        popup.menu.add(0, 1, 1, getString(R.string.fecha_antigua))
        popup.menu.add(0, 2, 2, getString(R.string.alfabetico_az))
        popup.menu.add(0, 3, 3, getString(R.string.alfabetico_za))
        popup.setOnMenuItemClickListener { item ->
            sortMode = when (item.itemId) {
                1 -> SortMode.DATE_ASC
                2 -> SortMode.ALPHA_ASC
                3 -> SortMode.ALPHA_DESC
                else -> SortMode.DATE_DESC
            }
            refresh()
            true
        }
        popup.show()
    }

    private fun applyViewMode() {
        if (viewMode == ViewMode.GRID) {
            val gridManager = GridLayoutManager(this, 2)
            gridManager.spanSizeLookup = object : GridLayoutManager.SpanSizeLookup() {
                override fun getSpanSize(position: Int): Int {
                    return if (!showingNotes && taskAdapter.isHeaderAt(position)) 2 else 1
                }
            }
            binding.recyclerView.layoutManager = gridManager
        } else {
            binding.recyclerView.layoutManager = LinearLayoutManager(this)
        }
        val flat = viewMode == ViewMode.LIST
        noteAdapter.flatStyle = flat
        taskAdapter.flatStyle = flat
        refresh()
    }

    private fun selectTab(notes: Boolean) {
        showingNotes = notes
        binding.tabNotas.setBackgroundResource(if (notes) R.drawable.pill_selected_background else 0)
        binding.tabTareas.setBackgroundResource(if (!notes) R.drawable.pill_selected_background else 0)
        binding.tabNotas.setTextColor(
            resources.getColor(if (notes) R.color.accent_yellow else R.color.white, theme)
        )
        binding.tabTareas.setTextColor(
            resources.getColor(if (!notes) R.color.accent_yellow else R.color.white, theme)
        )
        binding.recyclerView.adapter = if (notes) noteAdapter else taskAdapter
        binding.emptyText.text = getString(if (notes) R.string.sin_notas else R.string.sin_tareas)
        binding.drawerAllNotesLabel.text = getString(if (notes) R.string.todas_las_notas else R.string.todas_las_tareas)
        applyViewMode()
    }

    private fun <T> sorted(
        items: List<T>,
        dateOf: (T) -> Long,
        titleOf: (T) -> String
    ): List<T> {
        return when (sortMode) {
            SortMode.DATE_DESC -> items.sortedByDescending { dateOf(it) }
            SortMode.DATE_ASC -> items.sortedBy { dateOf(it) }
            SortMode.ALPHA_ASC -> items.sortedBy { titleOf(it).lowercase() }
            SortMode.ALPHA_DESC -> items.sortedByDescending { titleOf(it).lowercase() }
        }
    }

    private fun refresh() {
        if (showingNotes) {
            var notes = NoteRepository.getNotes(this).filter {
                searchQuery.isBlank() ||
                    it.title.contains(searchQuery, ignoreCase = true) ||
                    HtmlUtils.toPlainText(it.text).contains(searchQuery, ignoreCase = true)
            }
            notes = sorted(notes, { it.createdAt }, { it.title.ifBlank { HtmlUtils.toPlainText(it.text) } })
            // Las notas ancladas siempre van primero, dentro de eso respetan el orden elegido
            notes = notes.sortedByDescending { it.pinned }
            noteAdapter.submitList(notes)
            binding.emptyView.visibility = if (notes.isEmpty()) android.view.View.VISIBLE else android.view.View.GONE
        } else {
            val allTasks = TaskRepository.getTasks(this).filter {
                searchQuery.isBlank() || it.title.contains(searchQuery, ignoreCase = true)
            }
            val pending = sorted(allTasks.filter { !it.done }, { it.createdAt }, { it.title })
            val completed = sorted(allTasks.filter { it.done }, { it.createdAt }, { it.title })

            val sections = mutableListOf<TaskListItem>()
            if (pending.isNotEmpty()) {
                sections.add(TaskListItem.Header(getString(R.string.pendiente_de_completar), collapsible = false, expanded = true))
                sections.addAll(pending.map { TaskListItem.Row(it) })
            }
            if (completed.isNotEmpty()) {
                sections.add(TaskListItem.Header(getString(R.string.completado), collapsible = true, expanded = completedExpanded))
                if (completedExpanded) {
                    sections.addAll(completed.map { TaskListItem.Row(it) })
                }
            }
            taskAdapter.submitSections(sections)
            binding.emptyView.visibility = if (allTasks.isEmpty()) android.view.View.VISIBLE else android.view.View.GONE
        }
    }
}
ZZEOF

mkdir -p app/src/main/java/com/santos/tareas
cat > app/src/main/java/com/santos/tareas/SettingsActivity.kt << 'ZZEOF'
package com.santos.tareas

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.FileProvider
import com.santos.tareas.databinding.ActivitySettingsBinding
import java.io.File

class SettingsActivity : AppCompatActivity() {

    companion object {
        private const val REQUEST_IMPORT_BACKUP = 300
    }

    private lateinit var binding: ActivitySettingsBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySettingsBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.backButton.setOnClickListener { finish() }

        binding.emptyTrashRow.setOnClickListener {
            android.app.AlertDialog.Builder(this)
                .setTitle(R.string.vaciar_papelera)
                .setMessage(R.string.confirmar_vaciar_papelera)
                .setPositiveButton(R.string.eliminar_definitivamente) { _, _ ->
                    NoteRepository.emptyTrash(this)
                    TaskRepository.emptyTrash(this)
                    Toast.makeText(this, R.string.papelera, Toast.LENGTH_SHORT).show()
                }
                .setNegativeButton(android.R.string.cancel, null)
                .show()
        }

        binding.exportRow.setOnClickListener { exportBackup() }
        binding.importRow.setOnClickListener {
            android.app.AlertDialog.Builder(this)
                .setTitle(R.string.importar_backup)
                .setMessage(R.string.confirmar_importar_backup)
                .setPositiveButton(android.R.string.ok) { _, _ -> pickBackupFile() }
                .setNegativeButton(android.R.string.cancel, null)
                .show()
        }
    }

    private fun exportBackup() {
        try {
            val json = BackupManager.exportJson(this)
            val dir = File(cacheDir, "backups").apply { mkdirs() }
            val file = File(dir, "notas_backup.json")
            file.writeText(json)

            val uri: Uri = FileProvider.getUriForFile(this, "$packageName.fileprovider", file)
            val intent = Intent(Intent.ACTION_SEND).apply {
                type = "application/json"
                putExtra(Intent.EXTRA_STREAM, uri)
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }
            startActivity(Intent.createChooser(intent, getString(R.string.exportar_backup)))
            Toast.makeText(this, R.string.backup_exportado, Toast.LENGTH_SHORT).show()
        } catch (e: Exception) {
            Toast.makeText(this, R.string.backup_error, Toast.LENGTH_SHORT).show()
        }
    }

    private fun pickBackupFile() {
        val intent = Intent(Intent.ACTION_GET_CONTENT).apply { type = "*/*" }
        startActivityForResult(intent, REQUEST_IMPORT_BACKUP)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode != REQUEST_IMPORT_BACKUP || resultCode != RESULT_OK) return
        val uri = data?.data ?: return
        try {
            val json = contentResolver.openInputStream(uri)?.bufferedReader()?.use { it.readText() }
            if (json != null && BackupManager.importJson(this, json)) {
                Toast.makeText(this, R.string.backup_importado, Toast.LENGTH_SHORT).show()
            } else {
                Toast.makeText(this, R.string.backup_error, Toast.LENGTH_SHORT).show()
            }
        } catch (e: Exception) {
            Toast.makeText(this, R.string.backup_error, Toast.LENGTH_SHORT).show()
        }
    }
}
ZZEOF

echo "Orden por fecha/alfabetico y copia de seguridad listos. Compilando..."
./gradlew assembleDebug
rm -- "$0"